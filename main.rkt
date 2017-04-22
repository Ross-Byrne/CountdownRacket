#lang racket

"Starting..." ; Feedback for users, so they know program has started
(newline)

; cut out one -1 and two 1s
(define start-perm (list -1 -1 -1 -1 1 1 1 1))

; List of all operators that can be used
(define operators (list + - * /))

; Permutations must have 1 1 at the start. Must end with -1.
(define x (remove-duplicates (permutations start-perm)))

; function that adds 11 to the start and -1 to the end of all permutations
(define (make-rpn l)
  (append (list 1 1) l (list -1)))

; add 1 1 to start of all permutations. add -1 to the end of all permutations
(define all-rpn-patterns (map make-rpn x))

; The target number (must be between 101 and 999 inclusive)
(define target-number 424)

; define list of all possible operator combinations
; using cartesian product
(define all-5-operators (cartesian-product operators operators operators operators operators))

; Define a list of all perms of 6 numbers
; Will hard code 6 numbers for now
(define number-list (list 100 25 10 2 2 1))

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
;(length valid-rpn-list)

; display list of valid rpn patterns
;valid-rpn-list

; define a list of all the combinations of 5 operators
; and 6 numbers
;(define all-5-opers-all-6-nums (cartesian-product all-5-operators all-6-numbers))

; That is all rpn patterns X all 5 operators X all 6 numbers
; This requires 1GB of memory allocated
; Is a list of 3 lists. First list is rpn pattern, second list is operators list and third list is numbers list
(define all-5-opers-all-6-nums (cartesian-product valid-rpn-list all-5-operators all-6-numbers))

;(length valid-rpn-list)
;(car all-5-opers-all-6-nums)
;(first (car all-5-opers-all-6-nums))
;(second (car all-5-opers-all-6-nums))
;(third (car all-5-opers-all-6-nums))

; ////////////////////////////////////////////////// RPN Evaluation Function /////////////////////////////////////////////////////////
; function that evaluates valid rpn using valid patterns
; adapted from valid-rpn? function
; Need to pass in, the valid rpn pattern,
; the list of operators, the list of numbers
; and the stack that is used to keep track of evaluation

; when evaluating, a list is used as a stack by adding numbers to front with cons
; to an operator is taken from operator list, and the first 2 numbers are taken from stack
; eg (car stack) and (car (cdr stack)). Then the result is added to the front of the list (again because it is acting as a stack)
; this is achieved by (cons "result number" (cdr (cdr stack))). This adds the calculated number to the front of the list,
; but the list with the first 2 numbers removed, so the result of the calculation can replace to 2 numbers.
(define (evaluate-rpn pattern-list oper-list num-list [s (list )])
  (if (null? pattern-list) ; if pattern list is empty, return the stack
      (car s) ; return stack
      (if (= (car pattern-list) 1) ; otherwise, check if first pattern is 1
          ; if yes, add the number to front of list, pass the rest of the patterns,
          ; all opers, the rest of the numbers and the updated stack back to func
          (evaluate-rpn (cdr pattern-list) oper-list (cdr num-list) (cons (car num-list) s))
          ; if -1, take the first oper off oper list, apply it to first and second num on stack,
          ; then add the result to front of stack but (cdr (cdr s) which is the stack, without the first 2 values which 
          ; where just used in oper calc. eg stack goes from (1 2) -> (3) if added.
          (if (and (equal? (car oper-list) /) (equal? (car (cdr s)) 0))
              0
              (evaluate-rpn (cdr pattern-list) (cdr oper-list) num-list (cons ((car oper-list) (car s) (car (cdr s))) (cdr (cdr s)))))
      )
  )
)

; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

;(evaluate-rpn (first (car all-5-opers-all-6-nums)) (second (car all-5-opers-all-6-nums)) (third (car all-5-opers-all-6-nums)))

; Function correct-evaluations filters all combinations of the rpn patterns, operators and numbers
; Filter all results that equal the target number
; The function filter is not parallel unfortunately, so this is a bottle-neck
(define correct-evaluations
  (filter (lambda (l)
            (equal? (evaluate-rpn (first l) (second l) (third l)) target-number)) all-5-opers-all-6-nums)
  )

; Function that gets result of filter-correct-evaluations and builds RPN list with pattern, operator and numbers to display
; This function is adapted from the function evaluate-rpn
; The result of this function is a list that represents the RPN stack that evaluates to the target number.
; The function takes the RPN pattern, the list of operators, list of numbers and the empty stack it's building.
(define (format-correct-evaluation pattern-list oper-list num-list [s (list )])
  (if (null? pattern-list) ; if pattern list is empty, return the stack
      s ; return stack
      (if (= (car pattern-list) 1) ; otherwise, check if first pattern is 1
          ; pattern represents a number so add the first number to the list
          ; call function again, passing the rest of the numbers and all operators and the list
          (format-correct-evaluation (cdr pattern-list) oper-list (cdr num-list) (append s (list (car num-list))))

          ; pattern represents am operator, add operator to list, recall function and pass everything back in
          ; only passing the rest of the operators.
          (format-correct-evaluation (cdr pattern-list) (cdr oper-list) num-list  (append s (list (car oper-list)))))
      )
  )

; Function that cleans up display solution
; replaces the operators with a quoted version
; so that + doesn't get displayed as #<procedure:+>
; if not operator, just returns the number
(define (replace-operators old)
  (if (equal? old +)
      '+
      (if (equal? old -)
          '-
          (if (equal? old *)
              '*
              (if (equal? old /)
                  '/
                  old)))))

; map all elements in list to replace function
;(map replace-operators (format-correct-evaluation (first (car filter-correct-evaluations)) (second (car filter-correct-evaluations)) (third (car filter-correct-evaluations))))

; function to format a solution to reaching target number
; runs the solution through format-correct-evaluation function
; and then maps the result list to replace-operators function
; to quote the operators so the solution looks nice.
(define (format-solution l)
  ; maps the result of format-correct-evaluation to replace-operators
  ; which formats a single solution nicely
  (map replace-operators (format-correct-evaluation (first l) (second l) (third l)))
 )

; function that formats all of the solutions
; by mapping all solutions to format-solution function
(define (format-all-solutions l)
  (map format-solution l)
  )

; Function to validate the target number entered
; The target number must be between 101 and 999
(define (valid-target? t)
  ; validate t is number
  (if (number? t)
      ; if yes, make sure number is greater than 100
      ; and less than 1000
      (if (and (> t 100) (< t 1000))
          #t ;target in range
          #f ; not in range
      )
      #f ; not a number, not valid
  ))
; test
(valid-target? 101)
(valid-target? 100)
(valid-target? 400)
(valid-target? 999)
(valid-target? 1000)

; format all solutions
;(format-all-solutions correct-evaluations)

; the main function so solve the problem
; Takes a target number and a list of numbers
(define (solvecount target l)
  ; Check that parameters where entered correctly
  (if (or (null? target) (null? l))
      "Incorrect Parameters Entered."
      ;Check target number is value
      ;Check numbers are value
      "TODO: validate entered parameters"
  ))

(newline)
"Correct solutions:"
(length (format-all-solutions correct-evaluations))
(newline) ; nice bit of formatting
"Finished"
