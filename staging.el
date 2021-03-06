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

(use-package ess
  :ensure t)

(use-package ess-R-data-view
  :ensure t)

;; (use-package borland-blue-theme
;;   :ensure t)

(use-package crontab-mode
  :ensure t)

(use-package lua-mode
  :ensure t)

(use-package vterm
  :ensure t)

(use-package yasnippet-snippets
  :ensure t)

(use-package quelpa
  :ensure t)

(use-package quelpa-use-package
  :ensure t)

(use-package smali-mode
  :ensure t
  :quelpa (smali-mode :fetcher github :repo "strazzere/Emacs-Smali"))

(message "loaded staging.el")
