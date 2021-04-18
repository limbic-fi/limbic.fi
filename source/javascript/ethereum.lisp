(defpackage :limbic/javascript/ethereum
  (:use :common-lisp :clog)
  (:export :eth-request-accounts
           :ethereum-defined?
           :network-version
           :selected-address))
(in-package :limbic/javascript/ethereum)

(defun ethereum-defined? (object)
  (not (string= "null" (js-query object "typeof ethereum"))))

(defun eth-request-accounts (object)
  (when (ethereum-defined? object)
    (js-execute object "ethereum.request({ method: 'eth_requestAccounts' });")))

(defun network-version (object)
  (when (ethereum-defined? object)
    (js-query object "ethereum.networkVersion")))

(defun selected-address (object)
  (when (ethereum-defined? object)
    (let ((selected-address (js-query object "ethereum.selectedAddress")))
      (if (string= selected-address "null")
          nil
          selected-address))))
