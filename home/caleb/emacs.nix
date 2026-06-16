{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs30;

    extraPackages = epkgs: with epkgs; [
      # theme
      gruber-darker-theme

      # better completion UI
      vertico
      orderless
      marginalia

      # which-key: shows available keybindings as you type
      which-key

      # nix syntax
      nix-mode

      # git
      magit

      # terminal emulator
      vterm
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

      ;; Indentation
      (setq-default indent-tabs-mode nil)
      (setq-default tab-width 2)

      ;; Disable auto-save and backups
      (setq auto-save-default nil)
      (setq make-backup-files nil)

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

      ;; eglot (built-in LSP) — start automatically in C files via clangd
      (add-hook 'c-mode-hook 'eglot-ensure)

      ;; vterm
      (setq vterm-max-scrollback 10000)
    '';
  };
}
