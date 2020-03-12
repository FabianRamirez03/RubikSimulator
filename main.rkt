#lang racket
(require racket/gui/base)
(require racket/gui)
(require pict3d)
(require racket/include)
(include "Logic/cubeDrawer.rkt")


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
                       [width 1400]
                       [height 800]
                       [x 60]
                       [y 20]
                       [style '(no-resize-border)]))

(define row
  (new horizontal-panel%
       [parent mainFrame]
       ))

(define leftColumn
  (new horizontal-panel%
       [parent row]
       ))

(define cubeColumn
  (new horizontal-panel%
       [parent row]
       ))

(define leftPanel
  (new vertical-panel%
       [parent leftColumn]
       [alignment '(center top)]
   )
)


;;Canvas Drawers________________________________________________________

; Draws menu elements in canvas
(define (drawMenu canvas dc)
  (send dc set-scale 2 2)
  (send dc draw-bitmap  cubeBitMap 0 0)
  ;;(send dc set-background "yellow")
  ;;(send dc draw-bitmap (bitmap-scale logo 0.55) 0 10)
  )

(define CanvasCube
  (new pict3d-canvas%
                    [parent cubeColumn]
                    [pict3d (combine cubo
                                     (light (pos 1 1 1)))
                            ]
                    ))

;;Main window Widgets 
(new message% 	[label "Rubik Simulator"]	 
   	 	[parent leftPanel]
                [font (titleFont 60)])



(current-pict3d-background (rgba "white"))
(current-pict3d-fov 90)

(send mainFrame show #t)