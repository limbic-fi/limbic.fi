(defpackage #:limbic/browser/bitcoin
  (:use :common-lisp :clog :clog-gui)
  (:export :menu))
(in-package :limbic/browser/bitcoin)

(defun usd-price-content ()
  (format nil "BTC/USD $~2$" (zapper-fi:btc/usd)))

(defun xag-price-content ()
  (format nil "BTC/Silver ~A toz" (zapper-fi:btc/xag)))

(defun xau-price-content ()
  (format nil "BTC/Gold ~3$ toz" (zapper-fi:btc/xau)))

(defun eth-price-content ()
  (format nil "BTC/ETH ~3$" (zapper-fi:btc/eth)))

(defun usd-price (menu)
  (create-gui-menu-item menu :content (usd-price-content) :html-id "btc-usd-price"))

(defun xag-price (menu)
  (create-gui-menu-item menu :content (xag-price-content) :html-id "btc-xag-price"))

(defun xau-price (menu)
  (create-gui-menu-item menu :content (xau-price-content) :html-id "btc-xau-price"))

(defun eth-price (menu)
  (create-gui-menu-item menu :content (eth-price-content) :html-id "btc-eth-price"))

(defun menu (menu-bar)
  (let ((menu (create-gui-menu-drop-down menu-bar :content "Bitcoin")))
    (usd-price menu)
    (xau-price menu)
    (xag-price menu)
    (eth-price menu)))
