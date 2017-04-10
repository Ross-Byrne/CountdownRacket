#lang racket

; Getting the hang of Reverse Polish Notation

; Example Equation: (3 + 8) * 3

; Racket version
(* (+ 3 8) 3)

; Reverse polish notation version
; (38+3*)

; Function to evaluate reverse polish notation
(define (rpnEval l)
  (if (> (length l) 1)
     ((car l) (cadr l) (cadr (cdr l)))
      l
   )
)

; Testing function
(rpnEval (list * 4 2))
;(rpnEval (reverse (list 3 8 + 3 *)))
