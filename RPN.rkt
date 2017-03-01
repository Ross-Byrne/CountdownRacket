#lang racket

; Getting the hang of Reverse Polish Notation

; Example Equation: (3 + 8) * 3

; Racket version
(* (+ 3 8) 3)

; Reverse polish notation version
; (38+3*)

; Function to evaluate reverse polish notation
(define (rpnEval l)
  (if(list? l)
     "It's a list!"
     null)
  )

; Testing function
(rpnEval 6)
(rpnEval (list 1 2 3 4))