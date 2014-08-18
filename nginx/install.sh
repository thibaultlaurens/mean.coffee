#!/bin/bash
#
NGINX_VERSION=1.6.1
PCRE_VERSION=8.35
#original openssl 1.0.1e
OPENSSL_VERSION=1.0.1i

rm -rf "$NGINX_VERSION" download var
nginx_tarball_url=http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz
#pcre_tarball_url=ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-${PCRE_VERSION}.tar.bz2
pcre_tarball_url=http://garr.dl.sourceforge.net/project/pcre/pcre/${PCRE_VERSION}/pcre-${PCRE_VERSION}.tar.bz2
openssl_tarball_url=http://www.openssl.org/source/openssl-${OPENSSL_VERSION}.tar.gz

this_path=`pwd`
echo THIS PATH "$this_path"
temp_dir="$this_path"/download
echo TEMP DIR "$temp_dir"
mkdir -p "$temp_dir";

cleanup() {
  echo "Cleaning up $temp_dir"
  cd /
  rm -rf "$temp_dir"
}

trap cleanup EXIT

script_dir=$(cd $(dirname $0); pwd)

untarring_dir=$temp_dir/nginx-"$NGINX_VERSION"
nginx_binary_drop_dir="$this_path"/"$NGINX_VERSION"

cd $temp_dir
echo "Temp dir: $temp_dir"

echo "Downloading $nginx_tarball_url"
curl $nginx_tarball_url | tar zx

# echo "Downloading $pcre_tarball_url"
# (cd nginx-${NGINX_VERSION} && curl $pcre_tarball_url | tar zx)

# echo "Downloading $openssl_tarball_url"
# (cd nginx-${NGINX_VERSION} && curl $openssl_tarball_url | tar zx)

#buildpack --with-pcre=pcre-""$PCRE_VERSION""
#--with-openssl=openssl-$OPENSSL_VERSION \
#homebrew "--with-pcre"
#https://github.com/Homebrew/homebrew/blob/master/Library/Formula/nginx.rb

OPENSSL="/usr/local/Cellar/openssl/${OPENSSL_VERSION}"
PCRE="/usr/local/Cellar/pcre/${PCRE_VERSION}"
cc_opt="-I${PCRE}/include -I${OPENSSL}/include/openssl"
ld_opt="-L${PCRE}/lib -L${OPENSSL}/lib"
#--with-cc-opt=#{cc_opt}
#--with-ld-opt=#{ld_opt}

log_path="$this_path"/var/log
run_path="$this_path"/var/run

mkdir -p "$log_path";
mkdir -p "$run_path";
mkdir -p "$run_path"/nginx/client_body_temp;
mkdir -p "$run_path"/nginx/proxy_temp;
mkdir -p "$run_path"/nginx/uwsgi_temp;
mkdir -p "$run_path"/nginx/scgi_temp;

ccopt="--with-cc-opt=${cc_opt}"
echo $ccopt
echo -e "\n"
ldopt="--with-ld-opt=${ld_opt}"
echo $ldopt
echo -e "\n"

echo making NGINX $nginx_binary_drop_dir
mkdir -p $nginx_binary_drop_dir


buildStr=$(cat <<EOF
--prefix=${nginx_binary_drop_dir} \
--with-http_ssl_module \
--with-pcre \
--with-ipv6 \
--pid-path=$run_path/nginx.pid \
--lock-path=$run_path/nginx.lock \
--http-client-body-temp-path=$run_path/nginx/client_body_temp \
--http-proxy-temp-path=$run_path/nginx/proxy_temp \
--http-fastcgi-temp-path=$run_path/nginx/fastcgi_temp \
--http-uwsgi-temp-path=$run_path/nginx/uwsgi_temp \
--http-scgi-temp-path=$run_path/nginx/scgi_temp \
--http-log-path=$log_path/nginx/access.log \
--error-log-path=$log_path/nginx/error.log \
--with-http_gzip_static_module \
--with-http_gunzip_module
EOF)


count(){
  #echo Function name:  ${FUNCNAME}"
  echo -e "\n"
  echo "Count: $#"
  echo -e "\n"
  echo "args: '$@'"
  echo -e "\n"
  buildStr=$@
}

#being ccopt and ldopt are so complex, the only clean way to inject them as single arguments
#was to use the count function
echo CONFIGURE OPTIONS: $(count $buildStr "${ccopt}" "${ldopt}")

# mkdir -p $untarring_dir
cd $untarring_dir
echo in $untarring_dir
# echo $(ls -la)


#ln -s sbin/nginx $nginx_binary_drop_dir/bin

#cofig
./configure $buildStr

echo "Which sort?"
if [ `which gsort` ];then
  echo using gsort
  echo -e "\n"
  sorter=gsort #use gnu sort from brew
else
  echo using sort
  sorter=sort
fi
echo -e "\n"

#http://stackoverflow.com/questions/16989598/bash-comparing-version-numbers
function version_gt() { test "$(echo "$@" | tr " " "\n" | "$sorter" -V | tail -n 1)" == "$1"; }
#hack only needed for makefile prior to 1.7.2 nginx
if version_gt 1.7.2 $NGINX_VERSION; then
  echo "HACKING Makefile as nginx $1 < 1.7.2"
  sed -i.bak s/\-Werror//g "$untarring_dir"/objs/Makefile
fi
make install

mkdir "$nginx_binary_drop_dir"/bin;
ln -s "$nginx_binary_drop_dir"/sbin/nginx "$nginx_binary_drop_dir"/bin/nginx;

mv "$nginx_binary_drop_dir"/conf/nginx.conf "$nginx_binary_drop_dir"/conf/orig_nginx.conf;
cp -f "$this_path"/ournginx.conf "$nginx_binary_drop_dir"/conf/nginx.conf
