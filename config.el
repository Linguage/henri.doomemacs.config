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
;; Basic Org settings
(setq org-directory "~/Documents/EmacsNotes/"
      org-roam-directory "~/Documents/EmacsNotes/roam/"
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

;; =============================================================================
;; Org Journal / Diary System

;; Journal directories
(setq org-default-notes-file (concat org-directory "Journal/notes.org"))

;; Org Agenda files - include all journal files
(setq org-agenda-files (list (concat org-directory "Journal/diary.org")
                             (concat org-directory "Journal/worklog.org")
                             (concat org-directory "Journal/studylog.org")))

;; Org Capture templates for journals
(after! org
  (setq org-capture-templates
        '(("d" "个人日记" entry
           (file+olp+datetree "~/Documents/EmacsNotes/Journal/diary.org")
           "* %U %? :journal:diary:\n%i\n** 今日要点\n\n** 花销记录\n| 项目 | 金额 | 类别 |\n|------+------+------|\n|      |      |      |\n"
           :empty-lines 1)
          
          ("w" "工作日志" entry
           (file+olp+datetree "~/Documents/EmacsNotes/Journal/worklog.org")
           "* %U %? :journal:work:\n%i\n** 完成任务\n\n** 问题和解决方案\n\n** 明日计划\n"
           :empty-lines 1)
          
          ("s" "学习日志" entry
           (file+olp+datetree "~/Documents/EmacsNotes/Journal/studylog.org")
           "* %U %? :journal:study:\n%i\n** 主题与工作\n\n** 要点笔记\n\n** 资源链接\n"
           :empty-lines 1))))

;; Custom Agenda views for journals
(after! org-agenda
  (setq org-agenda-custom-commands
        '(("j" "日志概览"
           ((agenda "" ((org-agenda-span 'week)
                        (org-agenda-start-on-weekday nil)
                        (org-agenda-show-all-dates t)))
            (tags "diary"
                  ((org-agenda-sorting-strategy '(time-up priority-down))
                   (org-agenda-prefix-format "  %i %?-12t% s")
                   (org-agenda-overriding-header "📔 个人日记:")))
            (tags "work"
                  ((org-agenda-sorting-strategy '(time-up priority-down))
                   (org-agenda-prefix-format "  %i %?-12t% s")
                   (org-agenda-overriding-header "💼 工作日志:")))
            (tags "study"
                  ((org-agenda-sorting-strategy '(time-up priority-down))
                   (org-agenda-prefix-format "  %i %?-12t% s")
                   (org-agenda-overriding-header "📚 学习日志:")))
            (todo ""
                  ((org-agenda-files org-agenda-files)
                   (org-agenda-overriding-header "📝 所有待办事项:"))))
           ((org-agenda-compact-blocks t)))
          
          ("d" "个人日记"
           ((tags "diary"
                  ((org-agenda-sorting-strategy '(time-up priority-down))
                   (org-agenda-overriding-header "📔 个人日记条目:"))))
           ((org-agenda-compact-blocks t)))
          
          ("w" "工作日志"
           ((tags "work"
                  ((org-agenda-sorting-strategy '(time-up priority-down))
                   (org-agenda-overriding-header "💼 工作日志条目:"))))
           ((org-agenda-compact-blocks t)))
          
          ("s" "学习日志"
           ((tags "study"
                  ((org-agenda-sorting-strategy '(time-up priority-down))
                   (org-agenda-overriding-header "📚 学习日志条目:"))))
           ((org-agenda-compact-blocks t))))))

;; =============================================================================
;; Org HTML Export Configuration

(after! ox-html
  ;; Basic HTML export settings
  (setq org-html-doctype "html5"
        org-html-html5-fancy t
        org-html-use-infojs nil
        org-html-htmlize-output-type 'css
        org-html-htmlize-font-prefix "org-"
        org-html-table-default-attributes 
        '(:border "2" :cellspacing "0" :cellpadding "6" :rules "groups" :frame "hsides"))
  
  ;; HTML themes directory (org-html-themes)
  (defvar my/org-html-themes-dir 
    (expand-file-name "~/Documents/EmacsNotes/org-html-themes/")
    "本地 org-html-themes 目录路径。")
  
  (defvar my/org-html-default-theme "ReadTheOrg"
    "默认使用的 HTML 主题。")
  
  ;; Quick HTML export and open in browser
  (defun my/org-html-export-and-open ()
    "导出当前 Org 文件为 HTML 并在浏览器中打开。"
    (interactive)
    (let ((html-file (org-html-export-to-html)))
      (when html-file
        (browse-url (concat "file://" (expand-file-name html-file)))
        (message "HTML 文件已导出并在浏览器中打开: %s" html-file))))
  
  ;; Apply HTML theme
  (defun my/org-html-apply-theme ()
    "为当前 Org 文件应用 ReadTheOrg HTML 主题。"
    (interactive)
    (let ((theme-file (expand-file-name "org/theme-readtheorg.setup" my/org-html-themes-dir)))
      (if (file-exists-p theme-file)
          (progn
            (save-excursion
              (goto-char (point-min))
              ;; Remove existing SETUPFILE
              (while (re-search-forward "^#\\+SETUPFILE:.*org-html-themes.*$" nil t)
                (delete-region (line-beginning-position) (1+ (line-end-position))))
              ;; Insert new SETUPFILE
              (goto-char (point-min))
              (if (looking-at "^#\\+TITLE:")
                  (forward-line 1)
                (goto-char (point-min)))
              (insert (format "#+SETUPFILE: %s\n" theme-file)))
            (message "已应用 ReadTheOrg HTML 主题"))
        (message "主题文件不存在: %s\n请运行: git clone https://github.com/fniessen/org-html-themes.git %s"
                 theme-file (file-name-directory my/org-html-themes-dir)))))
  
  ;; Quick HTML export with theme
  (defun my/org-html-quick-export ()
    "快速 HTML 导出：应用主题并在浏览器打开。"
    (interactive)
    (my/org-html-apply-theme)
    (my/org-html-export-and-open)))

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
       :desc "Org capture" "c" #'org-capture
       :desc "Roam capture" "r" #'org-roam-capture
       (:prefix ("j" . "journal")
        :desc "New diary entry" "d" #'(lambda () (interactive) (org-capture nil "d"))
        :desc "New work log" "w" #'(lambda () (interactive) (org-capture nil "w"))
        :desc "New study log" "s" #'(lambda () (interactive) (org-capture nil "s"))
        :desc "Agenda" "a" #'org-agenda)
       (:prefix ("e" . "export")
        :desc "HTML export" "h" #'my/org-html-export-and-open
        :desc "HTML with theme" "t" #'my/org-html-quick-export
        :desc "Apply theme" "a" #'my/org-html-apply-theme))
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
