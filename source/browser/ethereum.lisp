(defpackage #:limbic/browser/ethereum
  (:use #:cl #:clog #:clog-gui)
  (:export menu))
(in-package :limbic/browser/ethereum)

;; (defun update-connection-text (object)
;;   (if (limbic/javascript/ethereum:selected-address object)
;;       (attach-as-child)
;;       (setf (inner-html ))))

(let ((unconnected-text "Enable Ethereum (connect to your wallet)")
      (connected-text "Connected")
      (connection-button nil))

  (defun connect-to-a-wallet (object)
    (if (limbic/javascript/ethereum:selected-address object)
        (alert-dialog object
                      (format nil "Already connected to a wallet<br/>
                                   ~A<br/>
                                   You can disconnect in your wallet program."
                              (limbic/javascript/ethereum:selected-address object))
                      :width 500 :height 200
                      :title "Already Connected")
        (limbic/javascript/ethereum:eth-request-accounts object)))

  (defun connection-button (menu)
    (setf connection-button
          (create-gui-menu-item menu
                                :content unconnected-text
                                :html-id "ethereum-connect-menu-item"
                                :on-click 'connect-to-a-wallet))))

(defun menu (menu-bar)
  (let ((menu (create-gui-menu-drop-down menu-bar :content "Ethereum")))
    (connection-button  menu)))
