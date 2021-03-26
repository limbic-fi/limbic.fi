(defpackage #:limbic/browser/help
  (:use #:cl #:clog #:clog-gui)
  (:export menu))
(in-package :limbic/browser/help)

(defun menu (menu-bar)
  (create-gui-menu-drop-down menu-bar :content "Help"))
