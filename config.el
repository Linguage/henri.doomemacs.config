(setq doom-font (font-spec :family "Hack Nerd Font" :size 16 :weight 'regular))

(when (display-graphic-p)
  (add-to-list 'initial-frame-alist '(width . 140))
  (add-to-list 'initial-frame-alist '(height . 40))
  (add-to-list 'default-frame-alist '(width . 140))
  (add-to-list 'default-frame-alist '(height . 40))
  (setq frame-resize-pixelwise t))

(load! "org/org-journal")

(load! "org/org-base")
(load! "org/org-html")
(load! "org/org-academic")

(add-hook 'org-capture-mode-hook #'delete-other-windows)

(after! org
  (add-hook 'org-mode-hook #'org-superstar-mode)
  (add-hook 'org-capture-mode-hook #'org-superstar-mode))
