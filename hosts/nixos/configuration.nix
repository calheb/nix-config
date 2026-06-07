# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-c80b3b9f-f84f-41ee-826a-adc6aa6a626d".device = "/dev/disk/by-uuid/c80b3b9f-f84f-41ee-826a-adc6aa6a626d";
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # services.displayManager.gdm.enable = true;
  # services.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  services.mullvad-vpn.enable = true;

  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.caleb = {
    isNormalUser = true;
    description = "caleb";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      #  thunderbird
    ];
  };

  # VirtualBox host configuration
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  users.extraGroups.vboxusers.members = [ "caleb" ];

  # Install firefox.
  programs.firefox.enable = true;

  programs.hyprland = {
    enable = true;
    withUWSM = true; # launch via UWSM (proper start-hyprland wrapper + systemd session)
    xwayland.enable = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session --sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions:${config.services.displayManager.sessionData.desktops}/share/xsessions";
        user = "greeter";
      };
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    firefox
    nautilus # file manager
    waybar
    wofi
    mako
    alacritty
    bibata-cursors
    keepassxc
    signal-desktop
    discord
    vscode
    hyprpaper # wallpaper renderer
    pavucontrol # pulse audio GUI
    godot
    nodejs
    goxlr-utility
    gimp
    grimblast # screenshot utility
    fastfetch
    git
    starship
    mullvad
    qbittorrent
    tree
    ghostty
    xournalpp
    libreoffice
    spotify
    unzip

    # LSPs
    lua-language-server
    clang-tools # clangd
    typescript-language-server
    vscode-langservers-extracted # cssls, html, jsonls
    bash-language-server
    haskell-language-server
    pyright
    nixd
    omnisharp-roslyn

    # Formatters
    stylua
    prettier
    shfmt
    haskellPackages.fourmolu
    python3Packages.black
    nixpkgs-fmt
    csharpier
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.adwaita-mono
    nerd-fonts.dejavu-sans-mono
    nerd-fonts.droid-sans-mono
    nerd-fonts.fira-code
    nerd-fonts.geist-mono
    nerd-fonts.hasklug
    nerd-fonts.inconsolata
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term
    nerd-fonts.jetbrains-mono
    nerd-fonts.lilex
    nerd-fonts.monoid
    nerd-fonts.mononoki
    nerd-fonts.roboto-mono
    nerd-fonts.victor-mono
  ];

  environment.sessionVariables = {
    GTK_THEME = "Adwaita:dark";
    XCURSOR_THEME = "Bibata-Modern-Classic";
    XCURSOR_SIZE = "24";
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

}
