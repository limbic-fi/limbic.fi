(defpackage :limbic/browser/bitcoin
  (:use :common-lisp :clog :clog-gui)
  (:export :menu))
(in-package :limbic/browser/bitcoin)

(defun menu (menu-bar)
  (let ((menu (create-gui-menu-drop-down menu-bar :content "Bitcoin")))
    (limbic/browser/prices:gui-menu-entry menu "BTC/USD $~2$"      'zapper-fi:btc/usd)
    (limbic/browser/prices:gui-menu-entry menu "BTC/Gold ~3$ toz"  'zapper-fi:btc/xau)
    (limbic/browser/prices:gui-menu-entry menu "BTC/Silver ~A toz" 'zapper-fi:btc/xag)
    (limbic/browser/prices:gui-menu-entry menu "BTC/ETH ~3$"       'zapper-fi:btc/eth)))
