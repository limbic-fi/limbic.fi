(defpackage #:limbic/browser
  (:use #:cl #:clog)
  (:export main))
(in-package :limbic/browser)

(defun static-root ()
  "Points to the static root file directory."
  (merge-pathnames "./static/" (asdf:system-source-directory :limbic)))

(defun on-new-window (body)
  "Handler for each new web browser window."
  (setf (title (html-document body)) "limbic.fi")
  (create-section body :h1 :content "limbic.fi")
  (create-section body :tt :content "Coming soon ...")
  (run body))

(defun main ()
  (initialize #'on-new-window
              :static-root (static-root))
  (open-browser))
