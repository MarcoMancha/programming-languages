#lang racket

;; Marco Mancha A01206194

;; Contract: deep-all-x?: list number -> boolean
;; Purpose: Check if every element on the list is x
;; Example: (deep-all-x? '(2 (2 2) 2(2 (2 2) 2)) 2) should produce: #t
(define (deep-all-x? forest x)
    (cond
      [(null? forest) true]
      [else (and (check-x (first forest) x) (deep-all-x? (rest forest) x))]))

;; Contract: check-x?: list number -> boolean
;; Purpose: Check if every element on the list is x
;; Example: (deep-all-x? '(2 (2 2) 2(2 (2 2) 2)) 2) should produce: #t
(define (check-x tree x)
  (cond
    [(list? tree) (deep-all-x? tree x)]
    [else
    (cond
      [(= tree x) true]
      [else false])]))

;; Contract: deep-reverse: list -> list
;; Purpose: Reverse a deep list
;; Example: (deep-reverse '(a (b (c d)) e (f g))) should produce: ((g f) e ((d c) b) a)
(define (deep-reverse A)
  (reverse A '()))

  ;; Contract: reverse: list -> list
  ;; Purpose: Reverse a deep list
  ;; Example: (reverse '(a (b (c d)) e (f g)) '()) should produce: ((g f) e ((d c) b) a)
(define (reverse A B)
  (cond
    [(empty? A) B]
    [(list? (first A)) (reverse (rest A) (cons (reverse (first A) '()) B))]
    [else (reverse (rest A) (cons (first A) B))]))

;; Contract: flatten: list -> list
;; Purpose: Convert deep list into a list on a single level
;; Example: (flatten '(a (b (c d)) (e (f g))) ) should produce: (a b c d e f g)

(define (flatten A)
  (flat A '()))

  ;; Contract: flat: list -> list
  ;; Purpose: Convert deep list into a list on a single level
  ;; Example: (flat '(a (b (c d)) (e (f g))) '()) should produce: (a b c d e f g)
(define (flat A B)
  (cond
    [(empty? A) B]
    [(list? (first A)) (flat (first A) (flat (rest A) B))]
    [else (cons (first A) (flat (rest A) B))]))

;; Contract: count-levels: list -> number
;; Purpose: Counts the max depth of a tree
;; Example: (count-levels '(a (b (c) (d))(e (f) (g)))) should produce: 3
(define (count-levels A)
  (if (empty? A)
    0
    (if (empty? (rest A))
        1
        (+ 1 (levels (rest A))))))

;; Contract: levels: list -> number
;; Purpose: Helper function of count-levels to count the max depth of a tree
;; Example: (levels '(a (b (c) (d))(e (f) (g)))) should produce: 3
(define (levels A)
  (if (empty? A)
    0
    (max (count-levels(first A)) (levels(rest A)))))

;; Contract: count-max-arity?: list -> number
;; Purpose: Count the max number of children on a node
;; Example: (count-max-arity '(a (b (c) (d))(e (f) (g) (h) (i)))) should produce: 4
(define (count-max-arity tree)
  (if (null? tree)
      0
      (max (arity (first tree))
         (count-max-arity (rest tree)))))

;; Contract: count-max-arity?: list -> number
;; Purpose: Function that helps count-max-arity? to count max number of children on a node
;; Example: (arity '(a (b (c) (d))(e (f) (g) (h) (i)))) should produce: 4
(define (arity node)
  (if (list? node)
      (max (- (length node) 1) (count-max-arity (rest node)))
      0))
