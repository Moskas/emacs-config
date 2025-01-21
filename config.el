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
(load! "/home/moskas/.config/doom/custom/logo.el")

(setq logo-path "/home/moskas/.config/doom/logos/")
(setq logo-images
      (list
       "chocola.png"
       "chocola-vanilla.png"
       "chocola-surprised.png"
       "chocola-dead.png"
       "chocola-laughing.png"
       "chocola-ok.png"
       "chocola-sorry.png"
       "go.png"
       "chocola-dead.png"
       "smaller_GNU.png"
       ))

(setq fancy-splash-image (logo-random))

(setq doom-theme 'doom-gruvbox)
;;(setq doom-theme 'custom-base16)

;;(after! doom-ui
;;	(use-package circadian
;;	  :ensure t
;;	  :config
;;	  (setq calendar-latitude 52.2297)
;;	  (setq calendar-longitude 21.0122)
;;	  (setq circadian-themes '((:sunrise . doom-gruvbox-light)
;;	                           (:sunset  . doom-gruvbox)))
;;	  (circadian-setup)))

(setq doom-font (font-spec :family "JetBrains Mono Nerd Font" :size 16 :weight 'regular)
      ;;doom-unicode-font(font-spec :family "JetBrainsMono Nerd Font" :size 16)
      doom-variable-pitch-font (font-spec :family "JetBrains Mono Nerd Font" :size 16 :weight 'regular))
(global-prettify-symbols-mode 1)

;; elcord settings
(setq elcord-quiet t)
(setq elcord-use-major-mode-as-main-icon t)
(setq elcord-idle-message "Thinking 🤔")
(setq elcord-idle-timer 1000)

(setq mastodon-active-user "Moskas")
(setq mastodon-instance-url "https://fosstodon.org")

(use-package! blamer
  :bind (("s-i" . blamer-show-commit-info))
  :after
  doom-theme
  :defer 20
  :custom
  (blamer-idle-time 0.3)
  (blamer-min-offset 20)
  (custom-set-faces
   `(blamer-face ((t (:foreground ,(doom-color 'violet) :italic t)))))
  :config
  (global-blamer-mode 1))
;; Nov-mode setup
(add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode))
(defun my-nov-font-setup ()
  (face-remap-add-relative 'variable-pitch :family "Iosevka Nerd Font"
                           ;;:height 1.0
                           :size 16
                           :weight medium))
(setq nov-text-width t)
(setq visual-fill-column-center-text t)
(add-hook 'nov-mode-hook 'my-nov-font-setup)
(add-hook 'nov-mode-hook 'visual-line-mode)
(add-hook 'nov-mode-hook 'visual-fill-column-mode)

(use-package nov-xwidget
  :after nov
  :config
  (define-key nov-mode-map (kbd "o") 'nov-xwidget-view)
  (add-hook 'nov-mode-hook 'nov-xwidget-inject-all-files))


;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/Documents/Org/")
(after! org
  (setq org-roam-directory "~/Documents/org/roam/")
  (setq org-roam-index-file "~/Documents/org/roam/index.org"))
(setq display-time-24hr-format t)
(setq display-time-default-load-average nil)

(setq olivetti-body-width 90)

;; Org-mode tweaks
(defun my-org-faces ()
  (setq org-hide-emphasis-markers t)
  (set-face-attribute 'org-todo nil :height 1.0)
  (set-face-attribute 'org-level-1 nil :height 1.3)
  (set-face-attribute 'org-level-2 nil :height 1.2)
  (set-face-attribute 'org-level-3 nil :height 1.1)
  (set-face-attribute 'org-document-title nil :height 1.5)
  (display-time)
  (display-line-numbers-mode 0)
  (org-indent-mode 1)
  (blamer-mode 0)
  (olivetti-mode 1)
  (beacon-mode 0))
(add-hook 'org-mode-hook #'my-org-faces)

(add-hook 'org-mode-hook
          (lambda ()
            (dolist (pair '(("[ ]"         . ?)
                            ("[X]"         . ?)
                            ("[-]"         . ?)
                            ("#+title:"    . ?)
                            ("#+TITLE:"    . ?)
                            ("#+author:"   . ?)
                            ("#+AUTHOR:"   . ?)
                            ("#+options:"  . ?)
                            ("#+OPTIONS:"  . ?)
                            ("#+email:"    . ?)
                            ("#+EMAIL:"    . ?)
                            ("#+include"   . ?⭳)
                            ("#+INCLUDE"   . ?⭳)
                            ("#+begin_src" . ?)
                            ("#+BEGIN_SRC" . ?)
                            ("#+end_src"   . ?)
                            ("#+END_SRC"   . ?)
                            ("#+begin_quote" . ?)
                            ("#+BEGIN_QUOTE" . ?)
                            ("#+end_quote" . ?)
                            ("#+END_QUOTE" . ?)
                            ("#+date:"     . ?)
                            ("#+DATE:"     . ?)
                            ("#+tags:"     . ?)
                            ("#+TAGS:"     . ?)
                            ("#+HTML_HEAD:" . ?)
                            ("#+HTML:"      . ?)
                            ("#+startup:"   . ?)
                            ("#+STARTUP:"   . ?)
                            ("#+RESULTS:"   . ?)
                            (":tangle"     . ?)))
              (add-to-list 'prettify-symbols-alist pair))
            (prettify-symbols-mode)))

(ligature-set-ligatures '(org-mode) '("<!--" "-->" "</>" "</" "/>" "://" "<=" ">=" "==" "!=" "=>" "->" "<-" ">->" "<-<"))

;; Remove "~" fringe in text-mode
(remove-hook 'text-mode-hook #'vi-tilde-fringe-mode)
;; Disable line-number mode in text mode
(remove-hook 'text-mode-hook #'line-number-mode)
;;(add-hook 'org-mode-hook 'markdown-mode-hook #'olivetti-mode)

(setq display-line-numbers-type 'relative)

(add-hook 'prog-mode #'rainbow-mode)
;;(add-hook 'markdown-mode-hook () (lambda (olivetti-mode 1)))
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
     (with-face (system-name) :foreground "#689d6a")
     (if (= (user-uid) 0)
         (with-face " #" :foreground "#cc241d")
       " $")
     " ")))
(setq eshell-prompt-function 'shk-eshell-prompt)
(setq eshell-highlight-prompt nil)

(use-package! ellama
  :init
  (setopt ellama-language "English")
  (require 'llm-ollama)
  (setopt ellama-keymap-prefix "C-c e")
  (setopt ellama-auto-scroll t)
  (setopt ellama-provider
          (make-llm-ollama
           :chat-model "qwen2.5-coder:7b" :embedding-model "qwen2.5-coder:7b"))
  (setopt ellama-providers
          '(("mistral" .
             (make-llm-ollama
              :chat-model "mistral" :embedding-model "mistral"))
            ("codellama" .
             (make-llm-ollama
              :chat-model "codellama" :embedding-model "codellama")))))

(add-hook 'nix-mode-hook #'rainbow-delimiters-mode)
(setq direnv-always-show-summary nil)

(use-package rainbow-mode
  :hook org-mode prog-mode)

(setq mu4e-root-maildir "~/.mail/gmail"
      mu4e-sent-folder "/Sent"
      mu4e-drafts-folder "/Drafts"
      mu4e-trash-folder "/Trash"
      mu4e-split-view 'vertical)

;; Add nano agenda
(map! :leader
      :desc "Open nano agenda" "o a n" #'nano-agenda)
;; Disable evil-mode in nano-agenda buffer
(add-to-list 'evil-insert-state-modes 'nano-agenda-mode)

(map! :leader
      :desc "Olliveti mode" "t o" #'olivetti-mode)
(map! :leader
      :desc "Spacious padding mode" "t p" #'spacious-padding-mode)

(add-hook 'nix-mode #'rainbow-delimiters-mode)

(pixel-scroll-precision-mode t)

(use-package spacious-padding
  :custom
  (setq spacious-padding-subtle-mode-line
        `( :mode-line-active 'default
           :mode-line-inactive vertical-border))
  :init
  (spacious-padding-mode 1))

(setq spacious-padding-widths
      `( :internal-border-width 5
         :header-line-width 4
         :mode-line-width 3
         :tab-width 4
         :right-divider-width 2
         :scroll-bar-width 8
         :right-fringe-width 4
         :left-fringe-width 4))
;;(use-package centaur-tabs
;;  :config
;;  (setq centaur-tabs-height 32)
;;  :init
;;  (centaur-tabs-mode t)
;;  :hook
;;  (+doom-dashboard-mode . centaur-tabs-local-mode)
;;  (dired-mode . centaur-tabs-local-mode)
;;  (nov-mode . centaur-tabs-local-mode)
;;  (xwidget-webkit-mode . centaur-tabs-local-mode)
;;  (elfeed-search-mode . centaur-tabs-local-mode)
;;  (elfeed-show-mode . centaur-tabs-local-mode)
;;  (tetris . centaur-tabs-local-mode)
;;  (vterm-mode . centaur-tabs-local-mode))

;;(custom-theme-set-faces! 'doom-gruvbox
;;  '(org-block :background "#3c3836")
;;  '(treemacs-window-background-face :background "#1d2021"))

(setq rmh-elfeed-org-files (list "~/Documents/Org/elfeed.org"))
(setq elfeed-goodies/powerline-default-separator 'box)

;;(add-hook! 'elfeed-show-mode-hook (lambda () olivetti-mode (spacious-padding-mode -1)))

(map! :localleader
      (:map elfeed-show-mode-map
            "w" #'elfeed-webkit-toggle))

(defun dev-website ()
  "Open local copy of moskas.github.io in xwidgets"
  (interactive)
  (split-window-right)
  (windmove-right)
  (xwidget-webkit-browse-url "file:///home/moskas/Projects/moskas.github.io/index.html"))

(defun self-screenshot (&optional type)
  "Save a screenshot of type TYPE of the current Emacs frame.
As shown by the function `', type can wield the value `svg',
`png', `pdf'.

This function will output in /tmp a file beginning with \"Emacs\"
and ending with the extension of the requested TYPE."
  (interactive (list
                (intern (completing-read "Screenshot type: "
                                         '(png svg pdf postscript)))))
  (let* ((extension (pcase type
                      ('png        ".png")
                      ('svg        ".svg")
                      ('pdf        ".pdf")
                      ('postscript ".ps")
                      (otherwise (error "Cannot export screenshot of type %s" otherwise))))
         (filename (make-temp-file "Emacs-" nil extension))
         (data     (x-export-frames nil type)))
    (with-temp-file filename
      (insert data))
    (kill-new filename)
    (message filename)))

(defun open-current-link-in-mpv ()
  (interactive)
  (setq url (thing-at-point 'url))
  (string-match "youtube.com" url))

(defun rebuild-system ()
  "Rebuild nixos flake using nh"
  (interactive)
  (eshell-command "nh os switch --no-nom"))

(defun insert-time ()
  "Insert date and time at the current cursor position"
  (interactive)
  (insert (format-time-string "%d %b %Y %H:%M:%S" (current-time))))

(map! :leader
      :desc "Insert current time" "i t" #'insert-time)

(map! :leader
      :desc "Toggle org-indent" "t O" #'org-indent-mode)

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
