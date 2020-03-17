(require pict3d)
(require pict3d/universe)

(define (cubesSize)0.29)
(define (-cubesSize)-0.29)
(define (offset) 0.005)
(define (-offset) -0.005)
(define (redius) 1/8)

(define frontFace(combine(with-color (rgba "white") ;;origen (centro)
             (cube (pos (offset) 0 0) 1/8))                       ;;5
(with-color (rgba "white") ;;arriba
             (cube (pos (offset) 0 (cubesSize)) 1/8))              ;;2        1,2,3 coinciden X(offset), Z(Cubesize) 
(with-color (rgba "white") ;;abajo
             (cube (pos (offset) 0 (-cubesSize)) 1/8))             ;;8        4,5,6 coinciden X(offset), Z(0)
 (with-color (rgba "white") ;;Derecha 
             (cube (pos (offset) (cubesSize) 0) 1/8))              ;;6        7,8,9 coinciden en X(Offset, Z(-cubesSize)
 (with-color (rgba "white") ;;Izquierda  
             (cube (pos (offset) (-cubesSize) 0) 1/8))             ;;4
 (with-color (rgba "white")  ;;Derecha arriba
             (cube (pos (offset) (cubesSize) (cubesSize)) 1/8))     ;;3
 (with-color (rgba "white")  ;;Derecha abajo
             (cube (pos (offset)  (cubesSize) (-cubesSize)) 1/8))   ;;9
 (with-color (rgba "white") ;;Izquierda arriba
             (cube (pos (offset) (-cubesSize) (cubesSize)) 1/8))      ;;1
 (with-color (rgba "white") ;;Izquierda abajo 
             (cube (pos (offset) (-cubesSize) (-cubesSize)) 1/8))      ;;7
 )) ;;(x y z) -> x es constante en el offset

(define rightFace (combine(with-color (rgba "red") ;;origen (centro)                            ;;5
             (cube (pos (-cubesSize) (+ (cubesSize) (offset)) 0) 1/8))
(with-color (rgba "red") ;;arriba
             (cube (pos (-cubesSize) (+ (cubesSize) (offset)) (cubesSize)) 1/8))                ;;2
(with-color (rgba "red") ;;abajo
             (cube (pos (-cubesSize) (+ (cubesSize) (offset)) (-cubesSize)) 1/8))               ;;8   1,2,3 coinciden en Y(+ (cubesSize) (offset)) y en Z(cubesSize)
 (with-color (rgba "red") ;;Derecha 
             (cube (pos (+ (-cubesSize) (-cubesSize)) (+ (cubesSize) (offset)) 0) 1/8))         ;;6   4,5,6 coinciden en Y(+ (cubesSize) (offset)) y en Z(0)
 (with-color (rgba "red") ;;Izquierda 
             (cube (pos 0 (+ (cubesSize) (offset)) 0) 1/8))                                     ;;4   7,8,9 coinciden en Y(+ (cubesSize) (offset)) y en Z(-cubesSize)
 (with-color (rgba "red")  ;;Derecha arriba
             (cube (pos (+ (-cubesSize) (-cubesSize)) (+ (cubesSize) (offset)) (cubesSize)) 1/8)) ;;3
 (with-color (rgba "red")  ;;Derecha abajo
             (cube (pos (+ (-cubesSize) (-cubesSize)) (+ (cubesSize) (offset)) (-cubesSize)) 1/8)) ;;9
 (with-color (rgba "red") ;;Izquierda arriba
             (cube (pos 0 (+ (cubesSize) (offset)) (cubesSize)) 1/8))                              ;;1
 (with-color (rgba "red") ;;Izquierda abajo 
             (cube (pos 0 (+ (cubesSize) (offset)) (-cubesSize)) 1/8))                             ;;7
 ))  ;;(x y z) -> y es constante en 0.255 (+ (cubesSize) (offset))

(define topFace (combine(with-color (rgba "blue") ;;origen (centro)
             (cube (pos (-cubesSize) 0 (+ (cubesSize) (offset))) 1/8))                            ;;5
(with-color (rgba "blue") ;;arriba
             (cube (pos (+ (-cubesSize) (-cubesSize)) 0 (+ (cubesSize) (offset))) 1/8))           ;;2
(with-color (rgba "blue") ;;abajo
             (cube (pos 0 0 (+ (cubesSize) (offset))) 1/8))                                       ;;8
 (with-color (rgba "blue") ;;Derecha                              
             (cube (pos (-cubesSize) (cubesSize) (+ (cubesSize) (offset))) 1/8))                 ;;6        1 2 3 coinciden en Z(+ (cubesSize) (offset)) y en X(-2 cube size)
 (with-color (rgba "blue") ;;Izquierda 
             (cube (pos (-cubesSize) (-cubesSize) (+ (cubesSize) (offset))) 1/8))                  ;;4      4 5 6 coinciden en Z(+ (cubesSize) (offset)) y en X(- cube size)
 (with-color (rgba "blue")  ;;Derecha arriba
             (cube (pos (+ (-cubesSize) (-cubesSize)) (cubesSize) (+ (cubesSize) (offset))) 1/8))   ;;3     7 8 9 coinciden en Z(+ (cubesSize) (offset)) y en X(0)
 (with-color (rgba "blue")  ;;Derecha abajo
             (cube (pos 0 (cubesSize) (+ (cubesSize) (offset))) 1/8))                              ;;9
 (with-color (rgba "blue") ;;Izquierda arriba
             (cube (pos (+ (-cubesSize) (-cubesSize)) (-cubesSize) (+ (cubesSize) (offset))) 1/8))  ;;1
 (with-color (rgba "blue") ;;Izquierda abajo 
             (cube (pos 0 (-cubesSize) (+ (cubesSize) (offset))) 1/8))                             ;;7
 ))  ;;(x y z) -> z es constante en 0.255


(define blackLines
  (with-color (rgba "black") ;;Lineas del borde 
             (cube (pos -0.29 0 0) 0.418))
  )

(define cubo(parameterize ([current-pict3d-background  (rgba 240 240 240 1)])
     (combine  frontFace
           rightFace
           topFace
           blackLines
           (basis 'camera (point-at (pos 0.5 0.5 0.5) (pos -0.1 0.13 -0.2)))
           (light (pos 1 1 1)))))


(define cubeBitMap(parameterize ([current-pict3d-background  (rgba 240 240 240 1)])
    (pict3d->bitmap
     (combine cubo
              (light (pos 1 1 1))))))


(define (cubo2 matrix)
  (cubeMatrix matrix))

(define (cubeMatrix matrix)
     (parameterize ([current-pict3d-background  (rgba 240 240 240 1)])
     (combine
           (frontFace2 (car matrix) -1 1)
           (rightFace2 (cadr matrix) 0 1 (lengthList (cadr matrix)))
           (topFace2 (caddr matrix) -1 (* -1 (- (lengthList (caddr matrix)) 1)) (lengthList (caddr matrix)))
           ;;blackLines
           ;;(basis 'camera (point-at (pos 0.5 0.5 0.5) (pos -0.1 0.13 -0.2)))
           (light (pos 1 1 1)))))


;;Draw Front Face________________________________________________________________________________________________________________________________________
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


;;Draw right Face________________________________________________________________________________________________________________________________________

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

;;Draw top Face________________________________________________________________________________________________________________________________________

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

(define (cubeBitMap2 matrix)(parameterize ([current-pict3d-background  (rgba 240 240 240 1)])
    (pict3d->bitmap
     (combine (cubo2 matrix)
              (light (pos 1 1 1))))))

(define(lengthList lista)
  (cond((null? lista) 0)
       (else(+ 1 (lengthList(cdr lista))))
    )
)



(current-pict3d-add-sunlight? #t) 
(current-pict3d-fov 118)