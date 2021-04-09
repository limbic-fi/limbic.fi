(defpackage #:limbic/browser/bitcoin
  (:use :common-lisp :clog :clog-gui)
  (:export :menu))
(in-package :limbic/browser/bitcoin)

(defun usd-price-content ()
  (format nil "USD/BTC $~2$" (zapper-fi:usd/btc)))

(defun xag-price-content ()
  (format nil "Silver/BTC ~A toz" (zapper-fi:xag/btc)))

(defun xau-price-content ()
  (format nil "Gold/BTC ~3$ toz" (zapper-fi:xau/btc)))

(defun usd-price (menu)
  (create-gui-menu-item menu :content (usd-price-content) :html-id "usd-btc-price"))

(defun xag-price (menu)
  (create-gui-menu-item menu :content (xag-price-content) :html-id "xag-btc-price"))

(defun xau-price (menu)
  (create-gui-menu-item menu :content (xau-price-content) :html-id "xau-btc-price"))

(defun menu (menu-bar)
  (let ((menu (create-gui-menu-drop-down menu-bar :content "Bitcoin")))
    (usd-price menu)
    (xau-price menu)
    (xag-price menu)))
