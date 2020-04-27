(require pict3d)
(require pict3d/universe)

;;Constanstes utilizadas constantemente en la renderizacion del cubo.
(define (cubesSize)0.29)
(define (-cubesSize)-0.29)
(define (offset) 0.005)
(define (-offset) -0.005)
(define (radius) 1/8)

;;Crea el cuadro negro interior para que se vea las lineas entre cuadros___________________________
(define (blackLines dim)
  (with-color (rgba "black") ;;Lineas del borde 
             (cube (getCenter dim) (* dim 0.13933)))
  )

;;Función principal para renderizar el cubo como pict3D
(define (cubo matrix)
  (cubeMatrix matrix))

;;Funcion auxiliar de la funcion cubo
(define (cubeMatrix matrix)
     (parameterize ([current-pict3d-background  (rgba 240 240 240 1)])
     (combine
           (frontFace2 (car matrix) -1 1)
           (rightFace2 (caddr matrix) 0 1 (lengthList (cadr matrix)))
           (topFace2 (cadr matrix) -1 (* -1 (- (lengthList (caddr matrix)) 1)) (lengthList (caddr matrix)))
           (blackLines (lengthList (car matrix)))
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


;;Define las coordenadas del centro del cuadro negro que genera las lineas
(define (getCenter dim)
  (cond((equal? dim 0) (pos 0 0 0))
       ((equal? dim 1) (pos 0 0 0))
       ((equal? dim 2) (pos -0.15 -0.15 0.14))
       ((equal? dim 3) (pos -0.29 0 0))
       ((equal? dim 4) (pos -0.433 0.15 -0.139))
       ((equal? dim 5) (pos -0.57 0.3 -0.279))
       ((equal? dim 6) (pos -0.71 0.45 -0.42))
       ((equal? dim 7) (pos -0.85 0.603 -0.56))
       ((equal? dim 8) (pos -0.985 0.75 -0.70))
       ((equal? dim 9) (pos -1.128 0.9 -0.838))
       ((equal? dim 10) (pos -1.27 1.05 -0.99))
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