; vrai tabulation au lieux de espace
(setq-default c-basic-offset 8
	tab-width 8
	indent-tabs-mode t)

; auto retour a la ligne sur certain caractere (accolade compris)
(add-hook 'c-mode-common-hook '(lambda () (c-toggle-auto-state 1)))

; auto indentation avec la touche ENTER
(add-hook 'lisp-mode-hook '(lambda ()
(local-set-key (kbd "RET") 'newline-and-indent)))

; configure le dossier ou charger les script .el
(add-to-list 'load-path "~/.emacs.d/plugins")

; autopair.el -> le charge dans tout les buffer (global-mode)
(require 'autopair)
(autopair-global-mode)

; active les backup et les enregistrer ~/.emacs.d
(setq make-backup-files t)
(setq backup-directory-alist `(("." . "~/.emacs.d")))

; highlight whitespace
(add-hook 'c-mode-hook
	(lambda() (highlight-regexp "  " "hi-yellow")
		))
(setq show-trailing-whitespace t)
(setq-default show-trailing-whitespace t)

; affiche numero colone
(column-number-mode t)
