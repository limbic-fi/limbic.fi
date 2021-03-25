(defpackage #:limbic/browser
  (:use #:cl #:clog #:clog-gui)
  (:export main))
(in-package :limbic/browser)

(defun static-root ()
  "Points to the static root file directory."
  (merge-pathnames "./static/" (asdf:system-source-directory :limbic)))

(defun ens-lookup-cgore (object)
  (js-execute object "w1 = new Web3(Web3.givenProvider || 'ws://localhost:8545');")
  (js-execute object "w1.eth.ens.getOwner('cgore.eth').then((owner)=>{alert('cgore.eth is ' + owner)})")
  ;; 0xF3C95410b8F61ae7cBA3Fe0925F64bCa7871e4d5
  )

(defun ens-owner (object)
  (form-dialog object "ENS Owner"
               '(("ENS Name" "ens-name" :text "cgore.eth"))
               (lambda (results)
                 (js-execute object "w1 = new Web3(Web3.givenProvider || 'ws://localhost:8545');
                                     w1.eth.ens.getOwner('cgore.eth').then((owner)=>{document.getElementById('ens-owner-result').innerHTML = owner;})")
                 (alert-dialog object ;;results
                               "<div id='ens-owner-result'>...</div>"
                               :width 750
                             ))))

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
    (create-gui-menu-item ens-menu :content "ENS lookup cgore.eth" :on-click 'ens-lookup-cgore)
    (create-gui-menu-item ens-menu :content "ENS Owner" :on-click 'ens-owner)
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
