#lang racket
(define (map f lst)
  (cond
    [(null? lst) '()]
    [else (cons (f (first lst)) (map f (rest lst)))]))

(define (sum f lst)
  (cond
    [(null? lst) 0]
    [else (+ (f (first lst)) (sum f (rest lst)))]))

(define (mult a)
  (* a 2))

(map mult '(1 2 3 4))

(sum mult '(1 2 3 4))
