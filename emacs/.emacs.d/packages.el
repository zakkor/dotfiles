; (use-package exec-path-from-shell
;   :config
;   (when (memq window-system '(mac ns x))
;   (exec-path-from-shell-initialize)))

;; Evil
(use-package evil
  :init
  (setq
   evil-want-integration t
   evil-want-keybinding nil)
  :config
  (evil-mode 1)
  ;; Esc as C-g
  (define-key key-translation-map (kbd "ESC") (kbd "C-g"))
  ;; C-P as M-x
  (evil-define-key
    '(normal insert visual replace operator motion emacs)
    'global
    (kbd "C-S-p") 'execute-extended-command)
  (evil-define-key
    '(normal insert visual replace operator motion emacs)
    'global
    (kbd "C-p") 'projectile-find-file))

(use-package evil-collection
  :after evil
  :custom (evil-setup-minibuffer t)
  :init (evil-collection-init))

(use-package evil-leader
  :after evil
  :config
  (global-evil-leader-mode)
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key "w" 'save-buffer))

;; Ivy
(use-package counsel)
(use-package ivy
  :after counsel
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (global-set-key "\C-s" 'swiper)
  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  (global-set-key (kbd "<f6>") 'ivy-resume)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "<f1> f") 'counsel-describe-function)
  (global-set-key (kbd "<f1> v") 'counsel-describe-variable)
  (global-set-key (kbd "<f1> l") 'counsel-find-library)
  (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
  (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
  (global-set-key (kbd "C-c g") 'counsel-git)
  (global-set-key (kbd "C-c j") 'counsel-git-grep)
  (global-set-key (kbd "C-c k") 'counsel-ag)
  (global-set-key (kbd "C-x l") 'counsel-locate)
  (global-set-key (kbd "C-S-o") 'counsel-rhythmbox)
  (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history))

;; Projectile
(use-package projectile
  :after ivy
  :config
  (projectile-mode 1)
  (setq projectile-completion-system 'ivy))

;; Treemacs
(use-package treemacs
  :config
  (setq
    treemacs-no-png-images 1
    treemacs-collapse-dirs 1
    treemacs-width 30)
  :bind
  ("<f5>" . treemacs)
  ("<mouse-1>" . 'treemacs-single-click-expand-action))

(use-package treemacs-evil
  :after treemacs evil)

(use-package treemacs-projectile
  :after treemacs projectile)

;; Go
(use-package go-mode)

;; LSP
(use-package lsp-mode
  :hook (prog-mode . lsp-deferred)
  :commands (lsp lsp-deferred))

;; Flycheck for syntax checking
(use-package flycheck
  :config
  (global-flycheck-mode))

(use-package company
  :hook (after-init-hook . global-company-mode))

(use-package company-lsp
  :after lsp-mode company
  :config
  (push 'company-lsp company-backends)
  :commands company-lsp)

(use-package lsp-ui
  :after lsp-mode
  :hook
  (lsp-mode-hook . lsp-ui-mode)
  (lsp-mode-hook . flycheck-mode)
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-doc-position 'top))

(use-package lsp-treemacs
  :after lsp-mode treemacs
  :config
  (lsp-treemacs-sync-mode 1)
  :commands lsp-treemacs-errors-list)

