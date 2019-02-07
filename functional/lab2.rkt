#lang racket

;; Marco Mancha A01206194

;; Contract: power-head: number number -> number
;; Purpose: Calculate power of given number using head recursion
;; Example: (power-head 4 3) should produce: 64

(define (power-head n p)
  (cond
    [(< p 1) 1]
    [else (* n (power-head n (- p 1)))]))

;; Contract: power-using-tail: number number number-> number
;; Purpose: Calculate power of given number using tail recursion
;; Example: (power-using-tail 4 3 1) should produce: 64

(define (power-using-tail n p acum)
  (cond
    [(< p 1) acum]
    [else (power-using-tail n (- p 1) (* n acum))]))

;; Contract: power-tail: number number-> number
;; Purpose: Function that calls power-using-tail to calculate power of a given number
;; Example: (power-tail 4 3) should produce: 64

(define (power-tail n p)
  (power-using-tail n p 1))

;; Contract: third: list -> number
;; Purpose: Function that returns the third element of a list
;; Example: (third (cons 1(cons 2 (cons 3 (cons 4 (cons 5 empty)))))) should produce: 3

(define (third list)
  (first (rest (rest list))))

;; Contract: just-two?: list -> boolean
;; Purpose: Function that returns true if a list contains only two elements
;; Example: (just-two? (cons 1 empty)) should produce: #f

(define (just-two? list)
  (cond
    [(empty? (rest list)) #f]
    [(empty? (rest(rest list))) #t]
    [else #f]))

;; Contract: how-many-x?: list -> number
;; Purpose: Function that receives a list and return the number of ocurrences of x
;; Example: (how-many-x?  (cons 1(cons 2 (cons 3 (cons 4 (cons 3 empty))))) 3) should produce: 2

(define (how-many-x? list x)
  (count-x? 0 list x))

;; Contract: count-x?: list number -> number
;; Purpose: Function that receives a list and a acumulator and return the number of ocurrences of x
;; Example: (count-x?  0 (cons 1(cons 2 (cons 3 (cons 4 (cons 3 empty))))) 3) should produce: 2

(define (count-x? acum list x)
  (cond
    [(empty? list) acum]
    [(= (first list) x) (count-x? (+ acum 1) (rest list) x)]
    [else (count-x? acum (rest list) x)]))

;; Contract: all-x?: list number -> number
;; Purpose: Function that receives a list and returns true if every element on the list
;; Example: (all-x? (cons 1(cons 2 (cons 3 (cons 4 (cons 3 empty))))) 3) should produce: #f

(define (all-x? list x)
  (cond
    [(empty? list) #t]
    [(= (first list) x) (all-x? (rest list) x)]
    [else #f]))

;; Contract: get-list: list number -> number
;; Purpose: Function that calls position-list and returns the number on the position of the list
;; Example: (get-list (cons 1(cons 2 (cons 3 (cons 4 (cons 3 empty))))) 2) should produce: 2

(define (get-list list x)
  (position-list list x 1))

;; Contract: position-list: list number number-> number
;; Purpose: Function that receives a list and a position and returns the number on the position of the list
;; Example: (position-list (cons 1(cons 2 (cons 3 (cons 4 (cons 3 empty))))) 2 1) should produce: 2

(define (position-list list x acum)
  (cond
    [(empty? list) 0]
    [(= x acum) (first list)]
    [else (position-list (rest list) x (+ acum 1))]))

;; Contract: difference-list: list list list-> list
;; Purpose: Function that receives 3 lists and returns a list with elements that first list has but the second doesn't
;; Example: (difference-list '(12 44 55 77 66 1 2 3 4) '(1 2 3) '()) should produce: '(4 66 77 55 44 12)

(define (difference-list A B C)
  (cond
    [(empty? A) C]
    [(x-on-list? (first A) B) (difference-list (rest A) (rest B) C)]
    [else (difference-list (rest A) B (cons (first A) C))]))

;; Contract: difference: list list -> list
;; Purpose: Function that receives 2 lists and call difference-list to return a list with elements A has but B doesn't
;; Example: (difference '(12 44 55 77 66 1 2 3 4) '(1 2 3)) should produce: '(4 66 77 55 44 12)

(define (difference A B)
  (difference-list A B '()))

;; Contract: x-on-list?: number list -> boolean
;; Purpose: Function that receives a number and checks if the number is on the list
;; Example: (x-on-list? 4 '(1 2 3 4)) should produce: #t

(define (x-on-list? x list)
  (cond
    [(empty? list) #f]
    [(= x (first list)) #t]
    [else (x-on-list? x (rest list))]))

;; Contract: append: list list -> list
;; Purpose: Function that calls append-list to append the second list to the first list
;; Example: (append '() '(1 2 3 4)) should produce: '(1 2 3 4)

(define (append A B)
  (append-list A B))

;; Contract: append-list: list list -> list
;; Purpose: Function that appends the second list to the first list
;; Example: (append-list '() '(1 2 3 4)) should produce: '(1 2 3 4)

(define (append-list A B)
  (cond
    [(empty? A) B]
    [else (append-list (not-last A) (cons (last A) B))]))

;; Contract: not-last: list -> list
;; Purpose: Function that returns a list without the last element
;; Example: (not-last '(1 2 3 4)) should produce: '(1 2 3)

(define (not-last A)
  (cond
    [(empty? (rest A)) empty]
    [else (cons (first A) (not-last (rest A)))]))

;; Contract: invert: list -> list
;; Purpose: Function that calls invert-list and returns a list inverted
;; Example: (invert '(1 2 3 4)) should produce: '(4 3 2 1)

(define (invert A)
  (invert-list A '()))

;; Contract: invert-list: list -> list
;; Purpose: Function that returns a list inverted
;; Example: (invert-list '(1 2 3 4) '()) should produce: '(4 3 2 1)

(define (invert-list A B)
  (cond
    [(empty? A) B]
    [else (invert-list (rest A) (cons (first A) B))]))

;; Contract: sign: list -> list
;; Purpose: Function that returns a list of 1 or -1 depending of the sign of each number
;; Example: (sign '(2 -4 -6)) should produce: '(1 -1 -1)

(define (sign A)
  (cond
    [(empty? A) empty]
    [else
      (cond
        [(< (first A) 0) (cons -1 (sign (rest A)))]
        [else (cons 1 (sign (rest A)))])]))

;; Contract: negatives: list -> list
;; Purpose: Function that receives a list and returns the list being negative.
;; Example: (negatives '(2 -4 -6)) should produce: '(-2 -4 -6)

(define (negatives A)
  (cond
    [(empty? A) empty]
    [else
      (cond
        [(< (first A) 0) (cons (first A) (negatives (rest A)))]
        [else (cons (- (first A) (* 2 (first A))) (negatives (rest A)))])]))
