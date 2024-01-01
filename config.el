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
(load-file "/home/moskas/.config/doom/custom/logo.el")
(setq logo-path "/home/moskas/.config/doom/logos/")
(setq logo-images (list "chocola.png" "chocola-vanilla.png" "chocola-surprised.png" "chocola-dead.png"))

(setq fancy-splash-image (logo-random))

(setq doom-theme 'doom-gruvbox)
(add-to-list 'default-frame-alist '(background-color . "#32302f"))
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 16 :weight 'medium)
      ;;doom-unicode-font(font-spec :family "JetBrainsMono Nerd Font" :size 16)
      doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font" :size 16 :weight 'medium))
(global-prettify-symbols-mode 1)
(beacon-mode 1) ;; Flash line on cursor movement

;; elcord settings
(setq elcord-quiet t)
(setq elcord-use-major-mode-as-main-icon t)
(setq elcord-idle-message "Thinking 🤔")
(setq elcord-idle-timer 1000)

(setq mastodon-active-user "Moskas")
(setq mastodon-instance-url "https://fosstodon.org")

(use-package blamer
  :bind (("s-i" . blamer-show-commit-info))
  :defer 20
  :custom
  (blamer-idle-time 0.3)
  (blamer-min-offset 70)
  :custom-face
  (blamer-face ((t :foreground "#d3869b"
                   :background nil
                   :height 100
                   :italic t)))
  :config
  (global-blamer-mode 1))
;;(setq blamer-view 'overlay)
;;(setq blamer-author-formatter "  ✎ %s ")
;;(setq blamer-datetime-formatter "[%s]")
;;(setq blamer-commit-formatter " ● %s")

;; Nov-mode setup
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
(defun my-nov-font-setup ()
  (face-remap-add-relative 'variable-pitch :family "Iosevka"
                           :height 1.0
                           :weight medium))
(setq nov-text-width t)
(setq visual-fill-column-center-text t)
(add-hook 'nov-mode-hook 'my-nov-font-setup)
(add-hook 'nov-mode-hook 'visual-line-mode)
(add-hook 'nov-mode-hook 'visual-fill-column-mode)
;; disable beacon-mode in nov-mode
(add-hook 'nov-mode-hook (lambda () beacon-mode -1))
;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/Org/")
(after! org
  (setq org-roam-directory "~/Documents/org/roam/")
  (setq org-roam-index-file "~/Documents/org/roam/index.org"))
(setq display-time-24hr-format t)
(setq display-time-default-load-average nil)

;; Org-mode tweaks
(defun my-org-faces ()
  (set-face-attribute 'org-todo nil :height 1.0)
  (set-face-attribute 'org-level-1 nil :height 1.2)
  (set-face-attribute 'org-level-2 nil :height 1.1)
  (setq org-hide-emphasis-markers t)
  (set-face-attribute 'org-block-begin-line nil :background 'unspecified)
  (set-face-attribute 'org-block-end-line nil :background 'unspecified)
  ;; Set the foreground color to the value of the background color
  (set-face-attribute 'org-block-begin-line nil
                      :foreground (face-background 'org-block-begin-line nil 'default))
  (set-face-attribute 'org-block-end-line nil
                      :foreground (face-background 'org-block-end-line nil 'default))
  (display-time)
  (display-line-numbers-mode 0)
  )
(add-hook 'org-mode-hook #'my-org-faces)

;; Markdown-mode tweaks
(custom-set-faces
 '(markdown-header-face ((t (:inherit font-lock-function-name-face :weight bold :family "variable-pitch"))))
 '(markdown-header-face-1 ((t (:inherit markdown-header-face :height 1.3))))
 '(markdown-header-face-2 ((t (:inherit markdown-header-face :height 1.2))))
 '(markdown-header-face-3 ((t (:inherit markdown-header-face :height 1.1)))))
(add-hook 'python-mode-hook #'rainbow-mode)
(add-hook 'org-mode-hook #'olivetti-mode)
(add-hook 'markdown-mode-hook #'olivetti-mode)
;; eshell config
(defun with-face (str &rest face-plist)
  (propertize str 'face face-plist))

(defun shk-eshell-prompt ()
  (let ((header-bg "#282828"))
    (concat
     (with-face (concat (eshell/pwd) " ") :background header-bg)
     (with-face (format-time-string "(%Y-%m-%d %H:%M) " (current-time)) :background header-bg :foreground "#ebdbb2")
     (with-face
      (or (ignore-errors (format "(%s)" (vc-responsible-backend default-directory))) "")
      :background header-bg)
     (with-face "\n" :background header-bg)
     (with-face user-login-name :foreground "#458588")
     "@"
     (with-face "gungnir" :foreground "#689d6a")
     (if (= (user-uid) 0)
         (with-face " #" :foreground "#cc241d")
       " $")
     " ")))
(setq eshell-prompt-function 'shk-eshell-prompt)
(setq eshell-highlight-prompt nil)

(direnv-mode)

(use-package ellama
  :init
  (setopt ellama-language "English")
  (require 'llm-ollama)
  (setopt ellama-provider
	  (make-llm-ollama
	   :chat-model "codellama" :embedding-model "codellama")))

(global-set-key (kbd "C-S-V") #'kill-ring-save)

(custom-set-faces! '(default :background "#282828"))

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
