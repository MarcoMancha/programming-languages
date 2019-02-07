#lang racket

;; Marco Mancha A01206194

;; Contract: triangle-area: number number -> number
;; Purpose: Triangle area given the base and height.
;; Example: (triangle-area 5 10) should produce: 25

(define (triangle-area base height)
  (/ (* base height) 2))


;; Contract: a: number -> number
;; Purpose: Result of the function 2n + 10
;; Example: (a 5) should produce: 20
(define (a n)
  (+ 10 (* 2 n)))

;; Contract: b: number -> number
;; Purpose: Result of the function n + 20
;; Example: (b 5) should produce: 25
(define (b n)
  (+ 20 (* 0.5 (* 2 n))))

;; Contract: c: number -> number
;; Purpose: Result of the function 2 - (1/n)
;; Example: (b 5) should produce: 1.8
(define (c n)
  (- 2 (/ 1.0 n)))

;; Contract: solutions: number number number -> number
;; Purpose: Number of solutions of a quadratic equation.
;; Example: (solutions 5 5 5) should produce: 0
(define (solutions a b c)
  (cond
    [(> (* b b) (* 4 (* a c))) 2]
    [(= (* b b) (* 4 (* a c))) 1]
    [else 0))
