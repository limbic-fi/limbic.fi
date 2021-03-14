(defpackage limbic/system
  (:use :common-lisp
        :asdf)
  (:export :author
           :copyright
           :version-string
           :version-list
           :version-major
           :version-minor
           :version-revision))
(in-package :limbic/system)

(defparameter author "Christopher Mark Gore <cgore@cgore.com>")
(defparameter copyright "Copyright © 2021 Christopher Mark Gore, all rights reserved.")
(defparameter version-major    0)
(defparameter version-minor    0)
(defparameter version-revision 1)

(defun version-list ()
  (list version-major version-minor version-revision))

(defun version-string ()
  (format nil "~{~A.~A.~A~}" (version-list)))

(defsystem "limbic"
  :description "Shared system for all of limbic.fi"
  :version #.(version-string)
  :author author
  :license copyright)

(defsystem "limbic/browser"
  :description "Browser frontend for the website <https://limbic.fi>."
  :version #.(version-string)
  :author author
  :license copyright
  :depends-on ("clog" "hunchentoot" "limbic")
  :components ((:module "source" :components ((:file "browser")))))
