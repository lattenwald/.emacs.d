;; custom file

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(setq custom-file (locate-user-emacs-file "custom.el"))
(load custom-file 'noerror)

;; "y" instead of "yes" and "n" instead of "no" when emacs is asking stuff
(defalias 'yes-or-no-p 'y-or-n-p)

;; start sever
(server-start)

;;; cmd as alt
(setq-default ns-command-modifier 'meta)

(global-set-key (kbd "C-'") 'comment-or-uncomment-region)
(global-set-key (kbd "C-<prior>") nil)
(global-set-key (kbd "C-<next>") nil)
(global-set-key (kbd "C-c o") 'occur)

;;; Moving between windows
(global-set-key (kbd "M-<left>") 'windmove-left)
(global-set-key (kbd "M-<right>") 'windmove-right)
(global-set-key (kbd "M-<up>") 'windmove-up)
(global-set-key (kbd "M-<down>") 'windmove-down)

;;; Look and feel
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'darkplus t t)
(enable-theme 'darkplus)
(tool-bar-mode 0)
(column-number-mode t)
(when (window-system)
  ;; (set-default-font "Fira Code")
  (set-default-font "Hack")
  (set-face-attribute 'default nil :height 100))

;;; disable lock files
(setq create-lockfiles nil)
;; backup in one place. flat, no tree structure
(setq backup-directory-alist '(("" . "~/.emacs.d/backup")))

(set-fontset-font "fontset-default" nil
                  (font-spec :name "Symbola"))

;;; Loading submodules
(let ((default-directory  "~/.emacs.d/git/"))
  (normal-top-level-add-subdirs-to-load-path))

;; treat underscore as word character
(modify-syntax-entry ?_ "w")

;;; cua-mode
(cua-mode t)
(transient-mark-mode t)
(setq cua-keep-region-after-copy nil
      cua-auto-tabify-rectangles nil
      cua-remap-control-v t
      cua-remap-control-z t)


(defun insert-file-name ()
  "Insert the full path file name into the current buffer."
  (interactive)
  (insert (buffer-file-name (window-buffer (minibuffer-selected-window)))))

(defun filename ()
  "Copy the full path of the current buffer."
  (interactive)
  (kill-new (buffer-file-name (window-buffer (minibuffer-selected-window)))))

(global-set-key (kbd "M-i") 'insert-file-name)


;;; show-paren-mode
(setq show-paren-mode t
      show-paren-style 'parenthesis)

;;; dired
(setq dired-listing-switches "-al --group-directories-first")

;; protect my keybindings
(defun protect-my-bindings (bad-map)
  (interactive)
  (progn
    (define-key bad-map (kbd "M-<left>") nil)
    (define-key bad-map (kbd "M-<right>") nil)
    (define-key bad-map (kbd "M-<up>") nil)
    (define-key bad-map (kbd "M-<down>") nil)))

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(package-initialize)

(require 'use-package)
(require 'bookmark+)

;;; packages

(use-package diminish
  :ensure t)

(use-package exec-path-from-shell
  :ensure t
  :custom
  (exec-path-from-shell-arguments '("-l"))
  (exec-path-from-shell-variables '("PATH" "MANPATH"))
  :config
  (exec-path-from-shell-initialize))

(use-package rg
  :ensure t
  :config
  (rg-define-search rg-proj
    "Run ripgrep in current project searching for REGEXP in FILES.
The project root will will be determined by either common project
packages like projectile and `find-file-in-project' or the source
version control system. Search will be conducted in files matching
the current file."
    :query ask
    :confirm prefix
    :dir project
    :files current)
  (add-hook 'projectile-mode-hook (lambda () (define-key projectile-command-map (kbd "s r") 'rg-proj))))

(use-package projectile
  :ensure t
  :pin melpa-stable
  :custom
  (projectile-keymap-prefix (kbd "C-c p"))
  :hook (after-init . projectile-global-mode))

(use-package company
  :ensure t
  :pin melpa-stable
  :diminish company-mode
  :hook (after-init . global-company-mode))

(use-package dockerfile-mode
  :ensure t
  :pin melpa-stable)

(use-package apache-mode
  :ensure t)

(use-package markdown-mode
  :ensure t
  :pin melpa-stable
  :config
  (eval-after-load "markdown-mode"
    (protect-my-bindings markdown-mode-map)))

(use-package fixmee
  :ensure t
  :diminish fixmee-mode)

(use-package flx-ido
  :ensure t)

(use-package idomenu
  :ensure t
  :bind
  ("C-c i" . idomenu)
  :config
  (ido-mode t)
  (ido-everywhere 1))

(flx-ido-mode t)
(ido-mode t)
(ido-everywhere 1)

(use-package align
  :ensure t
  :config
  :bind ("M-[" . align))

(use-package spaceline
  :ensure t
  :config
  (require 'spaceline-config)
  (spaceline-spacemacs-theme))

(use-package whitespace
  :diminish global-whitespace-mode
  :hook (before-save . whitespace-cleanup)
  :config
  (defun prevent-whitespace-mode-for-magit ()
    (not (derived-mode-p 'magit-mode)))
  (add-function :before-while whitespace-enable-predicate 'prevent-whitespace-mode-for-magit)

  (defun save-buffer-without-dtw ()
    (interactive)
    (let ((b (current-buffer)))   ; memorize the buffer
      (with-temp-buffer ; new temp buffer to bind the global value of before-save-hook
        (let ((before-save-hook (remove 'whitespace-cleanup before-save-hook)))
          (with-current-buffer b  ; go back to the current buffer, before-save-hook is now buffer-local
            (let ((before-save-hook (remove 'whitespace-cleanup before-save-hook)))
              (save-buffer))))))))

(use-package undo-tree
  :ensure t
  :diminish undo-treemode
  :bind
  ("C-r" . undo-tree-redo)
  ("C-z" . undo)
  :custom
  (undo-tree-enable-undo-in-region nil)
  :config
  (global-undo-tree-mode t))

(use-package yaml-mode
  :ensure t)

(use-package magit
  :ensure t)

(use-package magit-find-file
  :ensure t
  :bind
  ("C-c C-f" . magit-find-file-completing-read))

(use-package flycheck
  :ensure t
  :pin melpa-stable
  :hook (yaml-mode cperl-mode purescript-mode))

;;; web-mode and stuff
(use-package web-mode
  :ensure t
  :pin melpa-stable
  :custom
  (web-mode-enable-auto-pairing nil)
  :hook ((web-mode . (lambda ()
                       (when (equal web-mode-content-type "jsx")
                         ;; enable flycheck
                         (flycheck-select-checker 'jsxhint-checker)
                         (flycheck-mode))
                       (setq-local
                        electric-pair-pairs
                        (append electric-pair-pairs '((?% . ?%))))
                       ))
         (flycheck-mode . (lambda ()
                            (flycheck-define-checker jsxhint-checker
                                                     "A JSX syntax and style checker based on JSXHint."

                                                     :command ("jsxhint" source)
                                                     :error-patterns
                                                     ((error line-start (1+ nonl) ": line " line ", col " column ", " (message) line-end))
                                                     :modes (web-mode)))))
  :config
  ;;; web-mode
  (add-to-list 'auto-mode-alist '("\\.html?$" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.js$" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.eex$" . web-mode)) ;; embedded elixir
  ;;; web mode for jsxh
  ;;; https://truongtx.me/2014/03/10/emacs-setup-jsx-mode-and-jsx-syntax-checking/
  (add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
  (defadvice web-mode-highlight-part (around tweak-jsx activate)
    (if (equal web-mode-content-type "jsx")
        (let ((web-mode-enable-part-face nil))
          ad-do-it)
      ad-do-it)))

(use-package web-beautify
  :ensure t
  :config

  (eval-after-load 'js2-mode
    '(define-key js2-mode-map (kbd "C-c <tab>") 'web-beautify-js))
  ;; Or if you're using 'js-mode' (a.k.a 'javascript-mode')
  (eval-after-load 'js
    '(define-key js-mode-map (kbd "C-c <tab>") 'web-beautify-js))

  (eval-after-load 'json-mode
    '(define-key json-mode-map (kbd "C-c <tab>") 'web-beautify-js))

  (eval-after-load 'sgml-mode
    '(define-key html-mode-map (kbd "C-c <tab>") 'web-beautify-html))

  (eval-after-load 'css-mode
    '(define-key css-mode-map (kbd "C-c <tab>") 'web-beautify-css)))
;;; /web-mode

(use-package gitignore-mode
  :ensure t
  :pin melpa-stable)

(use-package nginx-mode
  :ensure t
  :pin melpa-stable
  :config
  (defvaralias 'font-lock-operator-face 'font-lock-keyword-face))

(use-package vimrc-mode
  :ensure t)

(use-package js2-mode
  :ensure t
  :hook ((js2 . lsp)
         (js2 . (lambda ()
                  (setq tab-width 2)
                  (setq indent-tabs-mode t))))
  :config
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  (add-to-list 'interpreter-mode-alist '("node" . js2-mode)))

(use-package yasnippet
  :ensure t
  :pin melpa-stable
  :hook (elm-mode . (lambda () (set (make-local-variable 'yas-indent-line) 'fixed)))
  :config
  (yas-global-mode 1))

(use-package emojify
  :ensure t)

(use-package textile-mode
  :ensure t)

(use-package systemd
  :ensure t)

(use-package notmuch
  :ensure t)

;;; lsp-mode
(use-package lsp
  :ensure lsp-mode
  :bind ("C-c <tab>" . lsp-format-buffer)
  :custom
  (lsp-auto-guess-root t)
  (lsp-prefer-flymake nil)
  (lsp-log-io nil)
  ;; (lsp-erlang-server-install-dir "/home/qalex/git/erlang_ls")
  :config
  (require 'lsp-clients)
  (add-hook 'c++-mode-hook #'lsp)
  (add-hook 'c-mode-hook #'lsp))

(use-package lsp-ui
  :ensure t
  :bind (:map lsp-ui-mode-map
              ("C-c C-i" . lsp-ui-imenu)
              :map lsp-ui-imenu-mode-map
              ("<M-return>" . lsp-ui-imenu--view)
              ("<return>" . lsp-ui-imenu--visit))
  :hook lsp
  :custom
  (lsp-ui-flycheck-list-position 'right))

(use-package company-lsp
  :ensure t
  :config
  (cl-pushnew '(company-lsp company-dabbrev-code company-dabbrev company-keywords company-etags company-gtags) company-backends))

;;; Erlang
;; currently have to use https://github.com/klajo/sourcer, branch emacs-lsp-mode-stdio-fixes
(use-package erlang
  :ensure t
  :config
  (add-hook 'erlang-mode-hook #'lsp))
;;; /Erlang

;;; Elixir
(use-package elixir-mode
  :ensure t
  :bind (:map elixir-mode-map
              ("C-c <tab>" . 'elixir-format))
  :hook (elixir-mode . lsp)
  :config
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection '("~/elixir-ls/language_server.sh"))
                    :major-modes '(elixir-mode)
                    :server-id 'elixir-ls)))

(use-package elixir-yasnippets
  :ensure t)
;;; /Elixir

;;; Haskell
(use-package haskell-mode
  :ensure t)

;; see https://github.com/emacs-lsp/lsp-haskell
(use-package lsp-haskell
  :ensure t
  :hook (haskell-mode . lsp)
  :custom
  (lsp-haskell-process-path-hie "hie-wrapper"))
;;; /Haskell

;;; Rust
(use-package rust-mode
  :ensure t)
;;; /Rust

;;; Org
(use-package org
  :ensure t
  :custom
  (org-catch-invisible-edits 'show-and-error)
  (org-cycle-separator-lines 0)
  :config
  (eval-after-load "org-mode"
    (protect-my-bindings org-mode-map)))
;;; /Org

;;; Perl
(use-package perlbrew
  :ensure t
  :config
  (perlbrew-use "perl-5.30.0"))

(use-package cperl-mode
  :ensure t
  :init
  (defalias 'perl-mode 'cperl-mode)
  :config
  (defvaralias 'cperl-indent-level 'tab-width)
  (define-key cperl-mode-map (kbd "C-h f") 'cperl-perldoc)
  (defadvice cperl-backward-to-start-of-continued-exp (after indentation-fix)
    (and (not (memq char-after '(?\) ?\})))
         (or (not is-block) (looking-back "^[ \t]+"))
         (> (current-column) cperl-continued-statement-offset)
         (backward-char cperl-continued-statement-offset))))
;;; /Perl

(use-package gnus
  :custom
  (gnus-select-method '(nntp "news.tweaknews.eu"))
  :config
  (eval-after-load "gnus-mode"
    (protect-my-bindings gnus-summary-mode-map)))

(use-package treemacs
  :ensure t
  :bind ("C-f" . treemacs)
  :init
  (add-hook 'treemacs-mode-hook (lambda() (display-line-numbers-mode 0))))

(use-package treemacs-projectile
  :ensure t)

(defun scratchpad-buffer ()
  "Generate temporary buffer"
  (interactive)
  (switch-to-buffer (make-temp-name "scratch-")))

(load "~/.emacs.d/staging.el")

;;; other
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)
(put 'erase-buffer 'disabled nil)
