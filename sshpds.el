;;; sshpds.el -*- lexical-binding: t; -*-
;;Various functions will be here to aid with using ssh with HPDS test storage
(defvar sshpds-ip-history nil
  "History list of HPDS IPs.")

(defvar sshpds-port-history nil ; Default port as initial
  "History list of ports.")

(defun sshpds (ip port)
  "SSH into HPDS test storage.
Prompt for IP and port separately."
  (interactive
   (list
    (completing-read "Enter HPDS IP: " sshpds-ip-history nil nil nil 'sshpds-ip-history)
    (completing-read "Enter port: " sshpds-port-history nil nil nil 'sshpds-port-history)))
  (let ((remote-path (format "/ssh:root@%s#%s:" ip port)))
    (dirvish remote-path)))
