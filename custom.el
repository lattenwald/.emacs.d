(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bmkp-last-as-first-bookmark-file "/home/qalex/.emacs.d/bookmarks")
 '(custom-safe-themes
   (quote
    ("08141ce5483bc173c3503d9e3517fca2fb3229293c87dc05d49c4f3f5625e1df" "02199888a97767d7779269a39ba2e641d77661b31b3b8dd494b1a7250d1c8dc1" default)))
 '(electric-pair-mode t)
 '(erlang-electric-newline-inhibit t)
 '(flycheck-check-syntax-automatically (quote (save idle-change mode-enabled)))
 '(indent-tabs-mode nil)
 '(js-indent-level 2)
 '(lsp-auto-guess-root t nil nil "Customized with use-package lsp")
 '(lsp-ui-flycheck-enable t)
 '(lsp-ui-flycheck-live-reporting nil)
 '(lsp-ui-imenu-kind-position (quote left))
 '(message-strip-special-text-properties nil)
 '(neo-show-hidden-files t)
 '(neo-smart-open t)
 '(neo-theme (quote nerd))
 '(notmuch-address-save-filename "~/.cache/notmuch-address-completion")
 '(notmuch-command "notmuch")
 '(notmuch-fcc-dirs "Sent")
 '(notmuch-mua-cite-function (quote message-cite-original-without-signature))
 '(notmuch-mua-reply-insert-header-p-function (quote notmuch-show-reply-insert-header-p-minimal))
 '(notmuch-saved-searches
   (quote
    ((:name "inbox" :query "tag:inbox" :key "i")
     (:name "unread" :query "tag:unread" :key "u")
     (:name "flagged" :query "tag:flagged" :key "f")
     (:name "sent" :query "tag:sent" :key "t")
     (:name "drafts" :query "tag:draft" :key "d")
     (:name "all mail" :query "*" :key "a")
     (:name "unread-monitoring" :query "tag:unread and tag:monitoring")
     (:name "unread-monitoring-not-einstein" :query "tag:unread and tag:monitoring and not subject:/einstein/")
     (:name "unread-monitoring-einstein" :query "tag:unread and tag:monitoring and subject:/einstein/"))))
 '(org-modules
   (quote
    (org-bbdb org-bibtex org-docview org-info org-irc org-mhe org-rmail org-w3m org-notmuch org-toc)))
 '(org-replace-disputed-keys t)
 '(org-src-tab-acts-natively t)
 '(package-selected-packages
   (quote
    (vterm perlbrew lua-mode crontab-mode ess-R-data-view ess borland-blue-theme string-inflection lsp-mode protobuf-mode web-beautify elixir-yasnippets neotree lsp-python company-lsp lsp-rust rust-mode elixir-mode erlang lsp-ui notmuch lsp-haskell haskell-mode systemd textile-mode emojify yasnippet js2-mode vimrc-mode nginx-mode gitignore-mode web-mode flycheck magit-find-file magit yaml-mode undo-tree spaceline idomenu flx-ido fixmee markdown-mode apache-mode dockerfile-mode company projectile-ripgrep ripgrep projectile exec-path-from-shell diminish)))
 '(send-mail-function (quote sendmail-send-it))
 '(show-paren-mode t)
 '(show-paren-style (quote parenthesis))
 '(tab-width 4)
 '(tramp-use-ssh-controlmaster-options nil nil (tramp))
 '(x-stretch-cursor t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cperl-array-face ((t (:inherit font-lock-variable-name-face :weight bold))))
 '(cperl-hash-face ((t (:inherit font-lock-variable-name-face :weight bold)))))
