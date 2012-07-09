async = require 'async'

chain = ({input, tasks, beforeEach, afterEach, error, out}) -> 

  throw new Error "chain: No tasks" unless tasks?
  throw new Error "chain: No 'out' function supplied" unless out?

  # before and after each
  if beforeEach? and afterEach?
    newTasks = []
    for task in tasks 
      newTasks.push beforeEach
      newTasks.push task
      newTasks.push afterEach 
    tasks = newTasks

  # before each
  else if beforeEach?
    newTasks = []
    for task in tasks 
      newTasks.push beforeEach 
      newTasks.push task
    tasks = newTasks

  # after each
  else if afterEach?
    newTasks = []
    for task in tasks 
      newTasks.push task
      newTasks.push afterEach 
    tasks = newTasks


  # first
  tasks.unshift( (next) -> next null, input )

  # waterfall  
  async.waterfall tasks, (err, result) -> 
    if error? and err? 
      error err
    else if err?
      #default error handling
    else
      out result


module.exports = chain