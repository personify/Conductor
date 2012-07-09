async = require 'async'

series = (services, next) -> async.series services, next 


module.exports = series