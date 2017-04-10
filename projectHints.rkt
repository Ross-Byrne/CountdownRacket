#lang racket

; cut out one -1 and two 1s
(define start-perm (list -1 -1 -1 -1 1 1 1 1))

; Permutations must have 1 1 at the start. Must end with -1.
(define x (remove-duplicates (permutations start-perm)))

; function that adds 11 to the start and -1 to the end of all permutations
(define (make-rpn l)
  (append (list 1 1) l (list -1)))

; add 1 1 to start of all permutations. add -1 to the end of all permutations
(map make-rpn x)

; function that evaluates if rpn is valid.
; for every operator, there must be 2 nums on stack.
; at the end, only one num should be on stack.
(define (valid-rpn? e [s 0])
  (if (null? e)
      (if (= s 1) #t #f)
      (if (= (car e) 1)
          (valid-rpn? (cdr e) (+ 1 s)) ; if number, add one to stack and pass cdr of list into func again
          (valid-rpn? (cdr e) (- 1 s)) ; if operator, take one from stack and pass cdr of list into func again
          )))

; so if car e = -1 take 2 off the stack and
; put up one on (or take off one)
; then call valid-rpn? function with cdr e again. (valid-rpn> (cdr e))

(map valid-rpn? (map make-rpn x))
;(valid-rpn? (list 1 1 -1 1 -1 1 1 -1 -1))

; map a new func and (map make-rpn x)
; the new function passes the list passed from the mapping
; to valid-rpn? and checks if true or false, if true, save that list to a list of all
; valid rpn patterns