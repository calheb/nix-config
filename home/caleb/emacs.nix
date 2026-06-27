{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs30;

    extraPackages = epkgs: with epkgs; [
      gruber-darker-theme

      # better completion UI
      vertico
      orderless
      marginalia

      # shows available keybindings as you type
      which-key

      # nix syntax
      nix-ts-mode

      # git
      magit

      # terminal emulator
      vterm

      # completion popup
      corfu

      # hover docs popup
      eldoc-box
      markdown-mode

      # modeline
      doom-modeline
      nerd-icons

      # git gutter
      git-gutter
      git-gutter-fringe
      fringe-helper

      # tree-sitter grammars
      treesit-grammars.with-all-grammars
    ];

    extraConfig = ''
      ;; Clean up the UI
      (menu-bar-mode -1)
      (tool-bar-mode -1)
      (scroll-bar-mode -1)

      ;; Quality of life
      (setq inhibit-startup-screen t
            ring-bell-function 'ignore
            use-short-answers t            ; y/n instead of yes/no
            select-enable-clipboard t
            mouse-drag-copy-region t
            auto-save-default nil
            make-backup-files nil
            confirm-kill-processes nil)
      (setq-default indent-tabs-mode nil
                    tab-width 2)
      (global-display-line-numbers-mode 1)
      (electric-pair-mode 1)               ; auto-close parens/brackets
      (global-auto-revert-mode 1)          ; reload files changed on disk
      (advice-add 'save-buffers-kill-emacs :before (lambda (&rest _) (save-some-buffers t)))

      ;; 100-column marker
      (setq-default display-fill-column-indicator-column 100)
      (global-display-fill-column-indicator-mode 1)

      ;; Theme
      (load-theme 'gruber-darker :no-confirm)

      ;; Font
      (set-face-attribute 'default nil :family "Iosevka Nerd Font" :height 300)

      ;; Vertico: vertical completion UI in the minibuffer
      (vertico-mode 1)
      (marginalia-mode 1)
      (setq completion-styles '(orderless basic))

      ;; which-key: popup showing what keys do after a prefix
      (which-key-mode 1)

      ;; C style
      (setq c-ts-mode-indent-style 'k&r)
      (setq c-ts-mode-indent-offset 4)

      ;; corfu: completion popup
      (global-corfu-mode 1)
      (setq corfu-auto t)
      (setq corfu-auto-delay 0.2)
      (setq corfu-auto-prefix 2)
      (setq corfu-quit-no-match t)

      ;; eldoc-box: floating hover popup
      (add-hook 'eglot-managed-mode-hook #'eldoc-box-hover-mode)
      (defun my/eldoc-box-position (width _height)
        (let* ((edges (window-body-pixel-edges))
               (body-left (nth 0 edges))
               (body-top (nth 1 edges))
               (col-100-x (+ body-left (* (+ 100 (line-number-display-width)) (frame-char-width)))))
          (pcase-let ((`(,_ ,_ ,offset-t) eldoc-box-offset))
            (cons (+ col-100-x (* 4 offset-t) 8)
                  (+ body-top offset-t)))))
      (setq eldoc-box-position-function #'my/eldoc-box-position)
      (defun my/eldoc-box-cycle ()
        (interactive)
        (if eldoc-box-hover-at-point-mode
            (progn (eldoc-box-hover-at-point-mode -1)
                   (eldoc-box-hover-mode 1))
          (progn (eldoc-box-hover-mode -1)
                 (eldoc-box-hover-at-point-mode 1))))
      (global-set-key (kbd "<f8>") #'my/eldoc-box-cycle)

      ;; woman under cursor
      (global-set-key (kbd "C-c K")
                      (lambda ()
                        (interactive)
                        (woman (thing-at-point 'symbol t))))

      ;; tree-sitter: remap major modes to their ts variants
      (setq major-mode-remap-alist
            '((c-mode      . c-ts-mode)
              (c++-mode    . c++-ts-mode)
              (sh-mode     . bash-ts-mode)
              (python-mode . python-ts-mode)
              (nix-mode    . nix-ts-mode)))

      ;; eglot
      (add-hook 'c-ts-mode-hook 'eglot-ensure)
      (add-hook 'c-ts-mode-hook (lambda ()
                                  (add-hook 'before-save-hook #'eglot-format-buffer nil t)))
      (add-hook 'eglot-managed-mode-hook #'eglot-inlay-hints-mode)
      (with-eval-after-load 'eglot
        (add-to-list 'eglot-server-programs
                     '((c-ts-mode c++-ts-mode) . ("clangd"
                                                   "--clang-tidy"
                                                   "--completion-style=detailed"
                                                   "--header-insertion=never"))))

      ;; doom-modeline
      (doom-modeline-mode 1)
      (global-set-key (kbd "<f9>") #'doom-modeline-mode)

      ;; git-gutter-fringe with custom bitmaps
      (require 'fringe-helper)
      (global-git-gutter-mode 1)
      (fringe-helper-define 'git-gutter-fr:added '(center repeated)
        "XXXXXXXX"
        "XXXXXXXX"
        "XXXXXXXX"
        "XXXXXXXX")
      (fringe-helper-define 'git-gutter-fr:modified '(center repeated)
        "XXXXXXXX"
        "XXXXXXXX"
        "XXXXXXXX"
        "XXXXXXXX")
      (fringe-helper-define 'git-gutter-fr:deleted 'bottom
        "X......."
        "XX......"
        "XXX....."
        "XXXX...."
        "XXXXX..."
        "XXXXXX.."
        "XXXXXXX."
        "XXXXXXXX"
        "XXXXXXX."
        "XXXXXX.."
        "XXXXX..."
        "XXXX...."
        "XXX....."
        "XX......"
        "X.......")

      ;; vterm
      (setq vterm-max-scrollback 10000)
    '';
  };
}
