(defpackage #:limbic-main
  (:use #:cl #:clog)
  (:export main))
(in-package :limbic-main)

(defun on-new-window (body)
  "Handler for each new web browser window."
  (setf (title (html-document body)) "limbic.fi")
  (let ((hello-element (create-child body "<h1>Hello, world!</h1>")))
    (set-on-click hello-element
                  (lambda (object)
                    (declare (ignore object))
                    (setf (color hello-element) :green))))
  (run body))

(defun main ()
  (initialize #'on-new-window)
  (open-browser))
