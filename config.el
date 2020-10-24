;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!
(add-to-list 'custom-theme-load-path (expand-file-name "~/.emacs.d/themes/"))

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "mir"
      user-mail-address "miracle_l@bupt.edu.cn")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;

;; Font Config
;(setq doom-font (font-spec :family "Fira Code" :size 18 :weight 'Regular))

(defun +my/better-font()
  (interactive)
  ;; english font
  (if (display-graphic-p)
      (progn
        (set-face-attribute 'default nil :font (format "%s:pixelsize=%d" "JetBrainsMono Nerd Font" 21)) ;; 11 13 17 19 23
        ;; chinese font
        (dolist (charset '(kana han symbol cjk-misc bopomofo))
          (set-fontset-font (frame-parameter nil 'font)
                            charset
                            (font-spec :family "Sarasa Mono SC Nerd")))) ;; 14 16 20 22 28
    ))

(defun +my|init-font(frame)
  (with-selected-frame frame
    (if (display-graphic-p)
        (+my/better-font))))

(if (and (fboundp 'daemonp) (daemonp))
    (add-hook 'after-make-frame-functions #'+my|init-font)
  (+my/better-font))

;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-nord)
;(load-theme 'nord t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Sync/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Project Path
(projectile-add-known-project "~/Sync/org")
(projectile-add-known-project "~/Sync/Homework")
(projectile-add-known-project "~/code/haskell")
(projectile-add-known-project "~/go/src/learn")
(projectile-add-known-project "~/go/src/leetcode")

;; Org Mode Config

(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(map! :leader
      :desc "rainbow-mode"
      "r" #'rainbow-mode)
(map! :leader
      :desc "comment"
      "C-c" #'comment-line)

(require 'rainbow-mode)
(dolist (hook '(css-mode-hook
             html-mode-hook))
  (add-hook hook (lambda () (rainbow-mode t))))

;; Clipbroad
(setq select-enable-clipboard t)
(xclip-mode 1)

;; Neotree Config
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))

;; Golang Config
(require 'dap-go)
(map! :leader
      :desc "Debug"
      "d" #'dap-debug)

;; Haskell Config
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
(setq haskell-process-type 'cabal-new-repl)

;; org-download
(use-package org-download
	  ;; Keybind：Ctrl + Shift + Y
	  :bind ("C-S-y" . org-download-clipboard)
	  :config
	  (require 'org-download)
	  ;; Drag and drop to Dired
	  (add-hook 'dired-mode-hook 'org-download-enable)
	  )

;; Company-box
(use-package company-box
  :hook (company-mode . company-box-mode))

(require 'org2ctex)
(org2ctex-toggle t)
