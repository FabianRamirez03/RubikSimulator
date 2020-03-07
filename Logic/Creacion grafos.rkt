;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname |Creacion grafos|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
(define (create number)
  (createAux number 6)
  )

(define (createAux number edges)
  (cond ((zero? edges) null)
        ((equal? edges 6) (cons (createMatrix number number 'B)(createAux number (- edges 1))))
        ((equal? edges 5) (cons (createMatrix number number 'G)(createAux number (- edges 1))))
        ((equal? edges 4) (cons (createMatrix number number 'O)(createAux number (- edges 1))))
        ((equal? edges 3) (cons (createMatrix number number 'Y)(createAux number (- edges 1))))
        ((equal? edges 2) (cons (createMatrix number number 'R)(createAux number (- edges 1))))
        ((equal? edges 1) (cons (createMatrix number number 'w)(createAux number (- edges 1))))
        )
   )

(define (createMatrix numberL numberC color)
  (cond ((zero? numberL) null)
        (else
         (list (createMatrix (- numberL 1) numberC color) (createLine numberL numberC color))
         )
        )
  )

(define (createLine numberL numberC color)
  (cond ((zero? numberC) null)
        (else
         (list (createLine numberL (- numberC 1) color) (list color numberL numberC))
        )
        )
  )