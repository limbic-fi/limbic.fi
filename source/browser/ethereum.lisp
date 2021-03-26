(defpackage #:limbic/browser/ethereum
  (:use #:cl #:clog #:clog-gui)
  (:export menu))
(in-package :limbic/browser/ethereum)

(defun menu (menu-bar)
  (create-gui-menu-drop-down menu-bar :content "Ethereum"))
