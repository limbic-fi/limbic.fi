(defpackage #:limbic-browser
  (:use #:cl #:clog)
  (:export main))
(in-package :limbic-browser)

(defun on-new-window (body)
  "Handler for each new web browser window."
  (setf (title (html-document body)) "limbic.fi")
  (let ((hello-element (create-section body :h1 :content "Hello, world!!!")))
    (set-on-click hello-element
                  (lambda (object)
                    (declare (ignore object))
                    (setf (color hello-element) :green))))
  (run body))

(defun main ()
  (initialize #'on-new-window
              :static-root (merge-pathnames "./static/"
                                            (asdf:system-source-directory :limbic)))
  (open-browser))
