#lang racket

; cut out one -1 and two 1s
(define start-perm (list -1 -1 -1 -1 1 1 1 1))

; List of all operators that can be used
(define operators (list '+ '- '* '/))

; Permutations must have 1 1 at the start. Must end with -1.
(define x (remove-duplicates (permutations start-perm)))

; function that adds 11 to the start and -1 to the end of all permutations
(define (make-rpn l)
  (append (list 1 1) l (list -1)))

; add 1 1 to start of all permutations. add -1 to the end of all permutations
(define all-rpn-patterns (map make-rpn x))

; define list of all possible operator combinations
; using cartesian product
(define all-5-operators (cartesian-product operators operators operators operators operators))

; Define a list of all perms of 6 numbers
; Will hard code 6 numbers for now
(define number-list (list 1 2 2 4 1 6))

; define a list of all perms of a 6 number list without dupes
(define all-6-numbers (remove-duplicates (permutations number-list))) ; removes the dupes

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

; display list of valid rpn patterns
;valid-rpn-list

; define a list of all the combinations of 5 operators
; and 6 numbers
(define all-5-opers-all-6-nums (cartesian-product all-5-operators all-6-numbers))

(car all-5-opers-all-6-nums)

; function that evaluates valid rpn using valid patterns
; adapted from valid-rpn? function
; Need to pass in, the valid rpn pattern,
; the list of operators, the list of numbers
; and the stack that is used to keep track of evaluation
(define (evaluate-rpn e [s (null)])
  (if (null? e)
      (if (= s 1) #t #f)
      (if (= (car e) 1)
          (valid-rpn? (cdr e) (+ 1 s)) ; if number, add one to stack and pass cdr of list into func again
          (valid-rpn? (cdr e) (- 1 s)) ; if operator, take one from stack and pass cdr of list into func again
          )))


