(use-package doom-modeline
    :hook (after-init . doom-modeline-mode)
    :config
    (setq doom-modeline-icon nil)
    (setq doom-modeline-buffer-encoding nil)
    (size-indication-mode -1) ; filesize in modeline
    (column-number-mode -1)   ; cursor column in modeline
    (line-number-mode -1)
    (setq mode-line-percent-position nil)
    (setq doom-modeline-height 1)
    (setq doom-modeline-modal-icon nil)
    (set-face-attribute 'mode-line nil :height 100)
    (set-face-attribute 'mode-line-inactive nil :height 100))
