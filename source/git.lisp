(defpackage :limbic/git
  (:use :common-lisp)
  (:export :git-describe))
(in-package :limbic/git)

;; Not just `describe` because of the conflict with the Common Lisp builtin.
(defun git-describe ()
  "Get the current version of the site's code."
  (string-trim '(#\Space #\Tab #\Newline)
               (with-output-to-string (s)
                 (sb-ext:run-program "git" '("describe")
                                     :output s
                                     :search t))))
