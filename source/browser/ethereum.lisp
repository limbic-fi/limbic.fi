(defpackage #:limbic/browser/ethereum
  (:use #:cl #:clog #:clog-gui)
  (:export menu))
(in-package :limbic/browser/ethereum)

(defun usd-price-content ()
  (format nil "ETH/USD $~2$" (zapper-fi:eth/usd)))

(defun xag-price-content ()
  (format nil "ETH/Silver ~A toz" (zapper-fi:eth/xag)))

(defun xau-price-content ()
  (format nil "ETH/Gold ~3$ toz" (zapper-fi:eth/xau)))

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

(let ((unconnected-text "Connect to your MetaMask Ethereum Wallet")
      (connection-button nil)
      (connected? nil))

  (defun update-connection-text (object)
    (let ((address (limbic/javascript/ethereum:selected-address object)))
      (cond ((and (not address) connected?)
             (setf connected? nil)
             (setf (inner-html connection-button) unconnected-text)
             (format t "No longer connected to your ethereum wallet, address ~A.~&" address))
            ((and address (not connected?))
             (setf connected? t)
             (setf (inner-html connection-button) (connected-text address))
             (attach-blockie-for-address object address)
             (format t "Now connected to your ethereum wallet, address ~A.~&" address)))))

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
    (connection-button  menu)
    (usd-price menu)
    (xau-price menu)
    (xag-price menu)))
