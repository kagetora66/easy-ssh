;;; easy-ssh.el -*- lexical-binding: t; -*-
;;variables to store IP and port history.
(defvar ssh-ip-history nil
  "History list of HPDS IPs.")

(defvar ssh-port-history nil
  "History list of ports.")

  "Load SSH history from file."
(when (file-exists-p "~/.sshhistory")
  (with-temp-buffer
      (insert-file-contents "~/.sshhistory")
      (while (not (eobp))
        (let ((line nil))
          (setf line (read (current-buffer)))
          (add-to-list 'ssh-ip-history (car line))
          (add-to-list 'ssh-port-history (cadr line))
          (forward-line)))))

(defun easy-ssh (ip port)
  "SSH into Hosts and save them.
Prompt for IP and port separately."
  (interactive
   (list
    (completing-read "Enter IP: " ssh-ip-history nil nil nil 'ssh-ip-history)
    (completing-read "Enter port: " ssh-port-history nil nil nil 'ssh-port-history)))
  (with-temp-buffer
    (print (list ip port) (current-buffer))
    (write-region (point-min) (point-max) "~/.sshhistory" t))
  (let ((remote-path (format "/ssh:root@%s#%s:" ip port)))
    (dired remote-path)))
