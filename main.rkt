#lang racket
(require racket/gui/base)
(require racket/gui)
(require pict3d)
(require racket/include)
(include "Logic/cubeDrawer.rkt")
(include "Graphics/mainWindow.rkt")


(define frame (new frame% [label "Rubik Simulator"] [width 800] [height 800]))

(CanvasCube frame)


(send frame show #t)