// from: https://www.hillelwayne.com/post/knights-knaves/

abstract sig Person {}

sig Knight extends Person {}
sig Knave extends Person {}

pred Puzzle {
  #Person = 2
  some disj A, B :Person {
    A in Knight <=> (A + B) in Knave
  }
}

run Puzzle for 10
run Puzzle for 11
run Puzzle for 12
