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

(define (titleFont size)  (make-object font% size 'modern 'normal 'bold))

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
;;Panel que contiene el titulo
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
;;Panel que contiene el cubo
(define controlsColumn
  (new vertical-panel%
       [parent gamePanel]
       [min-width 450]
       ;;[stretchable-width #f]
       [style '(border)]
       ;;[alignment ('center 'center)]
       ))

;;Canvas Drawers________________________________________________________

; Draws menu elements in canvas
(define (drawCube canvas dc)
  (send dc set-scale 2 2)
  (send dc draw-bitmap  (cubeBitMap2 (create 10)) 0 0)
)

(define canvasCubeBitMap
  (new canvas% [parent cubeColumn]
               [paint-callback drawCube]
       ))


;;Main window Widgets 
(new message% 	[label "Rubik Simulator"]	 
   	 	[parent titlePanel]
                [font (titleFont 50)])





(send mainFrame show #t)