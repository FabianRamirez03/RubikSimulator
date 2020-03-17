(require pict3d)
(require pict3d/universe)

(define (cubesSize)0.29)
(define (-cubesSize)-0.29)
(define (offset) 0.005)
(define (-offset) -0.005)
(define (redius) 1/8)

;;Crea el cuadro negro interior para que se vea las lineas entre cuadros___________________________
(define blackLines
  (with-color (rgba "black") ;;Lineas del borde 
             (cube (pos -0.29 0 0) 0.418))
  )

;;Función principal para renderizar el cubo como pict3D
(define (cubo matrix)
  (cubeMatrix matrix))

;;Funcion auxiliar de la funcion cubo
(define (cubeMatrix matrix)
     (parameterize ([current-pict3d-background  (rgba 240 240 240 1)])
     (combine
           (frontFace2 (car matrix) -1 1)
           (rightFace2 (cadr matrix) 0 1 (lengthList (cadr matrix)))
           (topFace2 (caddr matrix) -1 (* -1 (- (lengthList (caddr matrix)) 1)) (lengthList (caddr matrix)))
           ;;blackLines
           ;;(basis 'camera (point-at (pos 0.5 0.5 0.5) (pos -0.1 0.13 -0.2)))
           (light (pos 1 1 1)))))


;;Dibuja cara frontal________________________________________________________________________________________________________________________________________
(define (frontFace2 lista width height)
  (cond((null? lista) lista)
        (else (combine (rowFrontAux (car lista) width height) (frontFace2 (cdr lista) -1 (- height 1)))
         )
  )
)

(define (rowFrontAux lista width height)
  (cond((null? lista) lista)
        (else(combine (with-color (rgba (getColor (caar lista))) (cube (pos (offset) (* width (cubesSize)) (* (cubesSize) height)) 1/8)) (rowFrontAux (cdr lista) (+ width 1) height)))
  )
)


;;Dibuja cara lateral________________________________________________________________________________________________________________________________________

(define (rightFace2 lista deep height dim)
  (cond((null? lista) lista)
        (else (combine (rowRightAux (car lista) deep height dim) (rightFace2 (cdr lista) 0 (- height 1) dim))
         )
  )
)

(define (rowRightAux lista deep height dim)
  (cond((null? lista) lista)
        (else(combine (with-color (rgba (getColor (caar lista)))(cube (pos (* deep (cubesSize)) (+ (offset) (* (cubesSize) (+ dim -2))) (* (cubesSize) height)) 1/8)) (rowRightAux (cdr lista) (- deep 1) height dim)))
  )
)

;;Dibuja cara superior________________________________________________________________________________________________________________________________________

(define (topFace2 lista width deep dim)
  (cond((null? lista) lista)
        (else (combine (rowTopAux (car lista) width deep dim)(topFace2 (cdr lista) -1 (+ 1 deep) dim))
         )
  )
)

(define (rowTopAux lista width deep dim)
  (cond((null? lista) lista)
        (else(combine (with-color (rgba (getColor (caar lista)))(cube (pos (* deep (cubesSize)) (* (cubesSize) width) (+ (* 1 (cubesSize)) (offset))) 1/8)) (rowTopAux (cdr lista) (+ width 1) deep dim)))
  )
)


;;Consigue el color de cada recuadro__________________________________________________
(define (getColor color)
  (cond((equal? color "B") (rgba "blue"))
       ((equal? color "O") (rgba "orange"))
       ((equal? color "R") (rgba "red"))
       ((equal? color "Y") (rgba "yellow"))
       ((equal? color "G") (rgba "green"))
       ((equal? color "W") (rgba "white"))
    )
 )

;;Crea el bitmap a partir de la pict3D________________________________________________________
(define (cubeBitMap2 matrix)(parameterize ([current-pict3d-background  (rgba 240 240 240 1)])
    (pict3d->bitmap
     (combine (cubo matrix)
              (light (pos 1 1 1))))))


;;COnsigue el largo de una lista________________________________________
(define(lengthList lista)
  (cond((null? lista) 0)
       (else(+ 1 (lengthList(cdr lista))))
    )
)


;;Setea valores para la visualización de la imagen
(current-pict3d-add-sunlight? #t) 
(current-pict3d-fov 118)