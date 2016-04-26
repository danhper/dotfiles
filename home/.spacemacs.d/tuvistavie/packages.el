;;; packages.el --- tuvistavie layer packages file for Spacemacs.

;;; Code:

(defconst tuvistavie-packages
  '(editorconfig
    mozc
    yasnippet
    web-mode
    js2-mode
    wakatime-mode
    company
    projectile
    helm
    neotree))

(defun tuvistavie/init-editorconfig ()
  (use-package editorconfig
    :defer t
    :init
    (progn
      (editorconfig-mode 1))))

(defun tuvistavie/init-mozc ()
  (use-package mozc
    :defer t
    :init
    (progn
      (setq default-input-method "japanese-mozc"))))

(defun tuvistavie/post-init-yasnippet ()
  (define-key yas-minor-mode-map (kbd "<tab>") 'yas-expand))

(defun tuvistavie/post-init-web-mode ()
  (add-to-list 'auto-mode-alist '("\\.tag$" . web-mode)))

(defun tuvistavie/post-init-js2-mode ()
  (add-to-list 'auto-mode-alist '("\\.es6$" . js2-mode))
  (setq js2-basic-offset 2)
  (add-hook 'js2-mode-hook 'js2-mode-hide-warnings-and-errors))

(defun tuvistavie/post-init-projectile ()
  (setq projectile-enable-caching t)
  (setq projectile-indexing-method 'alien))

(defun tuvistavie/post-init-helm ()
  (with-eval-after-load 'helm
    (define-key helm-map (kbd "C-h") 'delete-backward-char)))

(defun tuvistavie/post-init-neotree ()
  (setq neo-theme 'nerd))

(defun tuvistavie/post-init-company ()
  (with-eval-after-load 'company
    (define-key company-active-map (kbd "C-h") 'delete-backward-char)
    (define-key company-active-map (kbd "C-n") 'company-select-next)
    (define-key company-active-map (kbd "C-p") 'company-select-previous)))

(defun tuvistavie/init-wakatime-mode ()
  (use-package wakatime-mode
    :defer t
    :init
    (progn
      (setq wakatime-python-bin "~/.asdf/installs/python/2.7.11/bin/python")
      (setq wakatime-cli-path "~/.asdf/installs/python/2.7.11/bin/wakatime")
      (global-wakatime-mode))))

;;; packages.el ends here
