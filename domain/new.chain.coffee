_ = require 'mori'

console.log _

tasks = [
  (v, next) -> setTimeout (-> next _.conj(v, "one")), 25 
  (v, next) -> setTimeout (-> next _.conj(v, "two")), 10 
  (v, next) -> setTimeout (-> next _.conj(v, "three")), 0

]

foo =
  fu: "fu"
  bar: "bar"

foo2 =
  fu: "fubard"
  bar: "bar"

#bar = _.prim_seq [1,2]

#foo  = _.set(_.hash_map 'foo', _.hash_map('baz', 'bang'), 'bar', 2)
#foo2 = _.set(_.hash_map 'foo', 15, 'bar', 3)
#console.log bar.toString()

#foo = _.prim_seq(foo)
#console.log foo.toString()

#console.log _.difference(_.primary_seq(foo, foo2)).toString()

###
foo = _.pipeline _.vector("zero"), _.vector(tasks)

console.log foo

chain = ({input, tasks}) ->

  next = tasks[1]
  tasks[0](zero, next)

one(zero, two())

three(two(one(zero)))

three = three(two)
two   = two(one, three)
one   = one(zero, two)


three(two(one,)

comp = one(zero, two(one, three(two)))

next = (f) -> console.log f.toString

_.map next, tasks


console.log tasks.toString()
#next = (v) -> 


#dos = two uno()

#console.log dos().toString()

#foo = _.iterate next, _.vector(one, two)

#console.log foo.toString()

#bar = _.vector(1,2,3)

#console.log bar.toString()

foo = _.pipeline _.vector(),
  (v) -> return _.conj(v, 4) 
  (v) -> return _.conj(v, 2) 



console.log foo.toString()