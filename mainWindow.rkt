#lang racket
(require racket/gui/base)
(require racket/gui)
(require pict3d)
(require racket/include)
(include "cubeDrawer.rkt")

(define CanvasCube parentFrame
  (new pict3d-canvas%
                    [parent parentFrame]
                    [pict3d (combine cubo
                                     (light (pos 1 1 1)))]))