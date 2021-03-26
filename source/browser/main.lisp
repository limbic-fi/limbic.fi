(defpackage #:limbic/browser
  (:use #:cl #:clog #:clog-gui)
  (:export main))
(in-package :limbic/browser)

(defun static-root ()
  "Points to the static root file directory."
  (merge-pathnames "./static/" (asdf:system-source-directory :limbic)))

(defun ens-owner-lookup (object)
  (form-dialog object nil
               '(("ENS Name" "ens-name" :text "cgore.eth"))
               (lambda (results)
                 (let* ((ens-name (second (find "ens-name" results :key #'first :test #'string=))))
                   (alert-dialog object ;;results
                                 "<div id='ens-owner-lookup'>...</div>"
                                 :title (concatenate 'string "ENS Owner Lookup - " ens-name)
                                 :width 500
                                 :height 200)
                   (js-execute object "w1 = new Web3(Web3.givenProvider || 'ws://localhost:8545');")
                   (js-execute object (format nil "w1.eth.ens.getOwner('~A').then((owner)=>{document.getElementById('ens-owner-lookup').innerHTML = owner;})"
                                              ens-name))))
               :title "ENS Owner Lookup"
               :height 200))

(defun help-menu-about (object)
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
  (let* ((menu (create-gui-menu-bar body))
         (limbic-menu (create-gui-menu-drop-down menu :content "limbic.fi"))
         (ens-menu    (create-gui-menu-drop-down menu :content "ENS"))
         (help-menu   (create-gui-menu-drop-down menu :content "Help")))
    (create-gui-menu-item ens-menu :content "ENS Owner Lookup" :on-click 'ens-owner-lookup)
    (create-gui-menu-item help-menu :content "About" :on-click 'help-menu-about)))

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
