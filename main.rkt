#lang racket

; cut out one -1 and two 1s
(define start-perm (list -1 -1 -1 -1 1 1 1 1))

; Permutations must have 1 1 at the start. Must end with -1.
(define x (remove-duplicates (permutations start-perm)))

; function that adds 11 to the start and -1 to the end of all permutations
(define (make-rpn l)
  (append (list 1 1) l (list -1)))

; add 1 1 to start of all permutations. add -1 to the end of all permutations
(define all-rpn-patterns (map make-rpn x))

; Define a list of all perms of 6 numbers
; Will hard code 6 numbers for now
(define number-list (list 1 2 2 4 1 6))

;(length (permutations L)) ; without removing dupes
(length (remove-duplicates (permutations number-list))) ; removes the dupes

; define list of all possible operator combinations
; Do using qartisan product

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

; filters all of the possible rpn patterns
; runs each one through valid-rpn? function
; and only returns the pattern if it is valid (if valid-rpn? returns #t)
(define valid-rpn-list (filter (lambda (l) (equal? (valid-rpn? l) #t)) all-rpn-patterns))

; display iist of valid rpn patterns
;valid-rpn-list




