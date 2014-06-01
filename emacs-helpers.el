(defun kill-command-restart-in-buffer (buffer)
  (interactive "bRestartBuffer: ")
  ;; look up in info for interactive defn for querying for buffer
  (with-current-buffer buffer
    (term-interrupt-subjob)
    (call-interactively 'term-previous-input)
    (call-interactively 'term-send-input)))
