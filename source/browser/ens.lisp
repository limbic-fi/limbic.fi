(defpackage #:limbic/browser/ens
  (:use #:cl #:clog #:clog-gui)
  (:export menu owner-lookup))
(in-package :limbic/browser/ens)

(defun owner-lookup (object)
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

(defun menu (menu-bar)
  (let ((menu (create-gui-menu-drop-down menu-bar :content "ENS")))
    (create-gui-menu-item menu :content "ENS Owner Lookup" :on-click 'owner-lookup)))
