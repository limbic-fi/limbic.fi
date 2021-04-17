(defpackage :limbic/browser/ethereum
  (:use :common-lisp :clog :clog-gui)
  (:export menu))
(in-package :limbic/browser/ethereum)

(defun btc-price-content ()
  (format nil "ETH/BTC ~3$" (zapper-fi:eth/btc)))

(defun usd-price-content ()
  (format nil "ETH/USD $~2$" (zapper-fi:eth/usd)))

(defun xag-price-content ()
  (format nil "ETH/Silver ~A toz" (zapper-fi:eth/xag)))

(defun xau-price-content ()
  (format nil "ETH/Gold ~3$ toz" (zapper-fi:eth/xau)))

(defun btc-price (menu)
  (create-gui-menu-item menu :content (usd-price-content) :html-id "eth-btc-price"))

(defun usd-price (menu)
  (create-gui-menu-item menu :content (usd-price-content) :html-id "eth-usd-price"))

(defun xag-price (menu)
  (create-gui-menu-item menu :content (xag-price-content) :html-id "eth-xag-price"))

(defun xau-price (menu)
  (create-gui-menu-item menu :content (xau-price-content) :html-id "eth-xau-price"))

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
  (let ((address (limbic/javascript/ethereum:selected-address object)))
    (cond ((and (not address)
                (connection-data-item object "connected?"))
           (setf (connection-data-item object "connected?") nil)
           (setf (inner-html (connection-data-item object "connection-button")) *unconnected-text*))
          ((and address (not (connection-data-item object "connected?")))
           (setf (connection-data-item object "connected?") t)
           (setf (inner-html (connection-data-item object "connection-button")) (connected-text address))
           (attach-blockie-for-address object address)))))

(defun connection-text-updater (object)
  (bordeaux-threads:make-thread
   (lambda ()
     (setf (connection-data-item object "connected?") nil)
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
    (connection-button menu)
    (btc-price menu)
    (usd-price menu)
    (xau-price menu)
    (xag-price menu)))
