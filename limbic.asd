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

(defparameter author "Christopher Mark Gore <cgore@cgore.com>, <cgore.eth>")
(defparameter copyright "Copyright © 2021 Christopher Mark Gore, all rights reserved.")
(defparameter version-major    0)
(defparameter version-minor    1)
(defparameter version-revision 0)

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
  :depends-on ("clog" "function-cache" "hunchentoot" "limbic" "sigma" "zapper-fi")
  :components ((:module "source"
                        :components ((:module "browser"
                                              :components ((:file "bitcoin")
                                                           (:file "ens")
                                                           (:file "ethereum")
                                                           (:file "help")
                                                           (:file "limbic")
                                                           (:file "main" :depends-on ("bitcoin" "ens" "ethereum" "help" "limbic")))
                                              :depends-on ("javascript"))
                                     (:module "javascript"
                                              :components ((:file "ethereum")))))))
