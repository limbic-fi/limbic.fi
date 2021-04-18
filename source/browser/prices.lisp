(defpackage :limbic/browser/prices
  (:use :common-lisp :clog :clog-gui)
  (:export :gui-menu-entry))
(in-package :limbic/browser/prices)

(defun gui-menu-entry (menu format-directive price-fn)
  (create-gui-menu-item menu :content (format nil format-directive (funcall price-fn))))
