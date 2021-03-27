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
    (if (not (limbic/javascript/ethereum:selected-address object))
        (progn (format t "trying to connect ...~&")
               (limbic/javascript/ethereum:eth-request-accounts object))
        (format t "already connected to ~A~&"
                (limbic/javascript/ethereum:selected-address object))))

  (defun connection-button (menu)
    (setf connection-button
          (create-gui-menu-item menu
                                :content unconnected-text
                                :html-id "ethereum-connect-menu-item"
                                :on-click 'connect-to-a-wallet))))

(defun menu (menu-bar)
  (let ((menu (create-gui-menu-drop-down menu-bar :content "Ethereum")))
    (connection-button  menu)))
