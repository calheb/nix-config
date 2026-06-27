#!/usr/bin/env bash
cat > init.el << 'PREAMBLE'
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(dolist (pkg '(vertico orderless marginalia which-key nix-ts-mode magit
               vterm corfu eldoc-box markdown-mode doom-modeline nerd-icons
               git-gutter git-gutter-fringe fringe-helper gruber-darker-theme))
  (unless (package-installed-p pkg)
    (package-install pkg)))
PREAMBLE

nix eval --raw \
  .#nixosConfigurations.lemma.config.home-manager.users.caleb.programs.emacs.extraConfig \
  >> init.el
