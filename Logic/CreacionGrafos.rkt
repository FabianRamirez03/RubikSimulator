;***********************************Creacion de cubo**********************************
;Funcion principal para crear el cubo
(define (create number)
  (createAux number 6)
  )
;Funcion recursiva para la creacion de las 6 caras del cubo
(define (createAux number edges)
  (cond ((zero? edges) null)
        ((equal? edges 6) (cons (createMatrix number 1 "B")(createAux number (- edges 1))))
        ((equal? edges 5) (cons (createMatrix number 1 "G")(createAux number (- edges 1))))
        ((equal? edges 4) (cons (createMatrix number 1 "O")(createAux number (- edges 1))))
        ((equal? edges 3) (cons (createMatrix number 1 "Y")(createAux number (- edges 1))))
        ((equal? edges 2) (cons (createMatrix number 1 "R")(createAux number (- edges 1))))
        ((equal? edges 1) (cons (createMatrix number 1 "w")(createAux number (- edges 1))))
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
  (cond ((equal? dir 'U) (sortCube (verticalRead cube num) '(1 5 2 6)))
        ((equal? dir 'D) (sortCube (verticalRead cube num) '(2 6 1 5)))
        ((equal? dir 'L) (sortCube (horizontalRead cube num) '(3 6 4 5)))
        ((equal? dir 'R) (sortCube (horizontalRead cube num) '(4 5 3 6)))
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
(define (sortCube List change)
  (cond ((null? change) null)
        (else (cons (search List (car change) 1) (sortCube List (cdr change))))
        )
  )
;Busca elemento segun la columna o fila
(define (search List numSearch num)
  (cond ((equal? numSearch num) (car List))
        (else (search (cdr List) numSearch (+ num 1)))
        )
  )
;Llama segun el movimiento cada fila para acomodar
(define (changeCallR cube List numChange numList)
  (cond((null? numList) cube)
       (else (changeCallR (rowChange cube List numChange (car numList) 1) (cdr List) numChange (cdr numList)))
       )
  )
;Acomoda el cubo cambiandole la fila a la que le dieron vuelta
(define (rowChange cube List numChange numList num)
  (cond((null? cube) null)
       ((equal? numList num) (cons (rChanAux (car List) (car cube) numChange 1 (Length (car cube))) (rowChange (cdr cube) (cdr List) numChange numList (+ num 1))))
       (else(cons (car cube) (rowChange (cdr cube) List numChange  numList (+ num 1)))
             )
       )
  )
;Auxiliar recursica que cambia la fila o columna en el cubo que se le ha dado vuelta
(define (rChanAux List edge numChange num size)
  (cond((equal? num size) null)
       ((equal? numChange num) (cons List (rChanAux List (cdr edge) numChange (+ num 1) size)))
       (else (cons (car edge) (rChanAux List (cdr edge) numChange (+ num 1) size))
             )
       )
  )
;Funcion de cola para ir girando el cubo
(define (changeCallC cube List numChange numList)
  (cond((null? numList) cube)
       (else (changeCallC (columnChange cube List numChange (car numList) 1) (cdr List) numChange (cdr numList)))
       )
  )
;Toma la cara a la que se le debe de dar vuelta
(define (columnChange cube List numChange numList num)
  (cond((null? cube) null)
       ((equal? numList num) (cons (columnChanAux (car List) (car cube) numChange) (columnChange (cdr cube) (cdr List) numChange numList (+ num 1))))
       (else (cons (car cube) (columnChange (cdr cube) List numChange numList (+ num 1))))
       )
  )
;Toma cada fila para cambiarle la columna deseada
(define (columnChanAux List edge numChange)
  (cond((null? edge) null)
       (else(cons (rChanAux (car List) (car edge) numChange 1 (Length edge)) (columnChanAux (cdr List) (cdr edge) numChange)))
       )
  )









