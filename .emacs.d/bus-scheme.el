;; Extra Bus Scheme specific tweaks to scheme-mode

(setq scheme-program-name "~/projects/bus_scheme/bin/bus")

(defun bus ()
  (interactive)
  (run-scheme "~/projects/bus_scheme/bin/bus"))

(font-lock-add-keywords 'scheme-mode
			(list
			 (cons (mapconcat #'identity
					  '("\\(defresource"
					    "fail"
					    "send"
					    "load"
					    "cons"
					    "list"
					    "map"
					    "ruby"
					    "null\\?"
					    "not"
					    "car" "cdr" "cons"
					    "else"
					    "assert-equal"
					    "assert\\)")
					  "\\|")
			       'font-lock-function-name-face)))

(font-lock-add-keywords 'scheme-mode
			(list
			 (cons (mapconcat #'identity
					  '("\\(set!"
					    "xml"
					    "quote\\)")
					  "\\|")
			       'font-lock-keyword-face)))

;; this file is just a link to the real bus_scheme.rb
(add-to-list 'completion-ignored-extensions "bus-scheme\.rb")

(provide 'bus-scheme)