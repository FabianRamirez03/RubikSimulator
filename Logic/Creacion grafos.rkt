;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-advanced-reader.ss" "lang")((modname |Creacion grafos|) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #t #t none #f () #f)))
;***********************************Creacion de cubo**********************************
;Funcion principal para crear el cubo
(define (create number)
  (createAux number 6)
  )
;Funcion recursiva para la creacion de las 6 caras del cubo
(define (createAux number edges)
  (cond ((zero? edges) null)
        ((equal? edges 6) (cons (createMatrix number 1 'B)(createAux number (- edges 1))))
        ((equal? edges 5) (cons (createMatrix number 1 'G)(createAux number (- edges 1))))
        ((equal? edges 4) (cons (createMatrix number 1 'O)(createAux number (- edges 1))))
        ((equal? edges 3) (cons (createMatrix number 1 'Y)(createAux number (- edges 1))))
        ((equal? edges 2) (cons (createMatrix number 1 'R)(createAux number (- edges 1))))
        ((equal? edges 1) (cons (createMatrix number 1 'w)(createAux number (- edges 1))))
        )
   )
;Funcion recursiva para la creacion de las filas
(define (createMatrix numberL number color)
  (cond ((equal? (+ numberL 1) number) '())
        (else
         (cons (createLine number numberL 1 color) (createMatrix numberL (+ number 1) color))
         )
        )
  )
;Funcion recursiva para la creacion de columnas 
(define (createLine numberL numberC number color)
  (cond ((equal? (+ numberC 1) number) '())
        (else
         (cons (list color numberL number) (createLine numberL numberC (+ number 1) color))
        )
        )
  )

;Funcion principal para contar tamano del cubo
(define (Length cube)
  (lengthAux (caar cube))
  )
;Funcion recursiva para contar elementos de una lista
(define (lengthAux line)
  (cond ((null? line) 0)
        (else (+ (lengthAux (cdr line)) 1))
        )
  )
;**************************************** giro **********************************

(define (rotate cube num dir)
  (cond ((equal? dir 'U) (sort (verticalRead cube num) '(2 6 1 5)))
        ((equal? dir 'D) (sort (verticalRead cube num) '(1 5 2 6)))
        ((equal? dir 'L) (sort (horizontalRead cube num) '(3 6 4 5)))
        ((equal? dir 'R) (sort (horizontalRead cube num) '(4 5 3 6)))
        (else #f)
        )
  )

;Realiza lista con los elementos a mover verticalmente
(define (verticalRead cube num)
  (cond ((null? cube) null)
        (else (cons (verticalAux (car cube) num) (verticalRead (cdr cube) num)))
         )
  )
;Realiza la lista de los elementos a mover pero en una cara 
(define (verticalAux edge num)
  (cond ((null? edge) null)
        (else (cons (search (car edge) num 1) (verticalAux (cdr edge) num))) 
  )
  )
;Realiza lista con los elementos a mover horizontal
(define (horizontalRead cube num)
  (cond ((null? cube) null)
        (else (cons (search (car cube) num 1) (horizontalRead (cdr cube) num)))
        )
  )
;ordena de acuerdo al movimiento que se quiera realizar
(define (sort List change)
  (cond ((null? change) null)
        (else (cons (search List (car change) 1) (sort List (cdr change))))
        )
  )
;Busca elemento segun la columna o fila
(define (search List numSearch num)
  (cond ((equal? numSearch num) (car List))
        (else (search (cdr List) numSearch (+ num 1)))
        )
  )












