require 'should'
chain = require '../chain/chain'

# given some functions

fn1 = (str, next) -> str = str or ""; next null, str += "1"
fn2 = (str, next) -> next null, str += "2"
fn3 = (str, next) -> next null, str += "3"

describe "chain", ->

  it "can chain functions", (done) ->  

    chain 
      tasks: [fn1, fn2, fn3]
      out: (result) -> 
        result.should.equal "123"
        done()

  it "can chain functions with input", (done) ->
  
    chain 
      input: "1"
      tasks: [fn1, fn2, fn3]
      out: (result) -> 
        result.should.equal "1123"
        done()

  it "can insert function beforeEach", (done) ->

    chain 
      tasks: [fn1, fn2, fn3]
      beforeEach: (str, next) -> 
          str = str or ""
          next null, str += "<"
      out: (result) -> 
        result.should.equal "<1<2<3"
        done()

  it "can insert function afterEach", (done) ->

    chain 
      tasks: [fn1, fn2, fn3]
      afterEach: (str, next) -> 
        str = str or ""
        next null, str += ">"
      out: (result) ->
        result.should.equal "1>2>3>" 
        done()

  it "can insert functions before & after each", (done) ->

    chain 
      tasks: [fn1, fn2, fn3]
      beforeEach: (str, next) -> 
          str = str or ""
          next null, str += "<"
      afterEach: (str, next) -> 
        str = str or ""
        next null, str += ">"
      out: (result) -> 
        result.should.equal "<1><2><3>"
        done()

  it "can specify an error policy", (done) ->

    fnErr = (x, next) -> next( new Error 'oops' )
    chain 
      tasks: [fn1, fnErr, fn3]
      error: (err) -> 
        err.message.should.equal "oops"
        done()
      out: ->
