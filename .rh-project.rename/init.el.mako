;; -*- coding: utf-8 -*-

(require 'lsp-mode)
(require 'lsp-pyright)
(require 'lsp-ruff-lsp)
(require 'blacken)
(require 'flycheck)

;;; my-qt-app common command
;;; /b/{

(defvar my-qt-app/build-buffer-name
  "*my-qt-app-build*")

(defun my-qt-app/lint ()
  (interactive)
  (rh-project-compile
   "lint.sh"
   my-qt-app/build-buffer-name))

;;; /b/}

;;; my-qt-app
;;; /b/{

(defun my-qt-app/hydra-define ()
  (defhydra my-qt-app-hydra (:color blue :columns 5)
    "@my-qt-app workspace commands"
    ("l" my-qt-app/lint "lint")))

(my-qt-app/hydra-define)

(define-minor-mode my-qt-app-mode
  "my-qt-app project-specific minor mode."
  :lighter " my-qt-app"
  :keymap (let ((map (make-sparse-keymap)))
            (define-key map (kbd "<f9>") #'my-qt-app-hydra/body)
            map))

(add-to-list 'rm-blacklist " my-qt-app")

(defun my-qt-app/lsp-python-deps-providers-path (path)
  (concat (expand-file-name (rh-project-get-root))
          ".venv/bin/"
          path))

(defun my-qt-app/lsp-python-setup ()
  (plist-put
   lsp-deps-providers
   :my-qt-app/local-venv
   (list :path #'my-qt-app/lsp-python-deps-providers-path))

  (lsp-dependency 'pyright
                  '(:my-qt-app/local-venv "pyright-langserver")))

(eval-after-load 'lsp-pyright #'my-qt-app/lsp-python-setup)

(defun my-qt-app-setup ()
  (when buffer-file-name
    (let ((project-root (expand-file-name (rh-project-get-root)))
          file-rpath ext-js)
      (when project-root
        (setq file-rpath (expand-file-name buffer-file-name project-root))
        (cond
         ((or (setq ext-js (string-match-p
                            (concat "\\.py\\'\\|\\.pyi\\'") file-rpath))
              (string-match-p "^#!.*python"
                              (or (save-excursion
                                    (goto-char (point-min))
                                    (thing-at-point 'line t))
                                  "")))

          ;;; /b/; pyright-lsp config
          ;;; /b/{

          (setq-local lsp-pyright-prefer-remote-env nil)
          (setq-local lsp-pyright-python-executable-cmd
                      (file-name-concat project-root ".venv/bin/python"))
          (setq-local lsp-pyright-venv-path
                      (file-name-concat project-root ".venv"))
          ;; (setq-local lsp-pyright-python-executable-cmd "poetry run python")
          ;; (setq-local lsp-pyright-langserver-command-args
          ;;             `(,(file-name-concat project-root ".venv/bin/pyright")
          ;;               "--stdio"))
          ;; (setq-local lsp-pyright-venv-directory
          ;;             (file-name-concat project-root ".venv"))

          ;;; /b/}

          ;;; /b/; ruff-lsp config
          ;;; /b/{

          (setq-local lsp-ruff-lsp-server-command
                      `(,(file-name-concat project-root ".venv/bin/ruff-lsp")))
          (setq-local lsp-ruff-lsp-python-path
                      (file-name-concat project-root ".venv/bin/python"))
          (setq-local lsp-ruff-lsp-ruff-path
                      `[,(file-name-concat project-root ".venv/bin/ruff")])

          ;;; /b/}

          ;;; /b/; Python black
          ;;; /b/{

          (setq-local blacken-executable
                      (file-name-concat project-root ".venv/bin/black"))

          ;;; /b/}

          (setq-local lsp-enabled-clients '(pyright ruff-lsp))
          (setq-local lsp-before-save-edits nil)
          (setq-local lsp-modeline-diagnostics-enable nil)

          (blacken-mode 1)
          ;; (run-with-idle-timer 0 nil #'lsp)
          (lsp-deferred)))))))

;;; /b/}
