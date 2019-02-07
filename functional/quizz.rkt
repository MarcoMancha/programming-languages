#lang racket

;; Marco Antonio Mancha Alfaro A01206194


;; Call: (bst-has? list number) -> boolean
;; Purpose: To see if a binary search tree has a value
;; Example: (bst-has? t 8) should return #t
(define (bst-has? tree value)
  (or (equal? (first tree) value)
      (in-bst (rest tree) value)))

;; Call: (in-bst list number) -> boolean
;; Purpose: To see if a binary search tree has a value
;; Example: (in-bst t 5) should return #t

(define (in-bst forest value)
  (if (null? forest)
      #f
      (or (bst-has? (first forest) value)
          (in-bst (rest forest) value))))


;(define (in-bst forest value)
;  (if (null? forest)
;      #f
;      (cond
;        [(list? (first forest))
;         (if (< (first(first forest)) value)
;            (bst-has? (first forest) value)
;            (in-bst (rest forest) value))]
;        [else 
;        (if (< (first forest) value)
;            (bst-has? (first forest) value)
;            (in-bst (rest forest) value))])))

(define t '(8(5 (2) (7))(11 (9) (61))))

(bst-has? t 8)
(bst-has? t 61)
(bst-has? t 9)
(bst-has? t 100)
(bst-has? t (- 0 100))
(bst-has? t 7)
