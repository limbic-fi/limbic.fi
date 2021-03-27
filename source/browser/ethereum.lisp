(defpackage #:limbic/browser/ethereum
  (:use #:cl #:clog #:clog-gui)
  (:export menu))
(in-package :limbic/browser/ethereum)

(let ((unconnected-text "Connect to your Ethereum Wallet")
      (connected-text "Connected!")
      (connected? nil)
      (connection-button nil))

  (defun update-connection-text (object)
    (let ((address (limbic/javascript/ethereum:selected-address object)))
      (format t "address is ~A~&" address)
      (cond ((and (not address) connected?)
             (setf (inner-html connection-button) unconnected-text)
             (setf connected? nil)
             (format t "No longer connected to your ethereum wallet.~&"))
            ((and address (not connected?))
             (setf (inner-html connection-button) connected-text)
             (setf connected? t)
             (format t "Now connected to your ethereum wallet.~&")))))

  (defun connection-text-updater (object)
    (bordeaux-threads:make-thread
     (lambda ()
       (loop
          (update-connection-text object)
          (sleep 1)))
     :name "connection-text-updater"))

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
                                :on-click 'connect-to-a-wallet))
    (connection-text-updater menu)))

(defun menu (menu-bar)
  (let ((menu (create-gui-menu-drop-down menu-bar :content "Ethereum")))
    (connection-button  menu)))
