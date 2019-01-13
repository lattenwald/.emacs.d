(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(electric-pair-mode t)
 '(indent-tabs-mode nil)
 '(lsp-ui-imenu-kind-position (quote left))
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
 '(org-replace-disputed-keys t)
 '(package-selected-packages
   (quote
    (protobuf-mode web-beautify elixir-yasnippets neotree lsp-python company-lsp lsp-rust rust-mode elixir-mode erlang lsp-ui notmuch lsp-haskell haskell-mode lsp-mode systemd textile-mode emojify yasnippet js2-mode vimrc-mode nginx-mode gitignore-mode web-mode flycheck magit-find-file magit yaml-mode undo-tree spaceline idomenu flx-ido fixmee markdown-mode apache-mode dockerfile-mode company projectile-ripgrep ripgrep projectile exec-path-from-shell diminish)))
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
 )
