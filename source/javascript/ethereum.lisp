(defpackage :limbic/javascript/ethereum
  (:use :common-lisp :clog)
  (:export :eth-request-accounts
           :network-version
           :selected-address))
(in-package :limbic/javascript/ethereum)

(defun eth-request-accounts (object)
  (js-execute object "ethereum.request({ method: 'eth_requestAccounts' });"))

(defun network-version (object)
  (js-execute object "ethereum.networkVersion"))

(defun selected-address* (object)
  (let ((selected-address (js-query object "ethereum.selectedAddress")))
    (if (string= selected-address "null")
        nil
        selected-address)))

(function-cache:defcached
    (selected-address :timeout 60)
    (object)
  (selected-address* object))
