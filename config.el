(setq doom-font (font-spec :family "Hack Nerd Font" :size 16 :weight 'regular))

(when (display-graphic-p)
  (add-to-list 'initial-frame-alist '(width . 80))
  (add-to-list 'initial-frame-alist '(height . 40))
  (add-to-list 'default-frame-alist '(width . 80))
  (add-to-list 'default-frame-alist '(height . 40))
  (setq frame-resize-pixelwise t))

(defvar my/dark-theme doom-theme
  "当前深色主题，默认使用 Doom Emacs 的 `doom-theme` 值。")

(defvar my/light-theme 'doom-one-light
  "浅色主题，在 07:00-19:00 之间默认启用。")

(defvar my/use-light-theme-during-day? t
  "是否在白天自动使用浅色主题。手动切换后依然受此变量控制。")

(defun my/apply-theme-based-on-time ()
  "根据当前时间在浅色和深色主题之间切换。
早上 7 点(含) 到 晚上 7 点(不含) 使用浅色主题，其余时间使用深色主题。"
  (when my/use-light-theme-during-day?
    (let* ((hour (string-to-number (format-time-string "%H")))
           (use-light (and (>= hour 7) (< hour 19))))
      (load-theme (if use-light my/light-theme my/dark-theme) t)))
  (message "Theme: %s" doom-theme))

(defun my/toggle-light-dark-theme ()
  "在浅色/深色主题之间手动切换。"
  (interactive)
  (let ((current doom-theme))
    (cond
     ;; 当前是深色主题，切到浅色
     ((eq current my/dark-theme)
      (load-theme my/light-theme t)
      (message "切换到浅色主题: %s" my/light-theme))
     ;; 当前是浅色主题，切到深色
     ((eq current my/light-theme)
      (load-theme my/dark-theme t)
      (message "切换到深色主题: %s" my/dark-theme))
     ;; 其他情况：先记住当前为深色主题再切浅色
     (t
      (setq my/dark-theme current)
      (load-theme my/light-theme t)
      (message "记录当前主题为深色主题，并切换到浅色主题: %s -> %s" current my/light-theme)))))

;; 启动后根据时间设置一次主题
(add-hook 'doom-after-init-hook #'my/apply-theme-based-on-time)

;; 绑定快捷键：SPC t l （或 C-c t l）在浅色/深色主题间切换
(map! :leader
      :desc "切换浅色/深色主题"
      "t l" #'my/toggle-light-dark-theme)

(global-set-key (kbd "C-c t l") #'my/toggle-light-dark-theme)

(load! "org/org-journal")

(load! "org/org-base")
(load! "org/org-html")
(load! "org/org-academic")

(add-hook 'org-capture-mode-hook #'delete-other-windows)

(after! org
  (add-hook 'org-mode-hook #'org-superstar-mode)
  (add-hook 'org-capture-mode-hook #'org-superstar-mode))
