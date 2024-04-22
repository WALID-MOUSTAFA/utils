;;; Code:
(package-initialize)

(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://melpa.org/packages/")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(add-hook 'web-mode-hook 'emmet-mode)
(add-to-list 'auto-mode-alist '("\\.jsp$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.vue$" . (lambda()
					      (web-mode)
					      (setq create-lockfiles nil))))
(add-hook 'web-mode-hook (lambda ()
			   (set-face-attribute 'web-mode-html-tag-face nil
					       :foreground "#013220"
					       :bold t)))
(add-hook 'sgml-mode-hook 'emmet-mode)
(add-hook 'css-mode-hook 'emmet-mode)
(add-hook 'prog-mode-hook 'multiple-cursors-mode)
(add-hook 'prog-mode-hook 'eldoc-mode)
;; (add-hook 'completion-at-point-functions
;;'go-complete-at-point) ;;needs gocode binary in PATH
(defun create_etags (dir-name files-name-regex)
  "creating etags"
  (interactive "DDirectory: \nsFiles name regex: ") 
  (eshell-command
   (format "find %s -name %s | etags - --append" dir-name files-name-regex)))

(add-hook 'prog-mode-hook 'projectile-mode)


(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(visual-line-mode 1)
(setq make-backup-files nil)
(setq inhibit-startup-message t) 
(setq indent-tabs-mode t)
(setq tab-width 8)
(setq c-basic-offset 8)
(setq sgml-basic-offset 4)

(setq  python-indent-guess-indent-offset nil)

(add-hook 'php-mode-hook (lambda ()
			   (setq c-basic-offset 8)))
(xterm-mouse-mode 0)
(setq-default select-enable-clipboard t)
(setq-default x-select-enable-primary t)
(setq-default x-select-enable-clipboard t)
(setq-default select-enable-primary t)
(setq-default neo-window-fixed-size nil)
(setq-default neo-theme 'ascii)
(ivy-mode 1)


;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ;;;;; themeing ;;;;; ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

(if (string= window-system "w32")
    (progn
      (set-face-attribute 'default nil :font "Courier New 12")
      )
  )

(when (not nil)
  (global-font-lock-mode 0)
  )

(set-face-attribute 'default nil
                    :family "DejaVu Sans Mono"
                    :height 100)

(defvar my-light-theme t)
(defvar my-dark-theme nil)


(set-face-attribute 'mode-line nil
		    :box nil
		    :foreground "#FFFFFF"
		    :bold nil
		    :background "#000000")  


(setq org-agenda-files '("~"))

;;----------------------------;
;; key bindings               |
;;----------------------------;
(global-unset-key (kbd "C-z"))
(global-set-key (kbd "<f2>") 'neotree)
(global-set-key (kbd "C-x !") 'shell-command)
(global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)
(global-set-key (kbd "C-x p") 'projectile-find-file)
(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "M-[") 'backward-paragraph)
(global-set-key (kbd "M-]") 'forward-paragraph)
(global-set-key (kbd "C-=") 'er/expand-region)

;;----------------------------;
;; projectile                 |
;;----------------------------;
(setq projectile-enable-caching t)
(setq projectile-indexing-method 'native)
(add-hook 'projectile-mode-hook (lambda () 
				  (add-to-list
				   'projectile-globally-ignored-directories
				   "node_modules")
				  (add-to-list
				   'projectile-globally-ignored-directories
				   "vendor")
				  )) 



;;----------------------------;
;; email-stuff                |
;;----------------------------;
(setq send-mail-function (quote smtpmail-send-it))
(setq smtpmail-smtp-server "smtp.gmail.com")
(setq smtpmail-smtp-service 587)



;; gnus
;; No primary server:
(setq gnus-select-method '(nnnil ""))
;; Get email, and store in nnml:
(setq gnus-secondary-select-methods '((nnml "") ))
(add-to-list 'gnus-secondary-select-methods
             '(nnimap "walid7"
		      (nnimap-address "imap.gmail.com")
                      (nnimap-server-port 993)
                      (nnimap-stream ssl)
                      (nnir-search-engine imap)))

(add-to-list 'gnus-secondary-select-methods
	     '(nnimap "smsm"
		      (nnimap-address "imap.gmail.com")
                      (nnimap-server-port 993)
                      (nnimap-stream ssl)
                      (nnir-search-engine imap)))
(setq epg-gpg-program "gpg2")
(setq epa-pinentry-mode 'loopback)





;; (custom-set-variables
;;  '(package-selected-packages
;;    '(green-screen-theme monochrome-theme ivy php-mode geben zenburn-theme vue-mode web-mode typescript-mode scala-mode rtags-xref restclient python-environment projectile pdf-tools org-bullets neotree multiple-cursors markdown-mode lua-mode js2-mode go-mode fzf flycheck expand-region esup emmet-mode elpy eglot clojure-mode))
;; )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(neotree expand-region spacemacs-theme zenburn-theme web-mode typescript-mode scala-mode rtags-xref restclient python-environment projectile php-mode pdf-tools org-bullets multiple-cursors monochrome-theme markdown-mode lua-mode js2-mode ivy green-screen-theme go-mode geben fzf flycheck esup emmet-mode elpy eglot clojure-mode)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
