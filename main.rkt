#lang Racket
(require racket/gui/base)
(require racket/gui)
(require pict3d)
(require racket/include)
(require 2htdp/batch-io)
(require racket/format)
(include "Logic/cubeDrawer.rkt")
(include "Logic/CreacionGrafos.rkt")

;;Fuentes
(define (titleFont size)  (make-object font% size 'modern 'normal 'bold))
(define (menuFont size)  (make-object font% size 'swiss 'normal 'bold))

;;______________________________________Estructura de la ventana principal___________________________________________

;Panel principal
(define mainFrame (new frame%
                       [label "Rubik Simulator"]
                       [height 600]
                       [x 60]
                       [y 20]
                       [style '(no-resize-border)]))

;;Panel que contiene el titulo
(define titlePanel
  (new vertical-panel%
       [parent mainFrame]
       [style '(border)]
       [stretchable-height #f]
       ;;[alignment ('center 'top)]
       ))
;;Panel que contiene el juego
(define gamePanel
  (new horizontal-panel%
       [parent mainFrame]
       ;;[stretchable-height #f]
       ;;[alignment ('center 'top)]
       ))

;;Panel que contiene el cubo
(define cubeColumn
  (new vertical-panel%
       [parent gamePanel]
       [min-width 450]
       [style '(border)]
       ;;[alignment ('center 'center)]
       ))
;;Panel que contiene el menu
(define menuColumn
  (new vertical-panel%
       [parent gamePanel]
       [min-width 450]
       [style '(border)]
       ;;[stretchable-width #f]

       ;;[alignment ('center 'center)]
       ))

;;__________________________Paneles de menu____________________________________________

;;espacio superior para centrar el resto del contenido
(define topBlankRow
  (new horizontal-panel%
       [parent menuColumn]
       ;;[alignment ('center 'center)]
))
;;Contiene el boton para devolver la jugada hecha
(define reverseRow
  (new vertical-panel%
       [parent menuColumn]
       [min-height 110]
       [stretchable-height #f]

       [alignment '(left center)]
       ;;[alignment ('center 'center)]
))


;;espacio para decidir el movimiento que se quiere realizar
(define movesRow
  (new horizontal-panel%
       [parent menuColumn]
       [min-height 110]
       [stretchable-height #f]
       [alignment '(center center)]
       ;;[alignment ('center 'center)]
))

;;espacio para decidir lo rotacion del cubo que se quiere realizar
(define rotationRow
  (new horizontal-panel%
       [parent menuColumn]
       [min-height 110]
       [stretchable-height #f]
       [alignment '(center center)]
))
;;;;espacio inferior para centrar el resto del contenido


;;_____________________Funciones que dibujan el cubo en el canvas________________________________________________________

; Dubuja el cubo en el canvas
(define (drawCube canvas dc)
  (send dc set-scale 2 2)
  (send dc draw-bitmap  (cubeBitMap (stringtolistCube  (read-1strings "Logic/cube.txt") '())) 0 0)
)
;Hace la conversión de figura 3D a bitMap
(define canvasCubeBitMap
  (new canvas% [parent cubeColumn]
               [paint-callback drawCube]
       ))


;;Main window Widgets_________________________________________________

;;Titulo
(define title(new message% 	[label "Rubik Simulator"]	 
   	 	[parent titlePanel]
                [font (titleFont 50)]))
;;Campo para definir de que dimensiones quiere el nuevo cubo
(define newGameField (new text-field%
                        (label "Nuevo Juego:")
                        (parent topBlankRow)
                        (init-value "Dimensión")
                        [font (menuFont 20)]))
;Boron para iniciar el nuevo juego 
(define newGameButton (new button%
                    (parent topBlankRow)
                    (label "Iniciar")
                    [callback (lambda (button event) (newGameUpdate))]
                    [font (menuFont 20)]))

;;Boton para devolver la jugada
(define reverseButton (new button%
                    (parent reverseRow)
                    (label "Reversa")
                    [callback (lambda (button event) (reverse))]
                    [font (menuFont 20)]))
;;Textfield para introducir la jugada a realizar
(define movesField (new text-field%
                        (label "Jugada:")
                        (parent movesRow)
                        (init-value "Introduzca el movimiento")
                        [font (menuFont 20)]))
;;Boton para realizar movimiento definido en el textField
(define moveButton (new button%
                    (parent movesRow)
                    (label "Mover")
                    [callback (lambda (button event) (makeMove (cdr (splitMove (send movesField get-value)))))]
                    [font (menuFont 20)]))
;Columna para girar las diferentes caras del cubo
(define turnLabel (new message%
                [label "Girar:"]	 
   	 	[parent rotationRow]
                [font (menuFont 20)]))


;;________________Botones para girar el cubo___________________________


;Gira el cubo hacia arriba
(define turnUpButton (new button%
                    (parent rotationRow)
                    (label "Arriba")
                    [callback (lambda (button event) (upTwist))]
                    [font (menuFont 20)]))

;Gira el cubo hacia abajo
(define turnDownButton (new button%
                    (parent rotationRow)
                    (label "Abajo")
                    [callback (lambda (button event) (downTwist))]
                    [font (menuFont 20)]))

;Gira el cubo hacia la derecha
(define turnRightButton (new button%
                    (parent rotationRow)
                    (label "Derecha")
                    [callback (lambda (button event) (rightTwist))]
                    [font (menuFont 20)]))

;Gira el cubo hacia la izquierda
(define turnLeftButton (new button%
                    (parent rotationRow)
                    (label "Izquierda")
                    [callback (lambda (button event) (leftTwist))]
                    [font (menuFont 20)]))


;________________________________________________________________________FUNCIONES LÓGICAS_____________________________________________________________________-






;______________________________Actualiza el estado de la ventana principal____________________________


;;Actualiza el nuevo juego con un cubo con una nueva dimension
(define (newGameUpdate)
  (create (string->number(send newGameField get-value)))
  (write-file "reverse.txt" (~a "V"))
  (windowUpdater)
  )

;actualiza la ventana principal
(define (windowUpdater)
  (send mainFrame refresh))

;Divide la jugada que se quiere hacer
(define (splitMove move) (string-split move #rx"(?<=.)(?=.)"))

;;Realiza la modificación del cubo que el usuario decidió hacer
 (define (makeMove move)
   (rotate (string->number (car move)) (cadr move))
   (write-file "reverse.txt" (~a (string-append* (car move) (invertMove (cadr move)) (file->lines "reverse.txt"))))
   (windowUpdater)
   )
;Gira el cubo hacia arriba
(define (upTwist)
  (girar "U")
  (writeTwist "U")
  (windowUpdater))
;Gira el cubo hacia abajo
(define (downTwist)
  (girar "D")
  (writeTwist "D")
  (windowUpdater))
;Gira el cubo hacia la derecha
(define (rightTwist)
  (girar "R")
  (writeTwist "R")
  (windowUpdater))
;Gira el cubo hacia la izquierda
(define (leftTwist)
  (girar "L")
  (writeTwist "L")
  (windowUpdater))

;;_________________________________________________REVERSA__________________________________________________

;;Devuelve el ultimo movimiento realizado
(define (reverse)
  (reverseAux (string-split (car(file->lines "reverse.txt")) #rx"(?<=.)(?=.)"))
  )
(define (reverseAux moves)
  (cond((equal? (car moves) "V")#f)
       ((equal? (cadr moves) "U")(girar "U")(windowUpdater)(write-file "reverse.txt" (~a (string-append* (cddr moves)))))
       ((equal? (cadr moves) "D")(girar "D")(windowUpdater)(write-file "reverse.txt" (~a (string-append* (cddr moves)))))
       ((equal? (cadr moves) "L")(girar "L")(windowUpdater)(write-file "reverse.txt" (~a (string-append* (cddr moves)))))
       ((equal? (cadr moves) "R")(girar "R")(windowUpdater)(write-file "reverse.txt" (~a (string-append* (cddr moves)))))
       (else (rotate (string->number (car moves)) (cadr moves))
             (windowUpdater)
             (write-file "reverse.txt" (~a (string-append* (cddr moves)))))
    )
  
  )
;Invierte el movimiento realizado para regresar al punto inicial
(define (invertMove move)
  (cond((equal? "I" move) "D")
       ((equal? "D" move) "I")
       ((equal? "A" move) "B")
       ((equal? "B" move) "A")
    )
  )
;Escribe en giro del cubo en el txt en caso de regresar el movimiente

(define (writeTwist dir)
  (cond((equal? "U" dir) (write-file "reverse.txt" (~a (string-append* "0" "D" (file->lines "reverse.txt")))))
       ((equal? "D" dir) (write-file "reverse.txt" (~a (string-append* "0" "U" (file->lines "reverse.txt")))))
       ((equal? "L" dir) (write-file "reverse.txt" (~a (string-append* "0" "R" (file->lines "reverse.txt")))))
       ((equal? "R" dir) (write-file "reverse.txt" (~a (string-append* "0" "L" (file->lines "reverse.txt")))))
    )
  )

(send mainFrame show #t)