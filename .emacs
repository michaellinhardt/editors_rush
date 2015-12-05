
; vrai tabulation au lieux de espace
(setq-default c-basic-offset 8
	tab-width 8
	indent-tabs-mode t)

; auto retour a la ligne sur certain caractere (accolade compris)
(add-hook 'c-mode-common-hook '(lambda () (c-toggle-auto-state 1)))

; auto indentation avec la touche ENTER
(add-hook 'lisp-mode-hook '(lambda ()
(local-set-key (kbd "RET") 'newline-and-indent)))

; raccourci pour highlight colone curseur (script vline et col-highlight)

; raccourcis clavier
(global-set-key (kbd "C-x œ") 'global-blank-mode)

; configure le dossier ou charger les script .el
(add-to-list 'load-path "/home/nestoyeur/.emacs.d/plugins/")

; autopair.el -> le charge dans tout les buffer (global-mode)
(require 'autopair)
(autopair-global-mode)

; whitespace.el
;(require 'whitespace)
;(setq whitespace-style
;	'(empty lines-tail tabs tab-mark trailing))
;(add-hook 'global-whitespace-mode-hook)

; highlight-chars.el
(require 'highlight-chars)
(require 'blank-mode)
(add-hook 'blank-load-hook)

; les deux script necessaire pour highlight la colone du curseur
(require 'vline)
(require 'col-highlight)

; active les backup et les enregistrer ~/.emacs.d
(setq make-backup-files t)
(setq backup-directory-alist `(("." . "~/.emacs.d")))
