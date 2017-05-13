;;; bct-mercury-mode.el

;; Copyright (c) 2017, Brad Contenary

;; Author: Brad Contenary (bctnry@outlook.com)
;; Version: 0.0.1
;; Created: 14 May 2017
;; Keywords: languages

;; This file is not part of GNU Emacs.
;; Distributed under MIT license.

;; Notes:
;; 1. I have learned a lot from xah lee's wonderful turtorial on how to write major
;; modes for langs when making this thing:
;;     http://ergoemacs.org/emacs/elisp_write_major_mode_index.html
;; strongly recommend it.
;;
;; 2. There's still a lot of refinements to do; will finish them after I've learned
;; more about mercury...
;;
;; 3. Key bindings might change in the future.


;; keywords.
(setq bct-mercury-keywords
      '(;; declarations
	"type" "solver type" "pred" "func" "inst" "mode"
	"typeclass" "instance" "pragma" "promise" "initialize" "finalize"
	"mutable" "module" "interface" "implementation"
	"import_module" "use_module" "include_module" "end_module"
	;; type/pred/mode signatures
	"is"
	;; language constructs
	"if" "then" "else"))
(setq bct-mercury-constants
      '(;; these are modes.
	"in" "out" "di" "uo" "ground" "free" "unique" "dead"
	"mostly_unique" "mostly_dead"
	;; these are determinisms
	"det" "semidet"
	"erroneous" "failure"
	"multi" "nondet"
	;; these are special goals
	"true" "fail"
	))

(setq bct-mercury-keywords-regexp (regexp-opt bct-mercury-keywords 'words))
(setq bct-mercury-constants-regexp (regexp-opt bct-mercury-constants 'words))

(setq bct-mercury-font-lock-defaults
      `((,bct-mercury-constants-regexp . (1 font-lock-constant-face))
	(,bct-mercury-keywords-regexp . (1 font-lock-keyword-face))
	))

(defvar bct-mercury-mode-syntax-table nil "Syntax table for mercury mode")
(setq bct-mercury-mode-syntax-table
      (let ((synTable (make-syntax-table)))
	;; comments coloring
	(modify-syntax-entry ?% "<" synTable)
	(modify-syntax-entry ?\n ">" synTable)
	synTable))

;;;; commands
(defun bct-mercury-mode-compile-buffer-single ()
  "Compile the buffer"
  (interactive)
  (cond
   ((string-equal system-type "windows-nt")
    (message "Support for MS Windows is planned for the future."))
   ((string-equal system-type "darwin")
    (message "Support for macOS/darwin is planned for the future."))
   ((string-equal system-type "gnu/linux")
    (progn
      (when (not (buffer-file-name)) (save-buffer))
      (when (buffer-modified-p) (save-buffer))
      (setq-local -fname (buffer-file-name))
      (shell-command (concat "mmc " -fname)))))
  )
(defun bct-mercury-mode-compile-buffer-to-object ()
  "Compile the buffer to object code"
  (interactive)
  (cond
   ((string-equal system-type "windows-nt")
    (message "Support for MS Windows is planned for the future."))
   ((string-equal system-type "darwin")
    (message "Support for macOS/darwin is planned for the future."))
   ((string-equal system-type "gnu/linux")
    (progn
      (when (not (buffer-file-name)) (save-buffer))
      (when (buffer-modified-p) (save-buffer))
      (setq-local -fname (buffer-file-name))
      (shell-command (concat "mmc -c " -fname)))))
  )

(progn
  (setq bct-mercury-mode-map (make-sparse-keymap))
  (define-key bct-mercury-mode-map (kbd "C-c C-c s") 'bct-mercury-mode-compile-buffer-single)
  (define-key bct-mercury-mode-map (kbd "C-c C-c o") 'bct-mercury-mode-compile-buffer-to-object)
  )


(define-derived-mode bct-mercury-mode fundamental-mode "BCT::Mercury"
  "Major mode for editing Mercury source codes"
  (setq-local font-lock-defaults '(bct-mercury-font-lock-defaults))
  (setq-local comment-start "% ")
  (setq-local comment-end "")
  (set-syntax-table bct-mercury-mode-syntax-table)
  )

(setq bct-mercury-constants nil)
(setq bct-mercury-keywords nil)
(setq bct-mercury-keywords-regexp nil)
(setq bct-mercury-constants-regexp nil)

(provide 'bct-mercury-mode)

