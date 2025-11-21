;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Personal Information
;; Repository: https://github.com/Linguage/henri.doomemacs.config
(setq user-full-name "Henri Pogat"
      user-mail-address "your-email@example.com")  ; 请修改为你的邮箱

;;; UI Configuration
;; Font settings
(setq doom-font (font-spec :family "JetBrains Mono" :size 14)
      doom-variable-pitch-font (font-spec :family "SF Pro" :size 14)
      doom-big-font (font-spec :family "JetBrains Mono" :size 24))

;; Theme
(setq doom-theme 'doom-one)

;; Line numbers
(setq display-line-numbers-type 'relative)

;; Transparency (optional)
;; (set-frame-parameter (selected-frame) 'alpha '(95 . 95))
;; (add-to-list 'default-frame-alist '(alpha . (95 . 95)))

;;; Editor Behavior
;; Better defaults
(setq-default
 tab-width 4
 indent-tabs-mode nil
 fill-column 100)

;; Auto-save and backup
(setq auto-save-default t
      make-backup-files t)

;; Scroll behavior
(setq scroll-margin 3
      scroll-conservatively 101
      scroll-preserve-screen-position t)

;;; Org Mode Configuration
(setq org-directory "~/org/"
      org-roam-directory "~/org/roam/"
      org-agenda-files '("~/org/")
      org-log-done 'time
      org-hide-emphasis-markers t
      org-pretty-entities t)

;; Org babel languages
(after! org
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (python . t)
     (shell . t)
     (js . t))))

;;; Programming Configuration
;; LSP
(after! lsp-mode
  (setq lsp-idle-delay 0.5
        lsp-enable-file-watchers t
        lsp-file-watch-threshold 5000))

;; Company (if using company instead of corfu)
;; (after! company
;;   (setq company-idle-delay 0.2
;;         company-minimum-prefix-length 2))

;; Format on save (already enabled in init.el, but can configure here)
(after! format
  (setq +format-on-save-enabled-modes
        '(not emacs-lisp-mode
              sql-mode
              tex-mode
              latex-mode)))

;; Tree-sitter
(after! tree-sitter
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

;;; Language-specific Configuration
;; Python
(after! python
  (setq python-shell-interpreter "python3"
        python-indent-offset 4))

;; JavaScript/TypeScript
(after! js2-mode
  (setq js2-basic-offset 2
        js-indent-level 2))

;; Go
(after! go-mode
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook #'gofmt-before-save))

;; Rust
(after! rustic
  (setq rustic-format-on-save t))

;;; Git Configuration
(after! magit
  (setq magit-diff-refine-hunk 'all))

;;; Keybindings
(map! :leader
      :desc "Toggle treemacs" "0" #'treemacs
      :desc "Find file in project" "SPC" #'projectile-find-file
      (:prefix ("f" . "file")
       :desc "Find recent file" "r" #'recentf-open-files)
      (:prefix ("n" . "notes")
       :desc "Find note" "n" #'org-roam-node-find
       :desc "Insert note" "i" #'org-roam-node-insert
       :desc "Capture" "c" #'org-roam-capture)
      (:prefix ("t" . "toggle")
       :desc "Line numbers" "l" #'doom/toggle-line-numbers
       :desc "Treemacs" "t" #'treemacs))

;; Better window navigation
(map! :n "C-h" #'evil-window-left
      :n "C-j" #'evil-window-down
      :n "C-k" #'evil-window-up
      :n "C-l" #'evil-window-right)

;;; macOS Specific
(when IS-MAC
  ;; Use Command as Meta
  (setq mac-command-modifier 'meta
        mac-option-modifier 'alt)
  ;; Better scrolling
  (setq mouse-wheel-scroll-amount '(1 ((shift) . 1))
        mouse-wheel-progressive-speed nil))

;;; Performance Optimization
(setq read-process-output-max (* 1024 1024)) ; 1mb
(setq gc-cons-threshold 100000000) ; 100mb

;;; Custom functions
(defun my/open-config ()
  "Open Doom config directory."
  (interactive)
  (find-file (expand-file-name "~/.config/doom/")))

(map! :leader
      :desc "Open config" "f c" #'my/open-config)

;; Load custom file for machine-specific settings
(when (file-exists-p "~/.config/doom/custom.el")
  (load! "custom.el"))
