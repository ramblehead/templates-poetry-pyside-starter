## Hey Emacs, this is -*- coding: utf-8 -*-
<%
  project_name = utils.kebab_case(config["project_name"])
%>\
;; Hey Emacs, this is -*- coding: utf-8 -*-

(require 'lsp-mode)
(require 'lsp-pyright)
(require 'lsp-ruff-lsp)
(require 'blacken)
(require 'flycheck)

;;; ${project_name} common command
;;; /b/{

(defvar ${project_name}/build-buffer-name
  "*${project_name}-build*")

(defun ${project_name}/lint ()
  (interactive)
  (rh-project-compile
   "poetry-run.sh lint"
   ${project_name}/build-buffer-name))

(defun ${project_name}/dev ()
  (interactive)
  (rh-project-compile
   "poetry-run.sh dev"
   ${project_name}/build-buffer-name))

(defun ${project_name}/build ()
  (interactive)
  (rh-project-compile
   "poetry-run.sh build"
   ${project_name}/build-buffer-name))

(defun ${project_name}/start ()
  (interactive)
  (rh-project-compile
   "poetry-run.sh start"
   ${project_name}/build-buffer-name))

(defun ${project_name}/format ()
  (interactive)
  (rh-project-compile
   "poetry-run.sh format"
   ${project_name}/build-buffer-name))

(defun ${project_name}/test ()
  (interactive)
  (rh-project-compile
   "poetry-run.sh test"
   ${project_name}/build-buffer-name))

;;; /b/}

;;; ${project_name}
;;; /b/{

(defun ${project_name}/hydra-define ()
  (defhydra ${project_name}-hydra (:color blue :columns 4)
    "@${project_name} workspace commands"
    ("l" ${project_name}/lint "lint")
    ("d" ${project_name}/dev "dev")
    ("b" ${project_name}/build "build")
    ("s" ${project_name}/start "start")
    ("f" ${project_name}/format "format")
    ("t" ${project_name}/test "test")))

(${project_name}/hydra-define)

(define-minor-mode ${project_name}-mode
  "${project_name} project-specific minor mode."
  :lighter " ${project_name}"
  :keymap (let ((map (make-sparse-keymap)))
            (define-key map (kbd "<f9>") #'${project_name}-hydra/body)
            map))

(add-to-list 'rm-blacklist " ${project_name}")

(defun ${project_name}/lsp-python-deps-providers-path (path)
  (concat (expand-file-name (rh-project-get-root))
          ".venv/bin/"
          path))

(defun ${project_name}/lsp-python-setup ()
  (plist-put
   lsp-deps-providers
   :${project_name}/local-venv
   (list :path #'${project_name}/lsp-python-deps-providers-path))

  (lsp-dependency 'pyright
                  '(:${project_name}/local-venv "pyright-langserver")))

(eval-after-load 'lsp-pyright #'${project_name}/lsp-python-setup)

(defun ${project_name}-setup ()
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

          (blacken-mode 1)

          ;;; /b/}

          (setq-local lsp-enabled-clients '(pyright ruff-lsp))
          (setq-local lsp-before-save-edits nil)
          (setq-local lsp-modeline-diagnostics-enable nil)

          ;; (run-with-idle-timer 0 nil #'lsp)
          (lsp-deferred)))))))

;;; /b/}
