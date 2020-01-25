;; Save sessions
(desktop-save-mode 1)
;; The default desktop is saved always
(setq desktop-save t)
;; The default desktop is loaded anyway if it is locked
(setq desktop-load-locked-desktop t)


;; Hide tool bar
(tool-bar-mode -1)

;; Hide menu bar
(menu-bar-mode -1)

;; Hide scroll bar
(scroll-bar-mode -1)

;; Font
(set-face-attribute 'default nil
  :family "Roboto Mono"
  :height 100
  :weight 'normal
  :width 'normal)
(set-frame-font "Roboto Mono" nil t)

(setq inhibit-startup-screen t)

(use-package nlinum
  :config
  (setq linum-format " %d "))
