#lang racket

"Starting..." ; Feedback for users, so they know program has started
(newline)

; cut out one -1 and two 1s
(define start-perm (list -1 -1 -1 -1 1 1 1 1))

; List of all operators that can be used
(define operators (list + - * /))

; list of valid numbers
(define numbers (list 1 1 2 2 3 3 4 4 5 5 6 6 7 7 8 8 9 9 10 10 25 50 75 100))

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
(define all-5-operators (cartesian-product operators operators operators operators operators)) ; all 5
(define all-4-operators (cartesian-product operators operators operators operators)) ; all 4
(define all-3-operators (cartesian-product operators operators operators)) ; all 3
(define all-2-operators (cartesian-product operators operators )) ; all 2
(define all-1-operators (cartesian-product operators)) ; basicaly just operators list, just trying to be consistent

; a list each list of operators on it
; first entry is 5 operator and it goes all the way to 1
(define all-operator-combinations (list all-5-operators all-4-operators all-3-operators all-2-operators all-1-operators))

; Define a list of all perms of 6 numbers
; Will hard code 6 numbers for now
(define number-list (list 100 25 10 2 2 1))

; define a list of all perms of a 6 number list without dupes
;(define all-6-numbers (remove-duplicates (permutations number-list))) ; removes the dupes



; ////////////////////////////////////////////////// format-list-of-lists Function /////////////////////////////////////////////////////////

; function that makes a list of lists of lists, a list of lists
; combinations gives back a list of lists. when mapping that to
; permutations, to get every permutation of every combination,
; it returns a list with all the lists of permutations, of the combinations
; eg the permutation list is nested 2 lists deep.
(define (format-list-of-lists l [x (list )])
  ; if list is null, return x (list of all perms)
  (if (null? l)
      x
      ; append the car of l (which is a list of lists)
      ; to the list x, then pass the cdr of l and x back into function
      (format-list-of-lists (cdr l) (append x (car l)))
  ))

; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


; ////////////////////////////////////////////////// get-all-perms Function /////////////////////////////////////////////////////////

; Function to get all permutations of all combinations of size selected of a list.
; Takes a list and a number. Returns a list of all the perms
(define (get-all-perms l n)
  ; get all combinations of list, of size selected.
  ; Then get the permutations of each combination.
  ; Then format the list and remove dupes.
  (remove-duplicates (format-list-of-lists (map permutations (combinations l n))))
)

; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


; ////////////////////////////////////////////////// get-all-number-perms Function /////////////////////////////////////////////////////////

;Function that creates a List of all unique permutations of 6, 5, 4, 3 and 2 number combintations from start list
; Takes the list of 6 numbers, returns the list of lists, which each have every unique perm
(define (get-all-number-perms l)
  (if (null? l)
      l ; if null, return it
      ; create a list with 5 lists, each list is all perms of the selected size combination of origial 6 num list
      (list (get-all-perms l 6) (get-all-perms l 5) (get-all-perms l 4) (get-all-perms l 3) (get-all-perms l 2))
  )
)

; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

;(get-all-number-perms number-list)


; ////////////////////////////////////////////////// valid-rpn? Function /////////////////////////////////////////////////////////

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

; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


(define valid-rpn-list (filter (lambda (l) (equal? (valid-rpn? l) #t)) all-rpn-patterns))
;(length valid-rpn-list)
; display list of valid rpn patterns
;valid-rpn-list


; ////////////////////////////////////////////////// get-valid-rpn Function /////////////////////////////////////////////////////////

; function that takes a list of all possible rpn patterns
; and returns a list of all valid patterns
; Filters all of the possible rpn patterns
; runs each one through valid-rpn? function
; and only returns the pattern if it is valid (if valid-rpn? returns #t)
(define (get-valid-rpn l)
  (if (null? l) ; check if l is null
      l ; return l if it's null
      ; otherwise, filter each pattern in l into valid-rpn? function
      ; only return the patterns that are valid
      (filter (lambda (a) (equal? (valid-rpn? a) #t)) l))
)

; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

;(length valid-rpn-list)
;(length (get-valid-rpn all-rpn-patterns))


; ////////////////////////////////////////////////// get-all-rpn-patterns Function /////////////////////////////////////////////////////////

; function that returns a list of all valid rpn patterns
; start with passing in the start-perm whcih is the template for rpn
; patterns with 6 numbers and 5 operators. Function gets all perms of the start-perm
; removes dupes, maps it to make-rpn to make each permutation an rpn pattern (ie adds 1 1 to start and -1 to end)
; This creates all patterns for 6 numbers and 5 opers. Then it passes then into get-valid-rpn
; which returns only the valid rpn patterns. Then it is cons to the start of the list.
; A 1 and -1 are removed from the pattern template, to make patterns for 5 numbers and 4 operators.
; That is then passed into the function again allow with the list being built.
; Onces the pattern template list is empty, the base pattern is created for 2 numbers and 1 operater (1 1 -1)
; this is then added to the list of all the other patterns and the list is reversed.
; In the list returned, there are 5 elements, the first is all the valid patterns for 6 nums 5 opers.
; this continues in desending order, so the last element is a list of all the valid rpn patterns for 2 num 1 opers.
(define (get-all-rpn-patterns l [x (list )])
  (if (null? l) ; if pattern template is empty
   ; make the rpn pattern for 2 numbers 1 operator, cons to front of list
   ; then reverse the list, so first element is list of all patterns for 6n 5o
   ; and the last element is patterns for 2m 1o
   (reverse (cons (make-rpn null) x))
   ; if template not empty, get all unique perms of template, map them to make-rpn to turn them
   ; into rpn patterns. Then pass that to get-valid-rpn to only get valid patterns.
   ; Cons this to front of list, pass it to function again recursively and pass template list with
   ; one 1 and one -1 removed, so next patterns are for one number and operator less
   (get-all-rpn-patterns (remove -1 (remove 1 l)) (cons (get-valid-rpn (map make-rpn (remove-duplicates (permutations l)))) x)
  )))

; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

; tests

;(length (get-all-rpn-patterns start-perm))
;(length (first (get-all-rpn-patterns start-perm)))
;(length (second (get-all-rpn-patterns start-perm)))
;(length (last (get-all-rpn-patterns start-perm)))

;(last (get-all-rpn-patterns start-perm))
;(fourth (get-all-rpn-patterns start-perm))


; define a list of all the combinations of 5 operators
; and 6 numbers
;(define all-5-opers-all-6-nums (cartesian-product all-5-operators all-6-numbers))

; That is all rpn patterns X all 5 operators X all 6 numbers
; This requires 1GB of memory allocated
; Is a list of 3 lists. First list is rpn pattern, second list is operators list and third list is numbers list
(define all-5-opers-all-6-nums (cartesian-product (car (get-all-rpn-patterns start-perm)) (first all-operator-combinations) (first (get-all-number-perms number-list))))

;(length (cartesian-product valid-rpn-list all-5-operators (get-all-perms l 6)))
;(length all-5-opers-all-6-nums)

;(length valid-rpn-list)
;(car all-5-opers-all-6-nums)
;(first (car all-5-opers-all-6-nums))
;(second (car all-5-opers-all-6-nums))
;(third (car all-5-opers-all-6-nums))

; ////////////////////////////////////////////////// evaluate-rpn Function /////////////////////////////////////////////////////////

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


; ////////////////////////////////////////////////// correct-evaluations Function /////////////////////////////////////////////////////////

; Function correct-evaluations filters all combinations of the rpn patterns, operators and numbers
; Filter all results that equal the target number
; The function filter is not parallel unfortunately, so this is a bottle-neck
; Takes the list with the patterns, operators and numbers and the target number.
; Returns the list of patterns, operators and numbers that evaluate to the target number
(define (correct-evaluations l target)
  ; filter the result of evaluate-rpn which returns #t or #t if target is met
  ; I left the target outside the filter lambda because adding it as a param
  ; list the list, slows down the filter process and uses a lot more memory.
  ; I get the feeling it makes a copy of target number (which would make over 1 million copies)
  (filter (lambda (l)
            (equal? (evaluate-rpn (first l) (second l) (third l)) target)) l )
  )

; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


; ////////////////////////////////////////////////// format-correct-evaluation Function /////////////////////////////////////////////////////////

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

; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


; ////////////////////////////////////////////////// replace-operators Function /////////////////////////////////////////////////////////

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

; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

; map all elements in list to replace function
;(map replace-operators (format-correct-evaluation (first (car filter-correct-evaluations)) (second (car filter-correct-evaluations)) (third (car filter-correct-evaluations))))


; ////////////////////////////////////////////////// format-solution Function /////////////////////////////////////////////////////////

; function to format a solution to reaching target number
; runs the solution through format-correct-evaluation function
; and then maps the result list to replace-operators function
; to quote the operators so the solution looks nice.
(define (format-solution l)
  ; maps the result of format-correct-evaluation to replace-operators
  ; which formats a single solution nicely
  (map replace-operators (format-correct-evaluation (first l) (second l) (third l)))
 )

; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


; ////////////////////////////////////////////////// format-all-solutions Function /////////////////////////////////////////////////////////

; function that formats all of the solutions
; by mapping all solutions to format-solution function
(define (format-all-solutions l)
  ; maps all correct evaluations to format-solution function
  ; this formats all of the solutions into a nice list
  (map format-solution l)
)

; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


; ////////////////////////////////////////////////// valid-target? Function /////////////////////////////////////////////////////////

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

; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

; test
;(valid-target? 101)
;(valid-target? 100)
;(valid-target? 400)
;(valid-target? 999)
;(valid-target? 1000)


; ////////////////////////////////////////////////// numbers-in-pool? Function /////////////////////////////////////////////////////////

; function that checks input numbers are from the list of valid numbers
; and that there are not more of the same numbers then allowed eg 2 2 2 2
; takes the list of entered numbers, returns true of false
(define (numbers-in-pool? l [pool numbers])
  (if (null? l)
      #t ; all numbers were processed, valid list
      ; check that the length of the list after removing a number
      ; is the same as length of number pool - 1
      (if (equal? (length (remove (car l) pool)) (- (length pool) 1))
         ; valid, number was removed, pass rest of numbers and pool with this number removed
          ; back to the function again to process the rest
         (numbers-in-pool? (cdr l) (remove (car l) pool))
         ; number didn't remove anything, not valid number
         #f
      ))
  )

; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

; test
;(numbers-in-pool? (list 1 25 3 4 5 6)) ; #t
;(numbers-in-pool? (list 1 1 3 4 5 100)) ; #t
;(numbers-in-pool? (list 10 20 50 75 5 6)) ;#f
;(numbers-in-pool? (list 1 2 3 100 75 100)) ; #f
;(numbers-in-pool? (list 1 2 3 4 5 200)) ; #f


; ////////////////////////////////////////////////// valid-numbers? Function /////////////////////////////////////////////////////////

; Function that validates the numbers entered
; the list must have 6 numbers and must be from the
; pool of allowed numbers. Returns #t or #f
(define (valid-numbers? l)
  (if (null? l) ; check if list is null
      #f ; if so, invalid numbers
      ; make sure the list is length 6, must be 6 numbers
      (if (equal? (length l) 6)
          ; if 6, run numbers through function that checks
          ; the numbers are in the pool, returns #t or #f
          (numbers-in-pool? l)
          #f ; not 6 numbers, invalid
       )
   )
)
; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

; test
;(valid-numbers? (list 1 2 3 4 5 6)) ; #t
;(valid-numbers? (list 1 2 3 4 5))   ; #f
;(valid-numbers? (list 1 2 3 4 4 4)) ; #f
;(valid-numbers? (list 1 2 2 4 100 6)) ; #t
;(valid-numbers? (list 1 2 2 4 100 6 25)) ; #f

; format all solutions
;(format-all-solutions correct-evaluations)

; function to 


; ////////////////////////////////////////////////// solvecount Function /////////////////////////////////////////////////////////

; The main function to solve the problem
; Takes a target number and a list of numbers
(define (solvecount t l)
  ; Check that parameters where entered correctly
  (if (or (null? t) (null? l))
      "Incorrect Parameters Entered."
      ;Check target number is value
      (if (valid-target? t)
          ; the target number is correct, now check numbers are valid
          (if (valid-numbers? l)
              "Target and numbers valid" ; solve the problem here
              "Numbers entered are not valid"
          )
          "Target number not valid, must be (101 - 999)"   
      )
  ))

; /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

(solvecount 200 (list 1 2 3 4 5 6))


;(format-all-solutions (correct-evaluations all-5-opers-all-6-nums target-number))

(newline)
"Correct solutions:"
(length (format-all-solutions (correct-evaluations all-5-opers-all-6-nums target-number)))
(newline) ; nice bit of formatting
"Finished"
