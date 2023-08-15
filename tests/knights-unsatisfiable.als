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

// set the allowed steps here so that puzzle is unsatisfiable.
run Puzzle for 1
