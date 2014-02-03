mean.coffee
===========

WORK IN PROGRESS

(Mongo, Express, Angular, Node) - A Simple, Scalable and Easy starting point for full stack javascript web development
inspired by http://mean.io/


### How to mean.coffee

- Install prerequisites
        npm install -g coffee-script
        npm install -g bower
        npm install -g gulp

- Install dependencies:
        npm install
        bower install

- Run the server
        coffee server.coffee


### Differences compared to mean.io:

- everything is written with coffeescript
- use gulp instead of grunt
- don't use any template engine:
    - the node.js server only serve static html files
    - angularJS will do the rest (routing + calling the REST API)
- code to manipulate model objects are in the service folder (instead of app/controller in mean.io)
- configuration file is in lib/config.coffee
- little extra
    - winston (logger) - lib/logger.coffee
    - memwatch (for memory leaks) - server.coffee
    - nodetime (monitoring) - server.coffee


### TODO

- TEST with mocha/karma
- forever script + git hook for custom deployment
- procfile for heroku deployment
