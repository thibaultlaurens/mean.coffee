base =
  ENV: process.env.NODE_ENV || 'development'
  PORT: process.env.PORT || 3000
  LOGPATH: "mean.coffee.log"
  COOKIE_SECRET: "thisisthesecretforthesession"

dev =
  DBURL: "mongodb://localhost/meancoffeedb"

prod =
  DBURL: "mongodb://localhost/meancoffeedb"

mergeConfig = (config) ->
  for key, val of config
    base[key] = val
  base

module.exports = ( ->
  switch base.ENV
    when 'development' then return mergeConfig(dev)
    when 'production' then return mergeConfig(prod)
    else return mergeConfig(dev)
)()



