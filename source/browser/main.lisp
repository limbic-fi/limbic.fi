(defpackage #:limbic/browser
  (:use #:cl #:clog #:clog-gui)
  (:export main))
(in-package :limbic/browser)

(defun static-root ()
  "Points to the static root file directory."
  (merge-pathnames "./static/" (asdf:system-source-directory :limbic)))

(defun limbic-menu-about (object)
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

(defun menu-bar (body)
  (let* ((menu-bar (create-gui-menu-bar body))
         (limbic-menu   (create-gui-menu-drop-down menu-bar :content "limbic.fi"))
         (ethereum-menu (create-gui-menu-drop-down menu-bar :content "Ethereum"))
         (_             (limbic/browser/ens:menu menu-bar))
         (help-menu     (create-gui-menu-drop-down menu-bar :content "Help")))
    (create-gui-menu-item limbic-menu :content "About" :on-click 'limbic-menu-about)))

(defun on-new-window (body)
  "Handler for each new web browser window."
  (setf (title (html-document body)) "limbic.fi")
  (load-script (html-document body) "https://cdn.jsdelivr.net/npm/web3@latest/dist/web3.min.js")
  (clog-gui-initialize body)
  (menu-bar body)
  (run body))

(defun main ()
  (initialize #'on-new-window
              :static-root (static-root))
  (open-browser))
