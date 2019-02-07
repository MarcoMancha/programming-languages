#lang racket

(define (deep-all-x? forest x)
    (cond
      [(null? forest) true]
      [else (and (check-x (first forest) x) (deep-all-x? (rest forest) x))]))


(define (check-x tree x)
  (cond
    [(list? tree) (deep-all-x? tree x)]
    [else 
    (cond
      [(= tree x) true]
      [else false])]))

(deep-all-x? '(2 (2 2) 2(2 (2 2) 2)) 2)

(define (deep-reverse A)
  (reverse A '()))

(define (reverse A B)     
  (cond
    [(empty? A) B]
    [(list? (first A)) (reverse (rest A) (cons (reverse (first A) '()) B))]
    [else (reverse (rest A) (cons (first A) B))]))

(deep-reverse '(a (b (c d)) e (f g)))

(define (flatten A)
  (flat A '()))

(define (flat A B)     
  (cond
    [(empty? A) B]
    [(list? (first A)) (flat (first A) (flat (rest A) B))]
    [else (cons (first A) (flat (rest A) B))]))

(flatten '(a (b (c d)) (e (f g))) )

(define (count-levels A)
  (if (empty? A)
    0
    (if (empty? (rest A))
        1
        (+ 1 (levels (rest A))))))

(define (levels A)
  (if (empty? A)
    0
    (max (count-levels(first A)) (levels(rest A)))))

(count-levels '(a (b (c) (d))(e (f) (g))))

(define (children tree)
  (rest tree))

(define (leaf? tree)
  (cond
    [(empty? (rest tree)) true]
    [else false]))

(define (add-nodes tree)
  (if (leaf? tree)
      1
      (add-nodes-in-forest (children tree))))

(define (add-nodes-in-forest forest)
  (if (null? forest)
      0
      (+ (add-nodes (first forest))
         (add-nodes-in-forest (rest forest)))))


(add-nodes '(a
(b
(c) (d))
(e
(f) (g) (h) (i))))



