(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)
  ;; Disable modeline in treemacs
  (add-hook 'treemacs-mode-hook
	    (lambda ()
	      (setq mode-line-format nil))))

(use-package doom-modeline
    :hook (after-init . doom-modeline-mode)
    :config
    (doom-modeline-def-modeline 'default-line
        '(bar matches buffer-info parrot selection-info)
        '(misc-info minor-modes major-mode vcs checker))
    (defun setup-custom-doom-modeline ()
        (doom-modeline-set-modeline 'default-line 'default))
    (add-hook 'doom-modeline-mode-hook 'setup-custom-doom-modeline)
    (setq doom-modeline-icon nil)
    (setq doom-modeline-buffer-state-icon nil))
