
;;(use-package monokai-theme
;;:ensure t
;;:config (load-theme 'monokai 0)
;;(setq monokai-use-variable-pitch nil))

;;(use-package darkokai-theme
;;:ensure t
;;:config (load-theme 'darkokai t)
;;(setq darkokai-mode-line-padding 0))

(use-package solarized-theme
:ensure t
:config (load-theme 'solarized-light t))

;;(use-package alect-themes
;;:ensure t
;;:config (load-theme 'alect-light t))

(use-package hlinum
:ensure t
:config
(global-linum-mode t)
(defun linum-update-window-scale-fix (win)
"fix linum for scaled text"
(set-window-margins win
(ceiling (* (if (boundp 'text-scale-mode-step)
(expt text-scale-mode-step
text-scale-mode-amount) 1)
(if (car (window-margins))
(car (window-margins)) 1)))))
(advice-add #'linum-update-window :after #'linum-update-window-scale-fix))

(use-package linum
:ensure t
:config
(global-hl-line-mode +1)
(setq linum-format "%-4d"))
(column-number-mode t)
(size-indication-mode t)

(set-cursor-color "SkyBlue2")

(use-package highlight-symbol
:ensure t
:bind (([f3] . highlight-symbol-at-point)
        ([f4] . highlight-symbol-remove-all)))

(use-package smex
:if (not (featurep 'helm-mode))
:ensure t
:bind ("M-x" . smex))

(use-package sublimity
:ensure t
:config
(setq sumlimity-scroll-weight 2
sublimity-scroll-drift-length 2)
(setq sublimity-attractive-centering-width 110))

(use-package auto-complete
:ensure t
:init (ac-config-default)
(global-auto-complete-mode t)
(setq ac-auto-start 3)
(setq ac-auto-show-menu 0.1)
(ac-set-trigger-key "TAB"))

(use-package yasnippet
:ensure t
:defer t
:diminish yas-minor-mode
:mode ("/\\.emacs\\.d/snippets/" . snippet-mode)
:init
(progn
(setq yas-verbosity 3)
(yas-global-mode 1))
(add-hook 'term-mode-hook (lambda() (setq yas-dont-activate t)))
(define-key yas-minor-mode-map (kbd "<tab>") nil)
(define-key yas-minor-mode-map (kbd "TAB") nil)
(define-key yas-minor-mode-map (kbd "C-c y") 'yas-expand)
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")
(add-hook
'prog-mode-hook
(lambda ()
(setq ac-sources
(append '(ac-source-yasnippet) ac-sources)))))

(use-package multiple-cursors
:ensure t
:bind (("C-l" . mc/edit-lines)
("C-;" . mc/mark-all-like-this)))

(use-package function-args
:ensure t
:config (fa-config-default)
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.h\\'" . c-mode))
(set-default 'semantic-case-fold t))

(use-package vlf
:ensure t
:config (custom-set-variables '(vlf-application 'dont-ask)))

(use-package dokuwiki-mode
:ensure t
:config (setq dokuwiki-username "knuth"
dokuwiki-password "genius120978"
dokuwiki-base-url "211.108.117.150/dokuwiki"))

(use-package bm
:ensure t
:bind (("C-1" . bm-toggle)
("C-2" . bm-next)
("C-3" . bm-previous)))

(use-package tabbar
:ensure t)

(setq dired-dwim-target t)

(use-package ecb
:ensure t)
:init (setq ecb-layout-name "right1")
(setq ecb-examples-bufferinfo-buffer-name nil)
(setq stack-trace-on-error t)
(setq ecb-version-check nil)
(setq ecb-compile-window-height 12)

(use-package hideshowvis
:ensure t
:bind (("C-t" . hs-toggle-hiding))
:init (add-hook 'c-mode-hook #'hideshowvis-enable)
(add-hook 'c++-mode-hook #'hideshowvis-enable)
(add-hook 'c-mode-hook #'hideshowvis-symbols)
(add-hook 'c++-mode-hook #'hideshowvis-symbols))

(use-package anything
:ensure t
:bind (("C-b" . anything-mini)))

;;(use-package org-bullets
;;:ensure t
;;:init (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(setq org-todo-keywords
 '((sequence
    "TODO(t)"  ; next action
    "TOBLOG(b)"  ; next action
    "STARTED(s)"
    "WAITING(w@/!)"
    "SOMEDAY(.)" "|" "DONE(x!)" "CANCELLED(c@)")
   (sequence "LEARN" "TRY" "TEACH" "|" "COMPLETE(x)")
   (sequence "TOSKETCH" "SKETCHED" "|" "POSTED")
   (sequence "TOBUY" "TOSHRINK" "TOCUT"  "TOSEW" "|" "DONE(x)")
   (sequence "TODELEGATE(-)" "DELEGATED(d)" "|" "COMPLETE(x)")))
(setq org-todo-keyword-faces
      '(("TODO" . (:foreground "green" :weight bold))
        ("DONE" . (:foreground "cyan" :weight bold))
        ("WAITING" . (:foreground "red" :weight bold))
        ("SOMEDAY" . (:foreground "gray" :weight bold))))
(setq org-log-done 'time)

(use-package magit
:ensure t
:bind   (("C-c l" . magit-log-all)
        ("C-x c" . magit-commit)
        ("C-x p" . magit-pull)))

(use-package helm
  :ensure t
  :init (progn
          (require 'helm-config)
          (setq helm-yank-symbol-first t
                helm-idle-delay 0.0
                helm-input-idle-delay 0.01
                helm-quick-update t
                helm-M-x-requires-pattern nil
                helm-ff-skip-boring-files t))
:bind (("C-x b" . helm-mini)
         ("C-f" . helm-semantic-or-imenu)
         ("C-x 8 <RET>" . helm-ucs)
         ("C-<f1>" . helm-apropos)))

(use-package helm-buffers
  :ensure helm
  :commands helm-buffers-list
  :config (setq helm-buffers-fuzzy-matching t))

(use-package helm-elisp
  :bind ("C-h a" . helm-apropos))

(use-package helm-git-grep
  :ensure t
  :commands helm-git-grep
  :config (setq helm-git-grep-candidate-number-limit nil))

(use-package helm-gtags
  :ensure t
  :commands (helm-gtags-mode helm-gtags-dwim)
  :diminish "HGt"
  :bind (("M-t" . helm-gtags-pop-stack)
        ("M-]" . helm-gtags-find-tag)
        ("M-[" . helm-gtags-find-rtag)
        ("M-." . helm-gtags-dwim)
        ("M-," . helm-gtags-tags-in-this-function)
        ("C-j" . helm-gtags-select)
        ("M-g M-p" . helm-gtags-parse-file)))

;; Enable helm-gtags-mode in code
(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'asm-mode-hook 'helm-gtags-mode)

(defun gtags-root-dir ()
    "Returns GTAGS root directory or nil if doesn't exist."
    (with-temp-buffer
      (if (zerop (call-process "global" nil t nil "-pr"))
          (buffer-substring (point-min) (1- (point-max)))
        nil)))

(defun gtags-update ()
    "Make GTAGS incremental update"
    (call-process "global" nil nil nil "-u"))

(defun gtags-update-hook ()
    (when (gtags-root-dir)
      (gtags-update)))

(add-hook 'after-save-hook #'gtags-update-hook)


(use-package helm-swoop
  :ensure t
  :bind (("C-c o" . helm-swoop)
         ("C-c O" . helm-multi-swoop)))

(use-package helm-descbinds
  :ensure t
  :bind (("C-h b" . helm-descbinds)
         ("C-h h" . helm-descbinds)))

(use-package helm-cscope
:ensure t
:bind (("C-c s" . helm-cscope-find-symbol)
("C-c g" . helm-cscope-find-global-definition)
("C-c f" . helm-cscope-find-called-function)
("C-c c" . helm-cscope-find-calling-this-function)
("C-c c" . helm-cscope-select)
("C-p" . helm-cscope-find-egrep-pattern))
:init 
;; Enable helm-gtags-mode in code
(add-hook 'c-mode-hook 'helm-cscope-mode)
(add-hook 'c++-mode-hook 'helm-cscope-mode)
(add-hook 'asm-mode-hook 'helm-cscope-mode))

(use-package helm-projectile
:ensure t
:bind (("C-p" . helm-projectile))
:config (helm-projectile-on)
:init (setq projectile-enable-caching t)
(setq projectile-switch-project-action 'projectile-dired)
(setq projectile-remember-window-configs t)
(setq projectile-completion-system 'helm)
(setq projectile-switch-project-action 'helm-projectile)
(projectile-global-mode))

(use-package beacon
:ensure t
:init (beacon-mode 1))

(set-fontset-font "fontset-default" '(#x1100 . #xffdc)
                   '("Gulim" . "iso10646-1"))
(set-fontset-font "fontset-default" '(#xe0bc . #xf66e)
                   '("Gulim" . "iso10646-1"))

(setq face-font-rescale-alist
       '((".*hiragino.*" . 1.0)
         (".*Gulim.*" . 1.0)))
(set-language-environment "Korean")

(fset 'yes-or-no-p 'y-or-n-p)
(modify-coding-system-alist 'file "\\.*\\'" 'utf-8)
(setq coding-system-for-read 'utf-8)
(setq-default
 whitespace-line-column 80
 whitespace-style       '(face lines-tail))

(use-package c-eldoc
:ensure t
:config (add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)
:init (add-hook 'c-mode-hook 'c-turn-on-eldoc-mode)
(add-hook 'c++-mode-hook 'c-turn-on-eldoc-mode)
(setq c-eldoc-buffer-regenerate-time 60)
(defun c-eldoc-define-keybindings (map)
(define-key map (kbd "C-c d") 'c-eldoc-force-cache-update))
(add-hook 'c-mode-hook
(lambda ()
(c-eldoc-define-keybindings c-mode-map))))

(defun linux-c-indent ()
  "adjusted defaults for C/C++ mode use with the Linux kernel."
  (interactive)
  (setq tab-width 8)
  ;;force spaces, to work with dumber editors
  (setq indent-tabs-mode nil) 
  (setq c-basic-offset 8))

(add-hook 'c-mode-hook 'linux-c-indent)
(add-hook 'c-mode-hook (lambda() (c-set-style "K&R")))
(add-hook 'c++-mode-hook 'linux-c-indent)

(semantic-mode t)
(add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)
(add-to-list 'semantic-default-submodes 'global-semantic-idle-summary-mode)

(global-semantic-idle-scheduler-mode t)
(global-semanticdb-minor-mode t)
(global-semantic-idle-summary-mode t)
(global-semantic-idle-completions-mode t)
(global-semantic-highlight-func-mode t)
(global-semantic-decoration-mode t)
(global-semantic-stickyfunc-mode t)
(global-semantic-mru-bookmark-mode t)
(setq-default semantic-symref-tool "global")

(semanticdb-enable-gnu-global-databases 'c++-mode)
(semanticdb-enable-gnu-global-databases 'c-mode)
(semanticdb-enable-gnu-global-databases 'python-mode)
;;;; auto-complete
(require 'auto-complete-config)
(ac-config-default)
(setq ac-auto-start 3)
(setq ac-auto-show-menu t)
(define-key ac-mode-map [(meta return)] 'auto-complete)

(setq show-paren-delay 0)
(show-paren-mode t)
(setq show-paren-style 'expression)
(set-face-background 'show-paren-match-face "#ffffff")
(set-face-foreground 'show-paren-match-face "#36648b")
(set-face-attribute 'show-paren-match-face nil
:weight 'bold :underline nil :overline nil :slant 'normal)

(use-package flycheck
:ensure t
:init (global-flycheck-mode))

(use-package rainbow-delimiters
:ensure t
:init (add-hook 'c-mode-hook #'rainbow-delimiters-mode)
(add-hook 'c++-mode-hook #'rainbow-delimiters-mode)
(add-hook 'makefile-mode-hook #'rainbow-delimiters-mode))

(use-package better-defaults
:ensure t
:init (ido-mode 0))

(use-package windmove
:bind ("M-<right>" . windmove-right)
("M-<left>" . windmove-left)
("M-<up>" . windmove-up)
("M-<down>" . windmove-down))

; default is 1000, reduce the backtrace level
(setq max-specpdl-size 5) 
; now you should get a backtrace
(setq debug-on-error t)
(setq large-file-warning-threshold nil) ;; etags file remove warning message

(global-set-key (kbd "C-s") 'rgrep)

(defun gtags-root-dir ()
    "Returns GTAGS root directory or nil if doesn't exist."
    (with-temp-buffer
      (if (zerop (call-process "global" nil t nil "-pr"))
          (buffer-substring (point-min) (1- (point-max)))
        nil)))

(defun gtags-update ()
    "Make GTAGS incremental update"
    (call-process "global" nil nil nil "-u"))

(defun gtags-update-hook ()
    (when (gtags-root-dir)
      (gtags-update)))

(add-hook 'after-save-hook #'gtags-update-hook)

(use-package elpy
:ensure t
:init
(require 'elpy)
;;elpy activate
(elpy-enable)
;; use autocomplete
(add-hook 'python-mode-hook
(lambda ()
(define-key elpy-mode-map (kbd "TAB") 'elpy-company-backend)))
;; disable auto complete on python-mode
(defadvice auto-complete-mode (around disable-auto-complete-for-python)
(unless (eq major-mode 'python-mode) ad-do-it))
(ad-activate 'auto-complete-mode))
