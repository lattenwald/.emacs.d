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

;;; packages

(use-package diminish
  :ensure t)

(use-package exec-path-from-shell
  :ensure t
  :config
  (setq exec-path-from-shell-arguments '("-l")
        exec-path-from-shell-variables '("PATH" "MANPATH"))
  (exec-path-from-shell-initialize))

(use-package projectile
  :ensure t
  :pin melpa-stable
  :config
  (add-hook 'after-init-hook 'projectile-global-mode)
  (setq projectile-switch-project-action 'neotree-projectile-action))

(use-package ripgrep
  :ensure t)

(use-package projectile-ripgrep
  :ensure t
  :bind (("C-c p s r" . projectile-ripgrep)))

(use-package company
  :ensure t
  :pin melpa-stable
  :diminish company-mode
  :config
  (add-hook 'after-init-hook 'global-company-mode))

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
  :bind ("C-c i" . idomenu)
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
  :config
  (add-hook 'before-save-hook 'whitespace-cleanup)

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
  :config
  (setq undo-tree-enable-undo-in-region nil)
  (global-undo-tree-mode t))

(use-package yaml-mode
  :ensure t
  :config
  (add-hook 'yaml-mode-hook 'flycheck-mode))

(use-package magit
  :ensure t)

(use-package magit-find-file
  :ensure t
  :bind
  ("C-c C-f" . magit-find-file-completing-read))

(use-package linum
  :ensure t
  :config
  (global-linum-mode t))

(use-package flycheck
  :ensure t
  :pin melpa-stable
  :config
  (add-hook 'cperl-mode-hook 'flycheck-mode t)
  (add-hook 'purescript-mode-hook 'flycheck-mode t))

(use-package web-mode
  :ensure t
  :pin melpa-stable
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
      ad-do-it))
  (flycheck-define-checker jsxhint-checker
    "A JSX syntax and style checker based on JSXHint."

    :command ("jsxhint" source)
    :error-patterns
    ((error line-start (1+ nonl) ": line " line ", col " column ", " (message) line-end))
    :modes (web-mode))
  (add-hook 'web-mode-hook
            (lambda ()
              (when (equal web-mode-content-type "jsx")
                ;; enable flycheck
                (flycheck-select-checker 'jsxhint-checker)
                (flycheck-mode))
              (setq web-mode-enable-auto-pairing nil)
              (setq-local
               electric-pair-pairs
               (append electric-pair-pairs '((?% . ?%))))
              )))

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
  :config
  (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
  (add-to-list 'interpreter-mode-alist '("node" . js2-mode))
  (add-hook 'js2-mode (lambda ()
                        (setq tab-width 2)
                        (setq indent-tabs-mode t))))

(use-package yasnippet
  :ensure t
  :pin melpa-stable
  :config
  (yas-global-mode 1)
  (add-hook 'elm-mode-hook
            '(lambda () (set (make-local-variable 'yas-indent-line) 'fixed)))
  )

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
  :config
  (require 'lsp-clients)
  (setq lsp-auto-guess-root t
        lsp-prefer-flymake nil
        lsp-print-io t))

(use-package lsp-ui
  :ensure t
  :bind (:map lsp-ui-mode-map
              ("C-c i" . lsp-ui-imenu))
  :config
  (setq lsp-ui-flycheck-list-position 'right)
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

(use-package company-lsp
  :ensure t
  :config
  (push 'company-lsp company-backends))

;;; Erlang
;; currently have to use https://github.com/klajo/sourcer, branch emacs-lsp-mode-stdio-fixes
(use-package erlang
  :ensure t
  :config

  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection '("erlang_ls" "-t" "stdio"))
                    ;; (make-lsp-client :new-connection (lsp-tcp-connection (lambda () "/usr/bin/true") "localhost" 9000)
                    :major-modes '(erlang-mode)
                    :server-id 'erlang-ls
                    :use-native-json t))
  (add-hook 'erlang-mode-hook 'lsp)
  (add-hook 'erlang-mode-hook
            (lambda ()
              (setq lsp-enable-indentation nil)))
  )
;;; /Erlang

;;; Elixir
(use-package elixir-mode
  :ensure t
  :config
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection '("~/elixir-ls/language_server.sh"))
                    :major-modes '(elixir-mode)
                    :server-id 'elixir-ls
                    :use-native-json t))
  (add-hook 'elixir-mode-hook 'lsp))
;;; /Elixir

;;; Haskell
(use-package haskell-mode
  :ensure t)

;; see https://github.com/emacs-lsp/lsp-haskell
(use-package lsp-haskell
  :ensure t
  :config
  (setq lsp-haskell-process-path-hie "hie-wrapper")
  (add-hook 'haskell-mode-hook 'lsp))
;;; /Haskell

;;; Rust
(use-package rust-mode
  :ensure t)

(use-package lsp-rust
  :ensure t
  :config
  (add-hook 'rust-mode-hook 'lsp))
;;; /Rust

;;; Python

;;; /Python

;;; Org
(use-package org
  :ensure t)
;;; /Org

(use-package neotree
  :bind ("C-f" . neotree-toggle)
  :ensure t)

(load "~/.emacs.d/staging.el")

;;; other
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'dired-find-alternate-file 'disabled nil)
(put 'erase-buffer 'disabled nil)
