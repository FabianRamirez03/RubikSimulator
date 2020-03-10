
(require pict3d)
(require pict3d/universe)

(define (cubesSize)0.29)
(define (-cubesSize)-0.29)
(define (offset) 0.005)
(define (-offset) -0.005)

(define frontFace(combine(with-color (rgba "white") ;;origen (centro)
             (cube (pos (offset) 0 0) 1/8))
(with-color (rgba "white") ;;arriba
             (cube (pos (offset) 0 (cubesSize)) 1/8))
(with-color (rgba "white") ;;abajo
             (cube (pos (offset) 0 (-cubesSize)) 1/8))
 (with-color (rgba "white") ;;Derecha 
             (cube (pos (offset) (cubesSize) 0) 1/8))
 (with-color (rgba "white") ;;Izquierda 
             (cube (pos (offset) (-cubesSize) 0) 1/8))
 (with-color (rgba "white")  ;;Derecha arriba
             (cube (pos (offset) (cubesSize) (cubesSize)) 1/8))
 (with-color (rgba "white")  ;;Derecha abajo
             (cube (pos (offset)  (cubesSize) (-cubesSize)) 1/8))
 (with-color (rgba "white") ;;Izquierda arriba
             (cube (pos (offset) (-cubesSize) (cubesSize)) 1/8))
 (with-color (rgba "white") ;;Izquierda abajo 
             (cube (pos (offset) (-cubesSize) (-cubesSize)) 1/8))
 )) ;;(x y z) -> x es constante en el offset

(define rightFace (combine(with-color (rgba "red") ;;origen (centro)
             (cube (pos (-cubesSize) (+ (cubesSize) (offset)) 0) 1/8))
(with-color (rgba "red") ;;arriba
             (cube (pos (-cubesSize) (+ (cubesSize) (offset)) (cubesSize)) 1/8))
(with-color (rgba "red") ;;abajo
             (cube (pos (-cubesSize) (+ (cubesSize) (offset)) (-cubesSize)) 1/8))
 (with-color (rgba "red") ;;Derecha 
             (cube (pos (+ (-cubesSize) (-cubesSize)) (+ (cubesSize) (offset)) 0) 1/8))
 (with-color (rgba "red") ;;Izquierda 
             (cube (pos 0 (+ (cubesSize) (offset)) 0) 1/8))
 (with-color (rgba "red")  ;;Derecha arriba
             (cube (pos (+ (-cubesSize) (-cubesSize)) (+ (cubesSize) (offset)) (cubesSize)) 1/8))
 (with-color (rgba "red")  ;;Derecha abajo
             (cube (pos (+ (-cubesSize) (-cubesSize)) (+ (cubesSize) (offset)) (-cubesSize)) 1/8))
 (with-color (rgba "red") ;;Izquierda arriba
             (cube (pos 0 (+ (cubesSize) (offset)) (cubesSize)) 1/8))
 (with-color (rgba "red") ;;Izquierda abajo 
             (cube (pos 0 (+ (cubesSize) (offset)) (-cubesSize)) 1/8))
 ))  ;;(x y z) -> y es constante en 0.255

(define topFace (combine(with-color (rgba "blue") ;;origen (centro)
             (cube (pos (-cubesSize) 0 (+ (cubesSize) (offset))) 1/8))
(with-color (rgba "blue") ;;arriba
             (cube (pos (+ (-cubesSize) (-cubesSize)) 0 (+ (cubesSize) (offset))) 1/8))
(with-color (rgba "blue") ;;abajo
             (cube (pos 0 0 (+ (cubesSize) (offset))) 1/8))
 (with-color (rgba "blue") ;;Derecha 
             (cube (pos (-cubesSize) (cubesSize) (+ (cubesSize) (offset))) 1/8))
 (with-color (rgba "blue") ;;Izquierda 
             (cube (pos (-cubesSize) (-cubesSize) (+ (cubesSize) (offset))) 1/8))
 (with-color (rgba "blue")  ;;Derecha arriba
             (cube (pos (+ (-cubesSize) (-cubesSize)) (cubesSize) (+ (cubesSize) (offset))) 1/8))
 (with-color (rgba "blue")  ;;Derecha abajo
             (cube (pos 0 (cubesSize) (+ (cubesSize) (offset))) 1/8))
 (with-color (rgba "blue") ;;Izquierda arriba
             (cube (pos (+ (-cubesSize) (-cubesSize)) (-cubesSize) (+ (cubesSize) (offset))) 1/8))
 (with-color (rgba "blue") ;;Izquierda abajo 
             (cube (pos 0 (-cubesSize) (+ (cubesSize) (offset))) 1/8))
 ))  ;;(x y z) -> z es constante en 0.255


(define bottomFace (combine(with-color (rgba "orange") ;;origen (centro)
             (cube (pos -0.25 0 -0.255) 1/8))
(with-color (rgba "orange") ;;arriba
             (cube (pos -0.001 0 -0.255) 1/8))
(with-color (rgba "orange") ;;abajo
             (cube (pos -0.50 0 -0.255) 1/8))
 (with-color (rgba "blue") ;;Derecha 
             (cube (pos -0.25 -0.25 -0.255) 1/8))
 (with-color (rgba "blue") ;;Izquierda 
             (cube (pos -0.25 0.25 -0.255) 1/8))
 (with-color (rgba "blue")  ;;Derecha arriba
             (cube (pos -0.001 -0.25 -0.255) 1/8))
 (with-color (rgba "blue")  ;;Derecha abajo
             (cube (pos -0.50 -0.25 -0.255) 1/8))
 (with-color (rgba "blue") ;;Izquierda arriba
             (cube (pos -0.001 0.25 -0.255) 1/8))
 (with-color (rgba "blue") ;;Izquierda abajo 
             (cube (pos -0.50 0.25 -0.255) 1/8))
 ))  ;;(x y z) -> z es constante en -0.255


(define leftFace (combine(with-color (rgba "orange") ;;origen (centro)
             (cube (pos (-cubesSize) (+ (-cubesSize) (-offset)) 0) 1/8))
(with-color (rgba "orange") ;;arriba
             (cube (pos (-cubesSize) (+ (-cubesSize) (-offset)) (cubesSize)) 1/8))
(with-color (rgba "orange") ;;abajo
             (cube (pos (-cubesSize) (+ (-cubesSize) (-offset)) (-cubesSize)) 1/8))
 (with-color (rgba "orange") ;;Derecha 
             (cube (pos (+ (-cubesSize) (-cubesSize)) (+ (-cubesSize) (-offset)) 0) 1/8))
 (with-color (rgba "orange") ;;Izquierda 
             (cube (pos 0 (+ (-cubesSize) (-offset)) 0) 1/8))
 (with-color (rgba "orange")  ;;Derecha arriba
             (cube (pos (+ (-cubesSize) (-cubesSize)) (+ (-cubesSize) (-offset)) (cubesSize)) 1/8))
 (with-color (rgba "orange")  ;;Derecha abajo
             (cube (pos (+ (-cubesSize) (-cubesSize)) (+ (-cubesSize) (-offset)) (-cubesSize)) 1/8))
 (with-color (rgba "orange") ;;Izquierda arriba
             (cube (pos 0 (+ (-cubesSize) (-offset)) (cubesSize)) 1/8))
 (with-color (rgba "orange") ;;Izquierda abajo 
             (cube (pos 0 (+ (-cubesSize) (-offset)) (-cubesSize)) 1/8))
 ))  ;;(x y z) -> y es constante en -0.255


(define backFace (combine(with-color (rgba "green") ;;origen (centro)
             (cube (pos (+ (-cubesSize) (-cubesSize) (-offset)) 0 0) 1/8))
(with-color (rgba "green") ;;arriba
             (cube (pos (+ (-cubesSize) (-cubesSize) (-offset)) 0 (cubesSize)) 1/8))
(with-color (rgba "green") ;;abajo
             (cube (pos (+ (-cubesSize) (-cubesSize) (-offset)) 0 (-cubesSize)) 1/8))
 (with-color (rgba "green") ;;Derecha 
             (cube (pos (+ (-cubesSize) (-cubesSize) (-offset)) (cubesSize) 0) 1/8))
 (with-color (rgba "green") ;;Izquierda 
             (cube (pos (+ (-cubesSize) (-cubesSize) (-offset)) (-cubesSize) 0) 1/8))
 (with-color (rgba "green")  ;;Derecha arriba
             (cube (pos (+ (-cubesSize) (-cubesSize) (-offset)) (cubesSize) (cubesSize)) 1/8))
 (with-color (rgba "green")  ;;Derecha abajo
             (cube (pos (+ (-cubesSize) (-cubesSize) (-offset))  (cubesSize) (-cubesSize)) 1/8))
 (with-color (rgba "green") ;;Izquierda arriba
             (cube (pos (+ (-cubesSize) (-cubesSize) (-offset)) (-cubesSize) (cubesSize)) 1/8))
 (with-color (rgba "green") ;;Izquierda abajo 
             (cube (pos (+ (-cubesSize) (-cubesSize) (-offset)) (-cubesSize) (-cubesSize)) 1/8))
 ))  ;;(x y z) -> x es constante en -0.5


(define blackLines
  (with-color (rgba "black") ;;Lineas del borde 
             (cube (pos -0.29 0 0) 0.418))
  )


(define cubo
  (combine frontFace
           rightFace
           leftFace
           topFace
           backFace
           bottomFace
           blackLines
           (basis 'camera (point-at (pos 0.35 0.5 0.5) (pos -0.2 0.1 0)))
           (light (pos 1 1 1))
 ))
(define cubeBitMap(parameterize ([current-pict3d-background  (rgba "white" 0)])
    (pict3d->bitmap
     (combine cubo
              (light (pos 1 1 1))))))

(current-pict3d-add-sunlight? #t) 
(current-pict3d-fov 118)
cubo

