;;(setq debug-on-error t)
;;(setq flymake-log-level 3)


;;global settings
(setq inhibit-startup-screen 't)
(set-language-environment "UTF-8")
(add-to-list 'load-path "~/.emacs.d/")
(add-to-list 'load-path "~/.emacs.d/plugins/other")
(add-to-list 'load-path "~/.emacs.d/site-lisp")
(load "toggle-split")
(setq-default indent-tabs-mode nil)
(setq tab-width 2)
(fset 'yes-or-no-p 'y-or-n-p)
(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(setq-default process-coding-system-alist nil)

(require 'color-theme)
(color-theme-initialize)
(color-theme-railscasts)

;;key bindings
(global-set-key (kbd "M-ù") 'query-replace)
(global-set-key (kbd "s-SPC") 'toggle-input-method)
(global-set-key (kbd "<zenkaku-hankaku>") 'toggle-input-method)
(global-set-key (kbd "<hiragana-katakana>") 'toggle-input-method)
(global-set-key (kbd "s-i") 'indent-region)
(global-set-key (kbd "s-f") 'forward-paragraph)
(global-set-key (kbd "s-b") 'backward-paragraph)
(global-set-key (kbd "s-,") 'beginning-of-buffer)
(global-set-key (kbd "s-<") 'end-of-buffer)
(global-set-key (kbd "s-.") 'end-of-buffer)
(global-set-key (kbd "s-=") 'enlarge-window-horizontally)
(global-set-key (kbd "s-+") 'enlarge-window)
(global-set-key (kbd "M-p") 'show-paren-mode)
(global-set-key (kbd "<C-return>") 'newline-and-indent)
(global-set-key (kbd "s-x") 'clipboard-kill-region)
(global-set-key (kbd "s-c") 'clipboard-kill-ring-save)
(global-set-key (kbd "s-v") 'x-clipboard-yank)
(global-set-key (kbd "C-z") 'toggle-window-split)
(global-set-key (kbd "s-r") 'replace-regexp)
(global-set-key (kbd "s-g") '(lambda () (interactive) (async-shell-command "comptex")))
(global-set-key (kbd "<C-muhenkan>") 'previous-buffer)
(global-set-key (kbd "<C-henkan>") 'next-buffer)
(global-set-key (kbd "<muhenkan>") 'windmove-left)
(global-set-key (kbd "<henkan>") 'windmove-right)
(global-set-key (kbd "s-j") 'comment-region) 
(global-set-key (kbd "s-k") 'uncomment-region)
(global-set-key (kbd "s-;") 'comment-or-uncomment-region)
(global-set-key (kbd "s-u") 'undo)
(global-set-key (kbd "s-<f11>") 'center-text-horizontally)

;;c/c++
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'load-path "~/.emacs.d/styles")
(load "c_indent_style")
(setq c-default-style "mystyle")


;;latex
(load "auctex.el" nil t t)
(load "preview-latex.el" nil t t)
(setq TeX-style-path
      '("style/" "auto/"
        "/usr/share/emacs/site-lisp/auctex/style/"))
(setq TeX-output-view-style
      (quote
       (("^dvi$" "." "xdvi %o"))))

(setq preview-image-type 'dvipng)


;;latex japanese
;;(setq TeX-default-mode 'japanese-latex-mode)
;;(setq japanese-TeX-command-default "pTeX")
;;(setq japanese-LaTeX-command-default "pLaTeX")
(setq japanese-LaTeX-default-style "article")
(setq TeX-engine 'xetex)
(setq TeX-PDF-mode t)


;;scala
(add-to-list 'load-path "~/.emacs.d/plugins/scala-mode")
(require 'scala-mode-auto)


;;auto complete
(add-to-list 'load-path "~/.emacs.d/plugins/auto-complete-1.3.1")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/daniel/.emacs.d/plugins/auto-complete-1.3.1/ac-dict")
(ac-config-default)
(setq ac-comphist-file "~/.emacs.d/plugins/auto-complete-1.3.1/ac-comphist.dat")


;;yasnippet
(add-to-list 'load-path
             "~/.emacs.d/plugins/yasnippet-0.6.1b")
(require 'yasnippet) ;; not yasnippet-bundle
(yas/initialize)
(yas/load-directory "~/.emacs.d/plugins/yasnippet-0.6.1b/snippets")

;;typescript
(require 'typescript)
(add-to-list 'auto-mode-alist '("\\.ts$" . typescript-mode))


;;auto pair brackets
(require 'autopair)
(autopair-global-mode) ;; enable autopair in all buffers 


;;haskell-mode
(load "~/.emacs.d/plugins/haskell-mode-2.8.0/haskell-site-file")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)


;;yaml-mode
(load "~/.emacs.d/plugins/yaml-mode/yaml-mode")
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))


;;tuareg-mode
(add-to-list 'load-path "~/.emacs.d/plugins/tuareg-mode")
(autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
(autoload 'camldebug "camldebug" "Run the Caml debugger" t)
(autoload 'tuareg-imenu-set-imenu "tuareg-imenu" 
  "Configuration of imenu for tuareg" t) 

(add-hook 'tuareg-mode-hook 'tuareg-imenu-set-imenu)

(setq auto-mode-alist 
      (append '(("\\.ml[ily]?$" . tuareg-mode)
                ("\\.topml$" . tuareg-mode))
              auto-mode-alist))


;;sml-mode
(load "~/.emacs.d/plugins/sml-mode/sml-mode-startup")

;;php-mode
(load "~/.emacs.d/plugins/php-mode/php-mode")
(require 'php-mode)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))


;;prolog-mode
(load "~/.emacs.d/plugins/prolog-mode/prolog")
(autoload 'run-prolog "prolog" "Start a Prolog sub-process." t)
(autoload 'prolog-mode "prolog" "Major mode for editing Prolog programs." t)
(autoload 'mercury-mode "prolog" "Major mode for editing Mercury programs." t)
(setq prolog-system 'swi)
(setq auto-mode-alist (append '(("\\.pl$" . prolog-mode)
                                ("\\.m$" . mercury-mode))
                              auto-mode-alist))


;;python-mode
(add-to-list 'load-path "~/.emacs.d/plugins/python-mode.el-6.0.4/") 
(setq py-install-directory "~/.emacs.d/plugins/python-mode.el-6.0.4/")
(require 'python-mode)
(setq py-start-run-py-shell nil)
(setq-default py-indent-offset 2)

;;ess
;; (setq load-path (cons "/usr/share/emacs/site-lisp/ess" load-path))
;; (require 'ess-site)

;;promela-mode
(autoload 'promela-mode "promela-mode" "PROMELA mode" nil t)
(setq auto-mode-alist
      (append
       (list (cons "\\.promela$"  'promela-mode)
             (cons "\\.spin$"     'promela-mode)
             (cons "\\.pml$"      'promela-mode)
             ;; (cons "\\.other-extensions$"     'promela-mode)
             )
       auto-mode-alist))

;; ruby-mode
(add-to-list 'load-path "~/.emacs.d/plugins/ruby-mode/") 
(autoload 'ruby-mode "ruby-mode" "Major mode for ruby files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . ruby-mode))

;;aspell config
(setq-default ispell-program-name "aspell")
;;(add-to-list 'ispell-skip-region-alist
;;           '("lstlisting\\*?" . "\\\\end[   \n]*{[  \n]*lstlisting\\*?[       \n]*}"))

;;scilab
(load "scilab")
(setq auto-mode-alist
      (append
       (list (cons "\\.sci$"  'scilab-mode)
             (cons "\\.sce$"     'scilab-mode))
       auto-mode-alist))
(setq scilab-mode-hook '(lambda () (setq fill-column 74)))

;;d-mode
(require 'd-mode)
(add-to-list 'auto-mode-alist '("\\.d$" . d-mode))

;; atokx3
(add-to-list 'load-path "~/.emacs.d/plugins/iiimecf")
(setq iiimcf-server-control-hostlist (list (concat "/tmp/.iiim-" (user-login-name) "/:0.0")))
(require 'iiimcf-sc nil t)
(setq iiimcf-server-control-default-language "ja")
(setq iiimcf-server-control-default-input-method "atokx3")
(setq default-input-method 'iiim-server-control)
(load "atok-popup")

;;cedet
;; (load-file "~/.emacs.d/plugins/cedet-1.1/common/cedet.el")
;; (global-ede-mode 1)
;; (semantic-load-enable-minimum-features)
;; (semantic-load-enable-code-helpers)
(require 'sr-speedbar)
(setq sr-speedbar-right-side nil)
(global-set-key (kbd "s-s") 'sr-speedbar-toggle)

;;helm
(add-to-list 'load-path "~/.emacs.d/plugins/helm")
(require 'helm-config)

;;django 
(autoload 'django-html-mumamo-mode "~/.emacs.d/plugins/nxhtml/autostart.el")
(setq auto-mode-alist
      (append '(("\\.html?$" . django-html-mumamo-mode)) auto-mode-alist))
(setq mumamo-background-colors nil) 
(add-to-list 'auto-mode-alist '("\\.html$" . django-html-mumamo-mode))

;;flymake
(require 'flymake)
(require 'flymake-cursor)
(add-hook 'find-file-hook 'flymake-find-file-hook)

(custom-set-faces
 '(flymake-errline ((t (:underline "LightSalmon" ))))
 '(flymake-warnline ((t (:underline "LightSteelBlue"))))
 '(font-latex-sectioning-5-face ((t (:foreground "#917EA6")))))

;;flymake c/c++
(defun flymake-simple-generic-init (cmd &optional opts)
  (let* ((temp-file  (flymake-init-create-temp-buffer-copy
                      'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list cmd (append opts (list local-file)))))

;; without Makefile
(defun flymake-simple-make-or-generic-init (cmd &optional opts)
  (if (file-exists-p "Makefile")
      (flymake-simple-make-init)
    (flymake-simple-generic-init cmd opts)))

(defun flymake-c-init ()
  (flymake-simple-make-or-generic-init
   "gcc" '("-Wall" "-Wextra" "-pedantic" "-fsyntax-only")))

(defun flymake-cc-init ()
  (flymake-simple-make-or-generic-init
   "g++" '("-Wall" "-Wextra" "-pedantic" "-fsyntax-only")))

(push '("\\.[cC]\\'" flymake-c-init) flymake-allowed-file-name-masks)
(push '("\\.\\(?:cc\|cpp\|CC\|CPP\\)\\'" flymake-cc-init) flymake-allowed-file-name-masks)

;;flymake haskell
(defun flymake-haskell-init ()
  "When flymake triggers, generates a tempfile containing the
  contents of the current buffer, runs `hslint` on it, and
  deletes file. Put this file path (and run `chmod a+x hslint`)
  to enable hslint: https://gist.github.com/1241073"
  (let* ((temp-file   (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
         (local-file  (file-relative-name
                       temp-file
                       (file-name-directory buffer-file-name))))
    (list "hslint" (list local-file))))

(defun flymake-haskell-enable ()
  "Enables flymake-mode for haskell, and sets <C-c d> as command
  to show current error."
  (when (and buffer-file-name
             (file-writable-p
              (file-name-directory buffer-file-name))
             (file-writable-p buffer-file-name))
    (local-set-key (kbd "C-c d") 'flymake-display-err-menu-for-current-line)
    (flymake-mode t)))

(require 'hs-lint)    ;; https://gist.github.com/1241059
(require 'haskell-ac) ;; https://gist.github.com/1241063

(defun my-haskell-mode-hook ()
  "hs-lint binding, plus autocompletion and paredit."
  (local-set-key "\C-cl" 'hs-lint)
  (setq ac-sources
        (append '(ac-source-yasnippet
                  ac-source-abbrev
                  ac-source-words-in-buffer
                  my/ac-source-haskell)
                ac-sources))
  (dolist (x '(haskell literate-haskell))
    (add-hook
     (intern (concat (symbol-name x)
                     "-mode-hook"))
     'turn-on-paredit)))

(eval-after-load 'haskell-mode
  '(progn
     (require 'flymake)
     (push '("\\.l?hs\\'" flymake-haskell-init) flymake-allowed-file-name-masks)
     (add-hook 'haskell-mode-hook 'flymake-haskell-enable)
     (add-hook 'haskell-mode-hook 'my-haskell-mode-hook)))

;;flymake java
(add-hook 'java-mode-hook 'flymake-mode-on)
(defun my-java-flymake-init ()
  (list "javac" (list (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-with-folder-structure))))
(add-to-list 'flymake-allowed-file-name-masks '("\\.java$" my-java-flymake-init flymake-simple-cleanup))


;;80 words line and horizontal center
(setq whitespace-style '(face lines-tail trailing)
      whitespace-line-column 81)
(require 'horizontal-center)





;;flymake python
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "pycheckers"  (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pyflakes-init)))

;;atok shortcuts
(setq iiimcf-keycode-spec-alist
      (append
       '(
         (7 27)          ; c-g cancel
         (14 28  65535) ; C-n  next propositions
         (2 37 65535)    ; c-b left
         (16 38 65535)   ; c-p previous prop
         (6 39 65535)    ; c-f right
         (1 36 65535)    ; c-a first
         (5 35 65535)    ; c-e last

         (13 40 65535)   ; c-m -> confirm group
         
         (11 37 65535 1) ; c-k ->  previous group
         (12 39 65535 1) ; c-l ->  next group
         
         (21 121 65535)  ; c-u alphabet
         (15 118 65535)  ; c-o katakana
         )
       iiimcf-keycode-spec-alist))
