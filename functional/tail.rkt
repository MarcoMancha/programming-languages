#lang racket

(define (ex1 n)
  (cond
    [(= 1 n) 2]
    [else (+ (* 2 n) (ex1(- n 1)))]))

(define (ex1tail n acum)
  (if (= n 0)
      acum
      (let ((m (- n 1)))
        (ex1tail m (+ acum (* 2 n))))))

(define (tail n)
  (ex1tail n 0))

(define (fact n)
  (if (= n 1)
      1
      (* n (fact(- n 1)))))

(define (mults list)
  (cond
    [(empty? list) 1]
    [else (* (first list) (mults (rest list)))]))
