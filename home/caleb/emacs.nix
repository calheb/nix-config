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
      nix-mode

      # git
      magit

      # terminal emulator
      vterm

      # completion popup
      corfu

      # modeline
      doom-modeline
      nerd-icons

      # git gutter
      git-gutter
      git-gutter-fringe
      fringe-helper
    ];

    extraConfig = ''
      ;; Clean up the UI
      (menu-bar-mode -1)
      (tool-bar-mode -1)
      (scroll-bar-mode -1)

      ;; Quality of life
      (setq inhibit-startup-screen t)
      (setq ring-bell-function 'ignore)
      (setq use-short-answers t)          ; y/n instead of yes/no
      (global-display-line-numbers-mode 1)
      (electric-pair-mode 1)              ; auto-close parens/brackets
      (global-auto-revert-mode 1)        ; reload files changed on disk

      ;; Indentation
      (setq-default indent-tabs-mode nil)
      (setq-default tab-width 2)

      ;; Clipboard integration
      (setq select-enable-clipboard t)
      (setq mouse-drag-copy-region t)

      ;; Disable auto-save and backups
      (setq auto-save-default nil)
      (setq make-backup-files nil)
      (setq confirm-kill-processes nil)
      (add-hook 'kill-emacs-hook (lambda () (save-some-buffers t)))

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
      (setq c-default-style "k&r")
      (setq c-basic-offset 4)

      ;; corfu: completion popup
      (global-corfu-mode 1)
      (setq corfu-auto t)
      (setq corfu-auto-delay 0.2)
      (setq corfu-auto-prefix 2)
      (setq corfu-quit-no-match t)

      ;; eglot
      (add-hook 'c-mode-hook 'eglot-ensure)
      (add-hook 'c-mode-hook (lambda ()
                               (add-hook 'before-save-hook #'eglot-format-buffer nil t)))
      (add-hook 'eglot-managed-mode-hook #'eglot-inlay-hints-mode)
      (with-eval-after-load 'eglot
        (add-to-list 'eglot-server-programs
                     '((c-mode c++-mode) . ("clangd"
                                            "--clang-tidy"
                                            "--completion-style=detailed"
                                            "--header-insertion=never"))))

      ;; doom-modeline
      (require 'doom-modeline)
      (doom-modeline-mode 1)

      ;; git-gutter-fringe with custom bitmaps
      (require 'git-gutter-fringe)
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
