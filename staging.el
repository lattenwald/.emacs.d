(use-package protobuf-mode
  :ensure t)

(use-package string-inflection
  :ensure t
  :bind (("C-c C" . string-inflection-cycle)))

(add-to-list 'load-path "/usr/elisp")
(require 'beancount)

;; gc stuff, from https://old.reddit.com/r/emacs/comments/55ork0/is_emacs_251_noticeably_slower_than_245_on_windows/d8cmm7v/

(setq gc-cons-threshold (* 511 1024 1024))
(setq gc-cons-percentage 0.5)
(run-with-idle-timer 5 t #'garbage-collect)
(setq garbage-collection-messages t)

(message "loaded staging.el")
