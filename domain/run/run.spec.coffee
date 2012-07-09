require 'should'
run = require './run'

# Given 

fn1 = (next) -> next null, 1
fn2 = (next) -> next null, 2
fn3 = (next) -> next null, 3

# Then 

run [fn1, fn2, fn3], (err, result) -> 
  result.should.eql [1, 2, 3]