; (use-package exec-path-from-shell
;   :config
;   (when (memq window-system '(mac ns x))
;   (exec-path-from-shell-initialize)))

;; Evil
(use-package evil
  :config
  (evil-mode 1))

;; Projectile
(use-package projectile
  :config
  (projectile-mode 1))

;; Treemacs
(use-package treemacs
  :config
  (setq
    treemacs-no-png-images 1
    treemacs-collapse-dirs 1
    treemacs-width 30)
  :bind ("<mouse-1>" . 'treemacs-single-click-expand-action))

(use-package treemacs-evil
  :after treemacs evil)

(use-package treemacs-projectile
  :after treemacs projectile)

;; Go
(use-package go-mode)

;; LSP
(use-package lsp-mode
  :hook (prog-mode . lsp)
  :commands lsp)

(use-package flycheck
  :config
  (global-flycheck-mode))

(use-package company
  :hook (after-init-hook . global-company-mode))

(use-package company-lsp
  :after lsp-mode company
  :config
  (push 'company-lsp company-backends))

(use-package lsp-ui
  :after lsp-mode
  :hook (lsp-mode-hook . lsp-ui-mode))
