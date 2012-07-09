async = require 'async'

run = (services, next) -> async.parallel services, next 


module.exports = run