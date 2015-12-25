;; -----------------------------------------------------------------------------
;; DISPLAY ERROR TRACE IF ANY
;;-----------------------------------------------------------------------------
(setq debug-on-error t)
(setq stack-trace-on-error t)
(global-unset-key (kbd "C-z"))


;; -----------------------------------------------------------------------------
;; ALL THE EMACS REPOSITORITES TO LIST PACKAGES
;; -----------------------------------------------------------------------------
(require 'package)
(add-to-list 'package-archives '("elpa" . "http://tromey.com/elpa/"))
(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))

(package-initialize)
;; load necessary packages if not installed
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar my-packages '(;; utility packages
		      ace-jump-buffer
		      ace-jump-mode
		      expand-region
		      powerline
		      projectile helm helm-projectile grizzl
		      smooth-scroll
		      undo-tree
		      yasnippet
		      auto-complete
		      company
		      color-theme
		      flycheck flymake
		      yaml-mode
		      markdown-mode
                      exec-path-from-shell
		      ;; language packages
		      clojure-mode clojure-cheatsheet cider
		      rainbow-delimiters paredit
		      php-mode
		      js2-mode angular-snippets js-comint web-mode
		      css-mode
		      json-mode

		      ;; ruby and rails setup
		      rinari web-mode robe inf-ruby enh-ruby-mode
		      rvm yari ruby-block haml-mode bundler slim-mode
		      ;; c programming
		      ctags ctags-update c-eldoc
		      ;; erlang
		      edts erlang
		      ;; elixir
		      elixir-mode elixir-mix flymake-elixir
		      jsx-mode alchemist
		      ))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; cedet needs to be loaded before anything else
;; x(load-file "~/.emacs.d/cedet-conf.el")
(load-file "~/.emacs.d/custom.el")

;; -----------------------------------------------------------------------------
;; MAIN LOAD PATH
;; -----------------------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/")

;; -----------------------------------------------------------------------------
;; PACKAGES THAT AREN'T CUSTOMIZED
;; -----------------------------------------------------------------------------
(require 'powerline)
(add-to-list 'load-path "~/.emacs.d/smooth-scrolling.el")


;; -----------------------------------------------------------------------------
;; SLIME
;; -----------------------------------------------------------------------------
;; (add-to-list 'load-path "/opt/local/share/emacs/site-lisp/slime")
;; (require 'slime-autoloads)
;; (setq slime-lisp-implementations
;;      `((sbcl ("/opt/local/bin/sbcl"))
;;        (abcl ("/opt/local/bin/abcl"))
;;        (clisp ("/opt/local/bin/clisp"))))
;; (slime-setup  '(slime-repl slime-asdf slime-fancy slime-banner))

;;; Lisp (SLIME) interaction
(show-paren-mode 1)
(add-hook 'lisp-mode-hook '(lambda ()
			     (local-set-key (kbd "RET") 'newline-and-indent)))


;; -----------------------------------------------------------------------------
;; FLAGS FOR EMACS
;; -----------------------------------------------------------------------------
;(yas-global-mode)

(delete-selection-mode t) ;; highlight a word and start typing, and it will delete the word and put your typed characters in it's place. highly annoying if not there.
(setq make-backup-files nil) ;; disable backup files
					; text decoration
(require 'font-lock)
(setq font-lock-maximum-decoration t)
(global-font-lock-mode t)
(global-hi-lock-mode nil)
(setq jit-lock-contextually t)
(setq jit-lock-stealth-verbose t)

(size-indication-mode t) ;; if there is size information associated with text, change the text size to reflect it
(require 'paren) ; highlight parentheses when the cursor is next to them
(show-paren-mode t)
(setq inhibit-startup-message t) ;; Disable the welcome message
(setq frame-title-format "emacs - %b") ;; Format the title-bar to always include the buffer name
;;(mouse-wheel-mode t) ;; Make the mouse wheel scroll Emacs
(setq require-final-newline t) ;; Always end a file with a newline
(setq next-line-add-newlines nil) ;; Stop emacs from arbitrarily adding lines to
;; the end of a file when the cursor is moved past the end of it:
(toggle-scroll-bar -1)
(setq visible-bell t) ;; Flash instead of that annoying bell
(if (> emacs-major-version 20) ;; Remove icons toolbar
    (tool-bar-mode -1))
(menu-bar-mode -1)
(fset 'yes-or-no-p 'y-or-n-p) ;; Use y or n instead of yes or not
(line-number-mode t) ;; show the current line and column numbers in the stats bar as well
(column-number-mode t)
(setq c-default-style "linux" c-basic-offset 4)
(global-auto-revert-mode t) ;; reload pages once changed on disk
(global-undo-tree-mode t)
(add-hook 'before-save-hook 'delete-trailing-whitespace) ;; deletes all whitespace that isn't needed.
(setq max-specpdl-size 1000)
(setq max-lisp-eval-depth 1000)
(setq-default fill-column 80)
(add-hook 'prog-mode-hook (lambda()(auto-fill-mode)))


;; -----------------------------------------------------------------------------
;; WORD WRAP
;; -----------------------------------------------------------------------------
(global-visual-line-mode t)
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook
	  '(lambda() (set-fill-column 120)))


;; -----------------------------------------------------------------------------
;; EXPAND REGION
;; -----------------------------------------------------------------------------
(require 'expand-region)
(global-set-key (kbd "C-@") 'er/expand-region)


;; -----------------------------------------------------------------------------
;; ACE JUMP MODE
;; -----------------------------------------------------------------------------
(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)


;; -----------------------------------------------------------------------------
;; CLOJURE
;; -----------------------------------------------------------------------------
(require 'clojure-mode)
(require 'cider)
;(require 'rainbow-delimiters)
;(require  'paredit)
(add-hook 'clojure-mode-hook 'paredit-mode)
(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
(setq nrepl-hide-special-buffers t)
(add-hook 'clojure-mode-hook 'turn-on-eldoc-mode)
(setq cider-repl-tab-command 'indent-for-tab-command)
(setq nrepl-buffer-name-separator "-")
(setq nrepl-buffer-name-show-port t)
(setq cider-repl-use-clojure-font-lock t)
(add-hook 'cider-repl-mode-hook 'subword-mode)
(add-hook 'cider-repl-mode-hook 'paredit-mode)
(add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)
(add-to-list 'auto-mode-alist '("\\.cljs$" . clojure-mode))

;; -----------------------------------------------------------------------------
;; IDO MODE
;; -----------------------------------------------------------------------------
;;(require 'flx-ido)
(ido-mode 1)
(ido-everywhere 1)
(setq ido-use-faces nil)


;; -----------------------------------------------------------------------------
;; PROJECTILE
;; -----------------------------------------------------------------------------
(projectile-global-mode)
(setq projectile-completion-system 'grizzl)
(global-set-key (kbd "C-x C-h") 'helm-projectile)
(setq projectile-indexing-method 'native)
(setq projectile-enable-caching t)


;; -----------------------------------------------------------------------------
;; PYTHON SETTINGS FROM https://github.com/gabrielelanaro/emacs-for-python in emacs.d
;; -----------------------------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/emacs-for-python/")
(require 'epy-setup)      ;; It will setup other loads, it is required!
(require 'epy-python)     ;; If you want the python facilities [optional]
(require 'epy-completion) ;; If you want the autocompletion settings [optional]
(require 'epy-editing)    ;; For configurations related to editing [optional]
(setq skeleton-pair nil)
(epy-django-snippets)
(setq skeleton-pair nil)
(add-to-list 'ac-modes 'web-mode)


;; -----------------------------------------------------------------------------
;; ORG-MODE
;; -----------------------------------------------------------------------------
;; requires configurations and dependencies of tex files installed
;; download and build org. Elpa distribution almost always gives bugs.
(add-to-list 'load-path "~/.emacs.d/org-mode/lisp")
(add-to-list 'load-path "~/.emacs.d/org-mode/contrib/lisp" t)

(require 'org)
(require 'ox-latex)
(require 'ox-md)
(require 'ox-odt)
(require 'ox-html)
(require 'ox-ascii)
(require 'ox-deck)
(require 'ox-beamer)
(require 'ox-freemind)
(require 'ox-confluence)

(setq org-export-dispatch-use-expert-ui nil
      org-latex-pdf-process                ; for regular export
      '("/opt/local/bin/xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
	"/opt/local/bin/xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
	"/opt/local/bin/xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

(add-to-list 'org-latex-classes
	     '("myarticle"
               "\\documentclass[11pt,a4paper]{article}
                \\usepackage{minted}
                \\usemintedstyle{emacs}
                \\newminted{common-lisp}{fontsize=10}
                \\usepackage[T1]{fontenc}
                \\usepackage[hidelinks]{hyperref}
                \\usepackage{fontspec}
                \\usepackage{graphicx}
                \\defaultfontfeatures{Mapping=tex-text}
                \\setromanfont{Gentium}
                \\setromanfont [BoldFont={Gentium Basic Bold},
                  ItalicFont={Gentium Basic Italic}]{Gentium Basic}
                \\setsansfont{Charis SIL}
                \\setmonofont[Scale=0.8]{DejaVu Sans Mono}
                \\usepackage{geometry}
                \\geometry{a4paper, textwidth=6.5in, textheight=10in,
                  marginparsep=7pt, marginparwidth=.6in}
                \\pagestyle{empty}
                \\title{}
                  [NO-DEFAULT-PACKAGES]
                  [NO-PACKAGES]"
	       ("\\section*{%s}" . "\\section*{%s}") ;; asterisk prevents numbering
	       ("\\subsection*{%s}" . "\\subsection*{%s}")
	       ("\\subsubsection*{%s}" . "\\subsubsection*{%s}")
	       ("\\paragraph*{%s}" . "\\paragraph*{%s}")
	       ("\\subparagraph*{%s}" . "\\subparagraph*{%s}")))


(setq org-export-latex-listings 'minted)
(add-to-list 'org-latex-packages-alist '("" "minted"))
(setq org-export-latex-custom-lang-environments
      '(
	(emacs-lisp "common-lispcode")
	))
(setq org-export-latex-minted-options
      '(("frame" "lines")
	("fontsize" "\\scriptsize")
	("linenos" "")
	))
;; -----------------------------------------------------------------------------
;; CURSOR
;; -----------------------------------------------------------------------------
;; highlight the current line
;; (require 'highlight-current-line)
(global-hl-line-mode t)
(set-face-background hl-line-face "gray13")
;; don't blink the cursor
(blink-cursor-mode nil)
;; make sure transient mark mode is enabled (it should be by default,
;; but just in case)
(transient-mark-mode t)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line ((t (:background "#171717" :foreground "grey75" :box (:line-width -1 :style released-button)))))
 '(mode-line-inactive ((t (:inherit mode-line :background "#171717" :foreground "grey75" :box (:line-width -1 :color "grey40") :weight light)))))


;; --------------------------------------------------------------------
;; RUBY ON RAILS
;; --------------------------------------------------------------------

(setq rsense-home "/opt/rsense-0.3")
(add-to-list 'load-path (concat rsense-home "/etc"))
(setq load-path (cons (expand-file-name "~/.emacs.d/emacs-rails-reloaded") load-path))

;; (require 'rsense)
(require 'rinari)
(require 'rails-autoload)
(require 'ruby-mode)
(require 'ruby-block)
(require 'robe)
(require 'rvm)
(rvm-use-default)
(require 'haml-mode)
(require 'bundler)
(add-to-list 'ac-modes 'enh-ruby-mode)

(add-to-list 'auto-mode-alist '("Jbuilder" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("rake" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile" . enh-ruby-mode))

(defun rails-generate-tags(a)
  (interactive "Da?")
  (shell-command (format "bash -c %s"
			 (concat a
				 " ctags-exuberant -a -e -f "
				 "TAGS --tag-relative -R app "
				 "lib vendor"))))

(add-hook 'rinari 'rails-generate-tags)
;; Use this to generate TAGS
;; ctags-exuberant -a -e -f TAGS --tag-relative -R app lib vendor
(setq rinari-tags-file-name "TAGS")

(add-hook 'enh-ruby-mode-hook '(lambda ()
				 (electric-indent-mode)))
(add-hook 'enh-ruby-mode-hook 'inf-ruby-minor-mode)
(add-hook 'enh-ruby-mode-hook 'robe-mode)

(push 'ac-source-robe ac-sources)

(defun ruby-interpolate ()
  "In double quoted string, convert # to #{}"
  (interactive)
  (insert "#")
  (when (and
	 (looking-back "\".*")
	 (looking-at ".*\""))
    (insert "{}")
    (backward-char 1)))

(defun ruby-open-spec-other-buffer ()
  (interactive)
  (when (featurep 'rspec-mode)
    (let ((source-buffer (current-buffer))
	  (other-buffer (progn
			  (rspec-toggle-spec-and-target)
			  (current-buffer))))
      (switch-to-buffer source-buffer)
      (pop-to-buffer other-buffer))))


(eval-after-load 'enh-ruby-mode
  '(progn
     (define-key ruby-mode-map (kbd "C-c ,") 'ruby-open-spec-other-buffer)
     (define-key ruby-mode-map (kbd "#") 'ruby-interpolate)
     ))

;; set C-h R to help
(define-key 'help-command "R" 'yari)

;; set default ruby shell to rbenv global
(global-rbenv-mode)

;; block mode for ruby
(setq ruby-block-delay 0)
(setq ruby-block-highlight-toggle t)
(ruby-block-mode t)

;; auto-indent haml templates
(add-hook 'haml-mode-hook
	  (lambda ()
	    (setq indent-tabs-mode nil)
	    (define-key haml-mode-map "\C-m" 'newline-and-indent)))
(add-to-list 'auto-mode-alist '("\\.slim\\'" . slim-mode))

;; REPL driven development using PRY
;(add-to-list 'load-path "~/.emacs.d/ruby-dev.el" )
;(autoload 'turn-on-ruby-dev "ruby-dev" nil t)
;(add-hook 'enh-ruby-mode-hook 'turn-on-ruby-dev)


;; ------------------------------------------------------------------------
;; WEB-MODE
;; ------------------------------------------------------------------------
;; duplicate html template support for yasnippets to support web mode too.
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

(setq web-mode-markup-indent-offset 2)
(setq web-mode-css-indent-offset 2)
(setq web-mode-code-indent-offset 2)


;; -----------------------------------------------------------------------------
;; C PROGRAMMING
;; -----------------------------------------------------------------------------

(require 'ctags)
(require 'ctags-update)
(require 'c-eldoc)
(require 'disaster)

(add-hook 'c-mode 'turn-on-eldoc-mode)
(define-key c-mode-base-map (kbd "C-c a") 'disaster)

(setq path-to-ctags "/opt/local/bin/ctags") ;; <- ctags path
(defun create-tags (dir-name)
  "Create tags file."
  (interactive "DDirectory: ")
  (shell-command
   (format "etags -f %s -R %s/*" path-to-ctags (directory-file-name dir-name))))


(defun my-move-function-up ()
  "Move current function up."
  (interactive)
  (save-excursion
    (c-mark-function)
    (let ((fun-beg (point))
	  (fun-end (mark)))
      (transpose-regions (progn
			   (c-beginning-of-defun 1)
			   (point))
			 (progn
			   (c-end-of-defun 1)
			   (point))
			 fun-beg fun-end))))

(defun my-move-function-down ()
  "Move current function down."
  (interactive)
  (save-excursion
    (c-mark-function)
    (let ((fun-beg (point))
	  (fun-end (mark)))
      (transpose-regions fun-beg fun-end
			 (progn
			   (c-beginning-of-defun -1)
			   (point))
			 (progn
			   (c-end-of-defun 1)
			   (point))))))

(add-hook 'c-mode-hook '(lambda ()
			  (local-set-key (kbd "C-c C-f C-u") 'my-move-function-up)
			  (local-set-key (kbd "C-c C-f C-d") 'my-move-function-down)
			  ))

(add-hook 'c-mode-hook
	  '(lambda ()
	     (add-to-list
	      'ac-omni-completion-sources
	      (cons "\\." '(ac-source-semantic)))
	     (add-to-list
	      'ac-omni-completion-sources
	      (cons "->" '(ac-source-semantic)))
	     (setq ac-sources
		   '(ac-source-semantic
		     ac-source-yasnippet))))

;; -----------------------------------------------------------------------------
;; THEME
;; -----------------------------------------------------------------------------

;; font is set via guake terminal hence not mentioned in the theme(Fira Mono)

(set-face-background 'ac-candidate-face "lightgray")
(set-face-underline 'ac-candidate-face "darkgray")
(set-face-background 'ac-selection-face "steelblue")

(require 'color-theme)
(color-theme-initialize)
(setq color-theme-is-global t)
(load-file "~/.emacs.d/color-theme-myrailscasts.el")
(color-theme-myrailscasts)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes (quote ("246a51f19b632c27d7071877ea99805d4f8131b0ff7acb8a607d4fd1c101e163" default)))
 '(edts-man-root "/Users/anurag/.emacs.d/edts/doc/17.0")
 '(fill-column 80)
 '(indent-tabs-mode nil)
 '(js2-basic-offset 2)
 '(org-export-backends (quote (ascii beamer latex md odt confluence deck freemind)))
 '(org-support-shift-select (quote always))
 '(scheme-program-name "petite")
 '(send-mail-function (quote smtpmail-send-it))
 '(shift-select-mode t))

(defun disable-magit-highlight-in-buffer ()
  (face-remap-add-relative 'magit-item-highlight '()))
(add-hook 'magit-status-mode-hook 'disable-magit-highlight-in-buffer)


;; Petite Scheme
(setq auto-mode-alist (cons '("\\.scm" . scheme-mode) auto-mode-alist))
(font-lock-add-keywords 'scheme-mode
                        '(("unless" . font-lock-keyword-face)))

(global-auto-complete-mode 1)
;(set-default-font "-apple-source code pro-medium-r-normal--22-130-72-72-m-130-iso10646-1")
(set-default-font "-apple-Source_Code_Pro-medium-normal-normal-*-*-*-*-*-m-0-iso10646-1")
;; -----------------------------------------------------------------------------
;; JAVASCRIPT
;; -----------------------------------------------------------------------------
(add-to-list 'auto-mode-alist '("js" . js2-mode))
(require 'js-comint)
;; Use node as our repl
(setq inferior-js-program-command "node")

(setq inferior-js-mode-hook
      (lambda ()
	(ansi-color-for-comint-mode-on)
	(add-to-list 'comint-preoutput-filter-functions
		     (lambda (output)
		       (replace-regexp-in-string
			".*1G\.\.\..*5G" "..."
			(replace-regexp-in-string ".*1G.*3G" "&gt;" output))))))


(put 'narrow-to-region 'disabled nil)

(set-display-table-slot standard-display-table
                        'vertical-border (make-glyph-code 0000))

(add-to-list 'auto-mode-alist '("\\.jsx$" . js2-mode))
(require 'flycheck)

(add-hook 'after-init-hook #'global-flycheck-mode)
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(javascript-jshint)))

;; use eslint with web-mode for jsx files
;;(flycheck-add-mode 'javascript-eslint 'web-mode)
;; adjust indents for web-mode to 2 spaces
(defun my-web-mode-hook ()
  "Hooks for Web mode. Adjust indents"
  ;;; http://web-mode.org/
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))
(add-hook 'web-mode-hook  'my-web-mode-hook)
(add-hook 'js2-mode-hook  'my-web-mode-hook)
(add-hook 'jsx-mode-hook  'my-web-mode-hook)
;; disable json-jsonlist checking for json files
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(json-jsonlist)))

;; https://github.com/purcell/exec-path-from-shell
;; only need exec-path-from-shell on OSX
;; this hopefully sets up path and other vars better
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; -----------------------------------------------------------------------------
;; DOCKERFILE
;; -----------------------------------------------------------------------------
(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

;; -----------------------------------------------------------------------------
;; ERLANG
;; -----------------------------------------------------------------------------
;(add-hook 'after-init-hook 'my-after-init-hook)
;(defun my-after-init-hook ()
;  (require 'edts-start))
(add-to-list 'auto-mode-alist '("\\.erl\\'" . erlang-mode))
(add-to-list 'ac-modes 'erlang-mode)

;; -----------------------------------------------------------------------------
;; ELIXIR
;; -----------------------------------------------------------------------------
(require 'alchemist)
(alchemist-mode 1)
(add-to-list 'ac-modes 'elixir-mode)
(add-hook 'elixir-mode-hook '(lambda ()
			       (electric-indent-mode)))
(add-hook 'elixir-mode-hook '(lambda ()
			       (ruby-block-mode)))

;; ReactJS
(require 'jsx-mode)
;; (add-to-list 'auto-mode-alist '("\\.jsx\\'" . jsx-mode))
;; (require 'flycheck)
;; (flycheck-define-checker jsxhint-checker
;;   "A JSX syntax and style checker based on JSXHint."

;;   :command ("jsxhint" source)
;;   :error-patterns
;;   ((error line-start (1+ nonl) ": line " line ", col " column ", " (message) line-end))
;;   :modes (jsx-mode))
;; (add-hook 'jsx-mode-hook (lambda ()
;;                           (flycheck-select-checker 'jsxhint-checker)
;;                           (flycheck-mode)))

(add-hook 'jsx-mode-hook
          (lambda () (auto-complete-mode 1)))

;; -----------------------------------------------------------------------------
;; OCTAVE
;; -----------------------------------------------------------------------------
(autoload 'octave-mode "octave-mod" nil t)
(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))
(add-hook 'octave-mode-hook
          (lambda ()
            (abbrev-mode 1)
            (auto-fill-mode 1)
            (if (eq window-system 'x)
                (font-lock-mode 1))))
