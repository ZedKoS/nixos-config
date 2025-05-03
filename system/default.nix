{
  config,
  lib,
  pkgs,
  stylix,
  username,
  host,
  ...
}: {
  imports = [
    ./hosts/${host.hostname}
    ./modules/locale.nix
    ./modules/login.nix
    ./modules/desktop.nix
  ];

  nix.settings = {
    allowed-users = ["@wheel"];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  nixpkgs.config.allowUnfree = true;

  # Bootloader
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    efiSupport = true;
  };

  stylix.targets.grub.enable = false;

  # Networking
  networking.hostName = host.hostname;
  networking.networkmanager.enable = true;

  # Time zone
  time.timeZone = "Europe/Rome";

  # Enable CUPS to print documents
  services.printing.enable = true;

  # Enable sound
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # User shell and default user configuration
  users.users.${username} = {
    isNormalUser = true;
    initialPassword = username;
    extraGroups = ["wheel" "input"]; # Enable ‘sudo’ for the user.
    packages = [];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  # System-wide packages
  environment.systemPackages = with pkgs; [
    # (Almost) essentials
    efibootmgr
    git
    vim
    wget
    btop
    file

    # Nix utils
    nixd # LSP
    alejandra # Formatter

  ];

  programs.nh.enable = true;

  # System-wide fonts
  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      ubuntu_font_family
      nerd-fonts.fira-code
    ];
  };

  # Services
  services.openssh.enable = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.11"; # Did you read the comment?
}
