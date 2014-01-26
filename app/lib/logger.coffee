winston = require('winston')
fs = require('fs')
config = require('./config')
logPath = config.LOGPATH

if !fs.existsSync(logPath)
  fs.openSync(logPath, 'w')

myCustomLevels =
  levels:
    debug: 0
    info: 1
    warn: 2
    error: 3

  colors:
    debug: 'grey'
    info: 'green'
    warn: 'orange'
    error: 'red'

level = if config.ENV == 'development' then 'debug' else 'info'

logger = new (winston.Logger)
  transports: [
    new (winston.transports.Console)
      level: level
      colorize: true
    new (winston.transports.File)
      filename: logPath
      level: level
  ],
  levels: myCustomLevels.levels

winston.addColors myCustomLevels.colors
logger.info "Logger configured"

module.exports = logger


