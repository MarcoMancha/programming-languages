#lang racket

(define (children tree)
  (rest tree))

(define (leaf? tree)
  (cond
    [(empty? (rest tree)) true]
    [else false]))

(define (add-nodes tree)
  (if (leaf? tree)
      (first tree)
      (+ (add-nodes-in-forest (children tree)) (first tree))))

(define (add-nodes-in-forest forest)
  (if (null? forest)
      0
      (+ (add-nodes (first forest))
         (add-nodes-in-forest (rest forest)))))


(add-nodes '(1(2(3))))

;; Función para sumar listas de listas

(define (add-nodes forest)
    (if (null? forest)
      0
      (+ (add-nodes-h (first forest))
        (add-nodes (rest forest)))))

(define (add-nodes-h tree)
  (if (list? tree)
    (add-nodes tree)
   (cond
     [(null? tree) 0]
     [else tree])))


(add-nodes '(1(2(3 4 (5 6)))))
