#lang racket
(require racket/gui/base)
(require racket/gui)
(require pict3d)
(require racket/include)
(include "Logic/cubeDrawer.rkt")
(include "Logic/CreacionGrafos.rkt")


; Load images
(define blackBackGround (make-object bitmap% "Assets/blackBackground.png"))
(define logo (make-object bitmap% "Assets/logo.png"))


;;Fuentes
(define (titleFont size)  (make-object font% size 'modern 'normal 'bold))
(define (menuFont size)  (make-object font% size 'swiss 'normal 'bold))

;Blank bitmap for resize
(define bitmap-blank
  (lambda [[w 0] [h #false] #:backing-scale [backing-scale 2.0]]
    (define width  (max 1 (exact-ceiling w)))
    (define height (max 1 (exact-ceiling (or h w))))
    (make-bitmap width height #:backing-scale backing-scale)))

;Resize bitmap
(define bitmap-scale
  (case-lambda
    [(bmp scale)
     (if (= scale 1.0) bmp (bitmap-scale bmp scale scale))]
    [(bmp scale-x scale-y)
     (cond [(and (= scale-x 1.0) (= scale-y 1.0)) bmp]
           [else (let ([w (max 1 (exact-ceiling (* (send bmp get-width) scale-x)))]
                       [h (max 1 (exact-ceiling (* (send bmp get-height) scale-y)))])
                   (define dc (make-object bitmap-dc% (bitmap-blank w h)))
                   (send dc set-smoothing 'aligned)
                   (send dc set-scale scale-x scale-y)
                   (send dc draw-bitmap bmp 0 0)
                   (or (send dc get-bitmap) (bitmap-blank)))])]))

;;Main Window Structure  _________________________________________________________________________
(define mainFrame (new frame%
                       [label "Rubik Simulator"]
                       [width 10]
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
       [style '(border)]
       ;;[stretchable-height #f]
       ;;[alignment ('center 'top)]
       ))

;;Panel que contiene el cubo
(define cubeColumn
  (new vertical-panel%
       [parent gamePanel]
       [min-width 450]
       ;;[stretchable-width #t]
       [style '(border)]
       ;;[alignment ('center 'center)]
       ))
;;Panel que contiene el menu
(define menuColumn
  (new vertical-panel%
       [parent gamePanel]
       [min-width 450]
       ;;[stretchable-width #f]
       [style '(border)]
       ;;[alignment ('center 'center)]
       ))

;;__________________________Paneles de menu____________________________________________

;;espacio superior para centrar el resto del contenido
(define topBlankRow
  (new horizontal-panel%
       [parent menuColumn]
       [style '(border)]
       ;;[alignment ('center 'center)]
))
;;Contiene el boton para devolver la jugada hecha
(define reverseRow
  (new vertical-panel%
       [parent menuColumn]
       [min-height 110]
       [stretchable-height #f]
       [style '(border)]
       [alignment '(left center)]
       ;;[alignment ('center 'center)]
))


;;espacio para decidir el movimiento que se quiere realizar
(define movesRow
  (new horizontal-panel%
       [parent menuColumn]
       [min-height 110]
       [stretchable-height #f]
       [style '(border)]
       [alignment '(center center)]
       ;;[alignment ('center 'center)]
))

;;espacio para decidir lo rotacion del cubo que se quiere realizar
(define rotationRow
  (new horizontal-panel%
       [parent menuColumn]
       [min-height 110]
       [stretchable-height #f]
       [style '(border)]
       [alignment '(center center)]
))
;;;;espacio inferior para centrar el resto del contenido


;;Canvas Drawers________________________________________________________

; Draws menu elements in canvas
(define (drawCube canvas dc)
  (send dc set-scale 2 2)
  (send dc draw-bitmap  (cubeBitMap2 (create 3)) 0 0)
)

(define canvasCubeBitMap
  (new canvas% [parent cubeColumn]
               [paint-callback drawCube]
       ))


;;Main window Widgets_________________________________________________

;;Titulo
(define title(new message% 	[label "Rubik Simulator"]	 
   	 	[parent titlePanel]
                [font (titleFont 50)]))
;;Boton para un nuevo juego
(define newGameField (new text-field%
                        (label "Nuevo Juego:")
                        (parent topBlankRow)
                        (init-value "Dimensión")
                        [font (menuFont 20)]))
(define newGameButton (new button%
                    (parent topBlankRow)
                    (label "Iniciar")
                    [font (menuFont 20)]))

;;Boton para devolver la jugada
(define reverseButton (new button%
                    (parent reverseRow)
                    (label "Reversa")
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
                    [font (menuFont 20)]))
;Columna para girar las diferentes caras del cubo
(define turnLabel (new message%
                [label "Girar:"]	 
   	 	[parent rotationRow]
                [font (menuFont 20)]))
;;Botones para girar el cubo
(define turnUpButton (new button%
                    (parent rotationRow)
                    (label "Arriba")
                    [font (menuFont 20)]))
(define turnDownButton (new button%
                    (parent rotationRow)
                    (label "Abajo")
                    [font (menuFont 20)]))
(define turnRightButton (new button%
                    (parent rotationRow)
                    (label "Derecha")
                    [font (menuFont 20)]))
(define turnLeftButton (new button%
                    (parent rotationRow)
                    (label "Izquierda")
                    [font (menuFont 20)]))

(send mainFrame show #t)