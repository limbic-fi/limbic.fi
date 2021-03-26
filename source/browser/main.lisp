(defpackage #:limbic/browser
  (:use #:cl #:clog #:clog-gui)
  (:export main))
(in-package :limbic/browser)

(defun static-root ()
  "Points to the static root file directory."
  (merge-pathnames "./static/" (asdf:system-source-directory :limbic)))

(defun menu-bar (body)
  (let ((menu-bar (create-gui-menu-bar body)))
    (limbic/browser/limbic:menu   menu-bar)
    (limbic/browser/ethereum:menu menu-bar)
    (limbic/browser/ens:menu      menu-bar)
    (limbic/browser/help:menu     menu-bar)))

(defun on-new-window (body)
  "Handler for each new web browser window."
  (setf (title (html-document body)) "limbic.fi")
  (load-script (html-document body) "https://cdn.jsdelivr.net/npm/web3@latest/dist/web3.min.js")
  (clog-gui-initialize body)
  (menu-bar body)
  (run body))

(defun main ()
  (initialize #'on-new-window
              :static-root (static-root))
  (open-browser))
