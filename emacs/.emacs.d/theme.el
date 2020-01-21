(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)
  
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  ;(doom-themes-neotree-config)
  ;; or for treemacs users
  ;(setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
  (doom-themes-treemacs-config)
  
  ;; Corrects (and improves) org-mode's native fontification.
  ;(doom-themes-org-config)
  )

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
    (setq doom-modeline-buffer-state-icon nil)
    ; (setq doom-modeline-minor-modes t)
    ;; Height
    (setq doom-modeline-height 1)
    (set-face-attribute 'mode-line nil :height 100)
    (set-face-attribute 'mode-line-inactive nil :height 100))
