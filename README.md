mean.coffee
===========

WORK IN PROGRESS

(Mongo, Express, Angular, Node) - A Simple, Scalable and Easy starting point for full stack javascript web development
inspired by http://mean.io/


### How to mean.coffee

- Install prerequisites
    - npm install -g coffee-script
    - npm install -g bower
    - npm install -g gulp

- Install dependencies:
    - npm install (will bower install as well)

- Run the server
    - npm start || coffee server.coffee

- Run gulp
    - npm run gulp (for dev)
    - npm run gulp-build (for prod)


### Differences compared to mean.io:

- everything is written with coffeescript
- use gulp instead of grunt
- don't use any template engine:
    - the node.js server only serve static html files
    - angularJS will do the rest (routing + calling the REST API)
- code to manipulate model objects is in the service folder (instead of app/controller in mean.io)
- extra stuff:
    - winston (logger) - lib/logger.coffee
    - memwatch (for memory leaks) - server.coffee
    - nodetime (monitoring) - server.coffee


### TODO

- forever script + git hook for custom deployment
- procfile for heroku deployment
- gulp dev/prod distinct folders
- remove gulp trick for jquery loaded first
