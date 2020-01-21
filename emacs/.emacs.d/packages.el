;; Evil
(use-package evil
  :config
  (evil-mode 1))

;; Projectile
(use-package projectile
  :config
  (projectile-mode 1))

;; Dashboard
(use-package dashboard
  :config
  (dashboard-setup-startup-hook)
  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*")))
  (setq dashboard-show-shortcuts nil)
  (setq dashboard-startup-banner 1)
  (setq dashboard-set-footer nil)
  (setq dashboard-items '((projects . 5)
    (recents  . 5)
    (agenda . 5)
    (registers . 5))))

;; Treemacs
(use-package treemacs
  :config
  (setq
   treemacs-no-png-images t
   treemacs-collapse-dirs 1
   treemacs-width 20))

(use-package treemacs-evil
  :after treemacs evil)

(use-package treemacs-projectile
  :after treemacs projectile)
