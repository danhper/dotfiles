;;; packages.el --- nodemisc layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2016 Sylvain Benner & Contributors
;;
;; Author:  <daniel@leffe>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3


(setq nodemisc-packages '(stylus-mode))


(defun nodemisc/init-stylus-mode ()
  (use-package stylus-mode
    :defer t))
