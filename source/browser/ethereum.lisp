(defpackage :limbic/browser/ethereum
  (:use :common-lisp :clog :clog-gui)
  (:export menu))
(in-package :limbic/browser/ethereum)

(defclass ethereum-wallet ()
  ((connected? :accessor connected?
               :initform nil)
   (address :accessor address
            :initform nil)))

(defun shortened-ethereum-address (ethereum-address)
  (let* ((front (string-upcase (subseq ethereum-address 2 6)))
         (len (length ethereum-address))
         (back  (string-upcase (subseq ethereum-address (- len 4) len))))
    (concatenate 'string "0x" front "..." back)))

(defun connected-text (ethereum-address)
  (format nil "MetaMask Connected ~A <div id='connectedWalletIdenticon' class='identicon'></div>"
          (shortened-ethereum-address ethereum-address)))

(defun attach-blockie-for-address (object ethereum-address)
  (js-execute object
              (format nil "connectedWalletIdenticon.style.backgroundImage = 'url(' + hqx(blockies.create({ seed:'~A' ,size: 8,scale: 1}),4).toDataURL()+')'"
                      ethereum-address)))

(defvar *unconnected-text* "Connect to your MetaMask Ethereum Wallet")

(defun update-connection-text (object)
  (let ((ethereum-wallet (connection-data-item object "ethereum-wallet"))
        (new-address (limbic/javascript/ethereum:selected-address object)))
    (cond ((and (not (connected? ethereum-wallet))
                (not (null new-address)))
           (js-execute object "console.log('got a new ethereum wallet connection')")
           (setf (connected? ethereum-wallet) t)
           (setf (address ethereum-wallet) new-address)
           (setf (inner-html (connection-data-item object "connection-button")) (connected-text new-address)))
          ((and (connected? ethereum-wallet)
                (null new-address))
           (js-execute object "console.log('we're no longer connected to an ethereum wallet')")
           (setf (connected? ethereum-wallet) nil)
           (setf (address ethereum-wallet) nil)
           (setf (inner-html (connection-data-item object "connection-button")) *unconnected-text*))
          ((and (connected? ethereum-wallet)
                (not (null new-address))
                (not (null (address ethereum-wallet)))
                (not (string= (address ethereum-wallet) new-address)))
           (js-execute object "console.log('connected to a different ethereum wallet now.')")
           (setf (address ethereum-wallet) new-address)
           (setf (inner-html (connection-data-item object "connection-button")) (connected-text new-address))))))

(defun connection-text-updater (object)
  (bordeaux-threads:make-thread
   (lambda ()
     (loop
        (update-connection-text object)
        (sleep 15)))
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
  (setf (connection-data-item menu "connection-button")
        (create-gui-menu-item menu
                              :content *unconnected-text*
                              :html-id "ethereum-connect-menu-item"
                              :on-click 'connect-to-a-wallet))
  (connection-text-updater menu))

(defun menu (menu-bar)
  (let ((menu (create-gui-menu-drop-down menu-bar :content "Ethereum")))
    (setf (connection-data-item menu "ethereum-wallet")
          (make-instance 'ethereum-wallet))
    (connection-button menu)
    (limbic/browser/components/prices:gui-menu-entry menu "ETH/BTC ~3$"       'zapper-fi:eth/btc)
    (limbic/browser/components/prices:gui-menu-entry menu "ETH/USD $~2$"      'zapper-fi:eth/usd)
    (limbic/browser/components/prices:gui-menu-entry menu "ETH/Gold ~3$ toz"  'zapper-fi:eth/xau)
    (limbic/browser/components/prices:gui-menu-entry menu "ETH/Silver ~A toz" 'zapper-fi:eth/xag)))
