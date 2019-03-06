#lang racket

;; Marco Antonio Mancha Alfaro A01206194


;; Call: (bst-has? list number) -> boolean
;; Purpose: To see if a binary search tree has a value
;; Example: (bst-has? t 8) should return #t

(define (leaf? node)
  (null? (cdr node)))

  
(define (bst-has? node val)
  (cond
    [(null? node) false]
    [(= (car node) val) true]
    [(leaf? node) false]
    [(> (car node) val) (bst-has? (car (cdr node)) val)]
    [else (bst-has? (car (cdr (cdr node))) val)]))

(define t '(8(5 (2) (7))(11 (9) (61))))

(bst-has? t 8)
(bst-has? t 61)
(bst-has? t 9)
(bst-has? t 100)
(bst-has? t (- 0 100))
(bst-has? t 7)
