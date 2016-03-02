;;; packages.el --- tuvistavie layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author:  <daniel@leffe>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `tuvistavie-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `tuvistavie/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `tuvistavie/pre-init-PACKAGE' and/or
;;   `tuvistavie/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst tuvistavie-packages
  '(editorconfig
    mozc
    yasnippet
    web-mode
    js2-mode
    wakatime-mode
    projectile
    feature-mode))

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

(defun tuvistavie/init-feature-mode ()
  (use-package feature-mode
    :defer t
    :init
    (progn
      (add-to-list 'auto-mode-alist '("\.feature$" . feature-mode)))))

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

(defun tuvistavie/init-wakatime-mode ()
  (use-package wakatime-mode
    :defer t
    :init
    (progn
      (global-wakatime-mode))))

;;; packages.el ends here
