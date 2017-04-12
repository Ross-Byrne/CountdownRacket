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
      (if (= s 1) #t #f) ; if the list is empty and s = 1, it's valid rpn
      (if (= (car e) 1) ; check next item in pattern is 1 or -1
          (valid-rpn? (cdr e) (+ s 1)) ; if number, add one to stack and pass cdr of list into func again
          (if (< (- s 1) 1) ; if operator, check that stack wont end up less then 1
              #f ; stack went less then 1, not valid
              (valid-rpn? (cdr e) (- s 1)) ; if operator, take one from stack and pass cdr of list into func again
              )
          )))

; filters all of the possible rpn patterns
; runs each one through valid-rpn? function
; and only returns the pattern if it is valid (if valid-rpn? returns #t)
(define valid-rpn-list (filter (lambda (l) (equal? (valid-rpn? l) #t)) all-rpn-patterns))
(length valid-rpn-list)

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
(define (evaluate-rpn pattern-list oper-list num-list [s (list )])
  (if (and (null? oper-list) (null? num-list))
      s
      (if (= (length s) 1)
          s
          (if (= (car pattern-list) 1)
          (evaluate-rpn (cdr pattern-list) oper-list (cdr num-list) (append s (car num-list)))
          (evaluate-rpn (cdr pattern-list) (cdr oper-list) num-list (append s ((car oper-list) (last s) (last (last s)))))))
          )
      )

;(evaluate-rpn (car valid-rpn-list) (car (car all-5-opers-all-6-nums)) (cdr (car all-5-opers-all-6-nums)))
