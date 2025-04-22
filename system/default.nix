{
  config,
  lib,
  pkgs,
  username,
  host,
  ...
}:

{
  imports = [
    ./options.nix
    ./hosts/${host.hostname}
    ./locale.nix
    ./login.nix
    ./desktop.nix
  ];

  nix.settings = {
    allowed-users = [ "@wheel" ];
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

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.${username} = {
    isNormalUser = true;
    initialPassword = username;
    extraGroups = [ "wheel" "input" ]; # Enable ‘sudo’ for the user.
    packages = [];
  };

  environment.systemPackages = with pkgs; [
    # (Almost) essentials
    efibootmgr
    git
    vim
    wget
    btop

    # Nix utils
    nil

    # Other
    chezmoi
  ];

  fonts = {
    enableDefaultPackages = true;

    packages = with pkgs; [
      ubuntu_font_family
      nerd-fonts.fira-code
    ];
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
