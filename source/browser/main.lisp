(defpackage #:limbic/browser
  (:use #:cl #:clog #:clog-gui)
  (:export main))
(in-package :limbic/browser)

(defun static-root ()
  "Points to the static root file directory."
  (merge-pathnames "./static/" (asdf:system-source-directory :limbic)))

(defun menu-bar (body)
  (let* ((menu-bar (create-gui-menu-bar body))
         (_             (limbic/browser/limbic:menu menu-bar))
         (ethereum-menu (create-gui-menu-drop-down menu-bar :content "Ethereum"))
         (_             (limbic/browser/ens:menu menu-bar))
         (help-menu     (create-gui-menu-drop-down menu-bar :content "Help")))))

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
