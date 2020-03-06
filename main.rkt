#lang racket
(require racket/gui/base)
(require racket/gui)
(require pict3d)
(require racket/include)
(include "Logic/cubeDrawer.rkt")



(define mainFrame (new frame%
                       [label "Rubik Simulator"]
                       [width 1400]
                       [height 800]
                       [x 110]
                       [y 20]))

(define row
  (new horizontal-panel%
       [parent mainFrame]
       [style '(border)]))

(define leftColumn
  (new horizontal-panel%
       [parent row]
       [style '(border)]))

(define cubeColumn
  (new horizontal-panel%
       [parent row]
       [style '(border)]))

(define leftPanel
  (new vertical-panel%
       [parent leftColumn]
       [style '(border)]
       [alignment '(left center)]
       ))

; Make a static text message in the frame


(new message%	 
   	 	[label "Rubik Simulator"]	 
   	 	[parent leftPanel]
                [auto-resize #t]
   	 	)

(define CanvasCube
  (new pict3d-canvas%
                    [parent cubeColumn]
                    [pict3d (combine cubo
                                     (light (pos 1 1 1)))]))



(send mainFrame show #t)