(defpackage #:limbic/browser/limbic
  (:use #:cl #:clog #:clog-gui)
  (:export menu))
(in-package :limbic/browser/limbic)

(defun about (object)
  (let ((about (create-gui-window object
                                  :title   "About"
                                  :content
                                  "<div>
                                     <center><img src='/favicon-192.png'></center>
                                     <center><h1>limbic.fi</h1></center>
                                     <p><center>Copyright (c) 2021 Christopher Mark Gore, all rights reserved.</center></p>
                                   </div>"
                                  :hidden  t
                                  :width   400
                                  :height  400)))
    (window-center about)
    (setf (visiblep about) t)
    (set-on-window-can-size about
                            (lambda (object)
                              (declare (ignore object))
                              ()))))

(defun menu (menu-bar)
  (let ((menu (create-gui-menu-drop-down menu-bar :content "limbic.fi")))
    (create-gui-menu-item menu :content "About" :on-click 'about)))
