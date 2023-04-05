;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Moskas"
      user-mail-address "minemoskas@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; custom random splash image
(load-file "/home/moskas/projects/elisp/logo.el")
(setq logo-path "/home/moskas/.doom.d/logos/")
(setq logo-images (list "chocola.png" "chocola-vanilla.png" "chocola-surprised.png" "chocola-dead.png"))

(setq fancy-splash-image (logo-random))

(setq doom-theme 'doom-gruvbox)
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 16 :weight 'medium)
      doom-unicode-font(font-spec :family "JetBrainsMono Nerd Font" :size 16)
      doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font" :size 16 :weight 'medium))
(global-prettify-symbols-mode 1)
(elcord-mode 1)
(beacon-mode 1) ;; Flash line on cursor movement

;; elcord settings
(setq elcord-quiet t)
(setq elcord-use-major-mode-as-main-icon t)
(setq elcord-idle-message "Thinking 🤔")
(setq elcord-idle-timer 1000)

(setq mastodon-active-user "Moskas")
(setq mastodon-instance-url "https://fosstodon.org")

(setq empv-invidious-instance "https://invidious.baczek.me/api/v1")
(use-package ox-moderncv
  :load-path "/home/moskas/Documents/Org/org-cv/"
  :init (require 'ox-moderncv))

(use-package blamer
  :bind (("s-i" . blamer-show-commit-info))
  :defer 20
  :custom
  (blamer-idle-time 0.3)
  (blamer-min-offset 70)
  :custom-face
  (blamer-face ((t :foreground "#d3869b"
                   :background nil
                   :height 110
                   :italic t)))
  :config
  (global-blamer-mode 1))


(require 'battery)
(when (and battery-status-function
           (not (string-match-p "N/A"
                                (battery-format "%B"
                                                (funcall battery-status-function)))))
  (display-battery-mode 1))

(add-to-list 'load-path "~/.emacs.d/site-lisp/emacs-application-framework/")

;; Nov-mode setup
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
(defun my-nov-font-setup ()
  (face-remap-add-relative 'variable-pitch :family "JetBrainsMono Nerd Font"
                           :height 1.0))
(setq nov-text-width t)
(setq visual-fill-column-center-text t)
(add-hook 'nov-mode-hook 'my-nov-font-setup)
(add-hook 'nov-mode-hook 'visual-line-mode)
(add-hook 'nov-mode-hook 'visual-fill-column-mode)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/Org/")
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
;; Hooks
(add-hook 'python-mode-hook #'rainbow-mode)
(add-hook 'org-mode-hook #'olivetti-mode)

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
