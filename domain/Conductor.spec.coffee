{run, chain, series} = require './Conductor' 
require 'should'

##
## run
##

# Given 

fn1 = (next) -> next null, 1
fn2 = (next) -> next null, 2
fn3 = (next) -> next null, 3

# Then 

run [fn1, fn2, fn3], (err, result) -> 
  result.should.eql [1, 2, 3]

##
## chain
##

# Given

fn1 = (next) -> next null, 1
fn2 = (x, next) -> next null, x + 2
fn3 = (x, next) -> next null, x + 3

# Then 

chain [fn1, fn2, fn3], (err, result) -> 
  result.should.equal 6

##
## series
##

# Given 

fn1 = (next) -> next null, 1
fn2 = (next) -> next null, 2
fn3 = (next) -> next null, 3

# Then 

series [fn1, fn2, fn3], (err, result) -> 
  result.should.eql [1, 2, 3]