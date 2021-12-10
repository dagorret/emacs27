(require 'cl)
(require 'package)

(setq cfg-var:packages '(
	powerline 
	doom-themes 
	wc-mode
	savehist 
	markdown-mode 
      	which-key 
	auto-complete 
	flycheck
	auctex
))

(defun cfg:install-packages ()
    (let ((pkgs (remove-if #'package-installed-p cfg-var:packages)))
        (when pkgs
            (message "%s" "Emacs refresh packages database...")
            (package-refresh-contents)
            (message "%s" " done.")
            (dolist (p cfg-var:packages)
                (package-install p)))))

(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(package-initialize)

(cfg:install-packages)

;; Inicio configuracion
;;
;;

(require 'iso-transl)

;; General Imporante
(setq shell-file-name "bash")
(defalias 'yes-or-no-p 'y-or-n-p)
(setq x-select-enable-clipboard t)

;; Ispell default dictionary
(setq ispell-dictionary "castellano")


;;Backup
;; backup in one place. flat, no tree structure
(setq backup-directory-alist '(("" . "~/.emacs.d/emacs-backup")))


;;Tema
(require 'powerline)
(powerline-default-theme)
(setq powerline-arrow-shape 'curve)
(load-theme 'doom-molokai t)
;; Now make it prettier:
(require 'powerline)
;;(set-face-attribute 'mode-line nil
;;                    :foreground "Black"
;;                    :background "DarkOrange"
;;                    :box nil)



;; Enable flashing mode-line on errors
(doom-themes-visual-bell-config)

;; Enable custom neotree theme (all-the-icons must be installed!)
(doom-themes-neotree-config)
;; or for treemacs users
(doom-themes-treemacs-config)

;; Corrects (and improves) org-mode's native fontification.
(doom-themes-org-config)

;;Contar palabras
;; Add the path to the repo
;; Word Count minor mode
;; https://github.com/bnbeckwith/wc-mode
(require 'wc-mode)
;; Suggested setting
(global-set-key "\C-cw" 'wc-mode)
;; Modeline format
(setq wc-modeline-format "Words: %tw")
(wc-mode)


;;; Set window size
;;(setq default-frame-alist '((width . 130) (height . 45)))

;;; Disable useless GUI stuff
;;(tool-bar-mode -1)
;;(when (fboundp 'scroll-bar-mode)
;;  (scroll-bar-mode -1))
;;(when (fboundp 'horizontal-scroll-bar-mode)
;;  (horizontal-scroll-bar-mode -1))
;;(menu-bar-mode -1)
;;(blink-cursor-mode -1)
;;(setq use-file-dialog nil)
;;(setq use-dialog-box nil)
;(tool-bar-mode -1)
;(when (fboundp 'scroll-bar-mode)
;  (scroll-bar-mode -1))
;(when (fboundp 'horizontal-scroll-bar-mode)
;  (horizontal-scroll-bar-mode -1))
;(menu-bar-mode -1)
;(blink-cursor-mode -1)
;(setq use-file-dialog nil)
;(setq use-dialog-box nil)

;;; Start with empty scratch buffer
;(fset #'display-startup-echo-area-message #'ignore)
;(setq inhibit-splash-screen t)
;(setq initial-scratch-message "")

;;; Set the font
;;;(set-face-attribute 'default nil :family "Hack")
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:height 120 :family "Hack")))))

;;; Use fucking UTF-8
(prefer-coding-system 'utf-8)
(set-language-environment "UTF-8")
(setq locale-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(setq-default buffer-file-coding-system 'utf-8-unix)

;;; Fix scrolling
(setq mouse-wheel-progressive-speed nil)
(setq scroll-margin 3)
(setq scroll-conservatively 100000)
(setq scroll-preserve-screen-position 'always)

;;; Clipboard
(setq-default select-active-regions nil)
(when (boundp 'x-select-enable-primary)
  (setq x-select-enable-primary nil))

;;; Set undo limits
(setq undo-limit (* 16 1024 1024))
(setq undo-strong-limit (* 24 1024 1024))
(setq undo-outer-limit (* 64 1024 1024))

;;; Do not disable commands
(setq disabled-command-function nil)

;;; Disable electrict indent
(when (bound-and-true-p electric-indent-mode)
  (electric-indent-mode -1))

;;; Disable VC
(setq vc-handled-backends '())

;;(global-undo-tree-mode)
;;(setq undo-tree-visualizer-timestamps t)
;;(setq undo-tree-visualizer-lazy-drawing nil)
;;(setq undo-tree-auto-save-history t)
;;(let ((undo-dir (expand-file-name "undo" user-emacs-directory)))
;;  (setq undo-tree-history-directory-alist (list (cons "." undo-dir))))

;;; Ignore case for completion
(setq completion-ignore-case t)
(setq read-buffer-completion-ignore-case t)
(setq read-file-name-completion-ignore-case t)

;;; Search highlight
(setq search-highlight t)
(setq query-replace-highlight t)

;;; Title bar format
(setq icon-title-format (setq frame-title-format "%b [%f] - Emacs"))

;;; Enable the buffer boundary indicators
(setq-default indicate-empty-lines t)
(setq-default indicate-buffer-boundaries 'left)

;;; Paragraph filling
(setq sentence-end-double-space nil)
(setq-default fill-column 80)

;;; Echo keystrokes
(setq echo-keystrokes 1.0E-50)

;;; windmove
(require 'windmove)
(setq windmove-wrap-around t)


;;; History saving
(require 'savehist)
(setq history-length 1024)
(setq search-ring-max 1024)
(setq regexp-search-ring-max 1024)
(setq savehist-additional-variables '(extended-command-history file-name-history search-ring regexp-search-ring))
(setq savehist-file (expand-file-name ".savehist" user-emacs-directory))
(savehist-mode)


;;; Increse number for large file. This show number file, not "??"
;;(setq line-number-display-limit-width 2000000)
(global-linum-mode t)     

;; Markdown
;; (use-package markdown-mode
;;  :ensure t
;;  :commands (markdown-mode gfm-mode)
;;  :mode (("README\\.md\\'" . gfm-mode)
;;         ("\\.md\\'" . markdown-mode)
;;         ("\\.markdown\\'" . markdown-mode))
;;  :init (setq markdown-command "multimarkdown")

(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(autoload 'gfm-mode "markdown-mode"
   "Major mode for GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))



;; Key bindings
(global-set-key [(shift down)] #'windmove-down)
(global-set-key [(shift left)] #'windmove-left)
(global-set-key [(shift right)] #'windmove-right)
(add-hook 'org-shiftup-final-hook #'windmove-up)
(add-hook 'org-shiftleft-final-hook #'windmove-left)
(add-hook 'org-shiftdown-final-hook #'windmove-down)
(add-hook 'org-shiftright-final-hook #'windmove-right)

;;C++
;; set up package sources

;; small interface tweaks
;(setq inhibit-startup-message t)
(tool-bar-mode -1)
(fset 'yes-or-no-p 'y-or-n-p)
(global-set-key (kbd "<f5>") 'revert-buffer)

;; bring up help for key use-package which-key
(which-key-mode)


;; Auto completion
(ac-config-default)
(global-auto-complete-mode t)



;; on the fly syntax checking
(global-flycheck-mode t)



;;Keybindig
(global-set-key [(shift up)] #'windmove-up)
(global-set-key [(shift down)] #'windmove-down)
(global-set-key [(shift left)] #'windmove-left)
(global-set-key [(shift right)] #'windmove-right)
(add-hook 'org-shiftup-final-hook #'windmove-up)
(add-hook 'org-shiftleft-final-hook #'windmove-left)
(add-hook 'org-shiftdown-final-hook #'windmove-down)
(add-hook 'org-shiftright-final-hook #'windmove-right)

;;
;; GNUS ;;

(setq gnus-select-method '(nnimap "mail"
(nnimap-address "nw.dagorret.net")
(nnimap-server-port 993)
(nnimap-stream ssl)
(nnmail-expiry-target "nnimap+mail:Trash")  ; Move expired messages to Gmail's trash.
(nnmail-expiry-wait immediate)
(nnimap-stream ssl)))

 ; Mails marked as expired can be processed immediately.

(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)

(setq gnus-thread-sort-functions
           '(gnus-thread-sort-by-most-recent-date
             gnus-thread-sort-by-subject
             (not gnus-thread-sort-by-total-score)))
             
;;@see http://gnus.org/manual/gnus_397.html
;; (add-to-list 'gnus-secondary-select-methods
;;              )

(setq-default
  gnus-summary-line-format "%U%R%z %(%&user-date;  %-15,15f  %B%s%)\n"
  gnus-user-date-format-alist '((t . "%Y-%m-%d %H:%M"))
  gnus-summary-thread-gathering-function 'gnus-gather-threads-by-references
  gnus-sum-thread-tree-false-root ""
  gnus-sum-thread-tree-indent ""
  gnus-sum-thread-tree-leaf-with-other "-> "
  gnus-sum-thread-tree-root ""
  gnus-sum-thread-tree-single-leaf "|_ "
  gnus-sum-thread-tree-vertical "|")
(setq gnus-thread-sort-functions
      '(
        (not gnus-thread-sort-by-date)
        (not gnus-thread-sort-by-number)
        ))

;; we want to browse freely from gwene (RSS)
;; (setq gnus-safe-html-newsgroups "\\`nntp[+:]news\\.gwene\\.org[+:]")

; NO 'passive
(setq gnus-use-cache t)
(setq gnus-use-adaptive-scoring t)
(setq gnus-save-score t)
;(add-hook 'mail-citation-hook 'sc-cite-original)
(add-hook 'message-sent-hook 'gnus-score-followup-article)
(add-hook 'message-sent-hook 'gnus-score-followup-thread)
; @see http://stackoverflow.com/questions/945419/how-dont-use-gnus-adaptive-scoring-in-some-newsgroups
(setq gnus-parameters
      '(("nnimap.*"
         (gnus-use-scoring nil)) ;scoring is annoying when I check latest email
        ))

(defvar gnus-default-adaptive-score-alist
  '((gnus-kill-file-mark (from -10))
    (gnus-unread-mark)
    (gnus-read-mark (from 10) (subject 30))
    (gnus-catchup-mark (subject -10))
    (gnus-killed-mark (from -1) (subject -30))
    (gnus-del-mark (from -2) (subject -15))
    (gnus-ticked-mark (from 10))
    (gnus-dormant-mark (from 5))))

;; Fetch only part of the article if we can.  I saw this in someone
;; else's .gnus
(setq gnus-read-active-file 'some)

;; Tree view for groups.  I like the organisational feel this has.
(add-hook 'gnus-group-mode-hook 'gnus-topic-mode)

;; Threads!  I hate reading un-threaded email -- especially mailing
;; lists.  This helps a ton!
(setq gnus-summary-thread-gathering-function
      'gnus-gather-threads-by-subject)

;; Also, I prefer to see only the top level message.  If a message has
;; several replies or is part of a thread, only show the first
;; message.  'gnus-thread-ignore-subject' will ignore the subject and
;; look at 'In-Reply-To:' and 'References:' headers.
(setq gnus-thread-hide-subtree t)
(setq gnus-thread-ignore-subject t)

(defun my/message-insert-citation-line ()
  "Based off `message-insert-citation-line`."
  (when message-reply-headers
    (insert "On " (mail-header-date message-reply-headers) " ")
    (insert (mail-header-from message-reply-headers) " writes:")
    (newline)
    (newline)))

(setq message-citation-line-function 'my/message-insert-citation-line)
            
;;(setq gnus-user-agent "Emacs Email Dagorret System" )
                 
;; END GNUS ;;

;; Truncación de Líneas
(add-hook 'text-mode-hook '(lambda ()
    (setq truncate-lines nil
          word-wrap t)))

(add-hook 'org-mode-hook '(lambda ()
    (setq truncate-lines nil
          word-wrap t)))

(add-hook 'prog-mode-hook '(lambda ()
    (setq truncate-lines t
          word-wrap nil)))

(setq-default global-visual-line-mode t)

;; Diccionarios chqueo 
;; easy spell check
(global-set-key (kbd "C-c v w") 'ispell-word)
(global-set-key (kbd "C-c v m") 'flyspell-mode)
(global-set-key (kbd "C-c v b") 'flyspell-buffer)
(global-set-key (kbd "C-c v p") 'flyspell-check-previous-highlighted-word)
(defun flyspell-check-next-highlighted-word ()
  "Custom function to spell check next highlighted word"
  (interactive)
 (flyspell-goto-next-error)
  (ispell-word)
  )
(global-set-key (kbd "C-c v n") 'flyspell-check-next-highlighted-word)




;; SMTP ;;

(setq message-send-mail-function 'smtpmail-send-it
smtpmail-starttls-credentials '(("smtp.dagorret.net" 587 nil nil))
smtpmail-auth-credentials '(("smtp.dagorret.net" 587 "carlos" nil))
smtpmail-default-smtp-server "smtp.dagorret.net"
smtpmail-smtp-server "smtp.dagorret.net"
smtpmail-smtp-service 587
smtpmail-stream-type  'starttls
smtpmail-local-domain "home.dagorret.net"
)

;;(setq message-send-mail-function 'smtpmail-send-it
;;      smtpmail-starttls-credentials '(("smtp-relay.gmail.com" 465 nil nil))
;;      smtpmail-auth-credentials '(("smtp-relay.gmail.com" 465 "carlos@dagorret.net" nil))
;;      smtpmail-default-smtp-server "smtp-relay.gmail.com"
;;      smtpmail-smtp-server "smtp-relay.gmail.com"
;;      smtpmail-smtp-service 465
;;      starttls-gnutls-program "/usr/bin/gnutls-cli"
;;      starttls-extra-arguments nil
;;      starttls-use-gnutls t
;;     smtpmail-local-domain "dl.dagorret.ga")
      

(setq user-full-name "Carlos Dagorret")
(setq user-mail-address "carlos@dagorret.net")

;; END SMTP ;;


(setq org-file-apps
    (quote
        ((auto-mode . emacs)
        ("\\.mm\\'" . default)
        ("\\.x?html?\\'" . "/usr/bin/firefox %s")
        ("\\.pdf\\'" . default))))

;; Eliminar mensaje ;;;Commentary
(setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(delete-selection-mode nil)
 '(package-selected-packages
   '(bbdb savehist which-key wc-mode undo-tree powerline markdown-mode flycheck doom-themes auto-complete))
 '(truncate-lines t))
