{ ... }:
{
  imports = [ ./hardware-configuration.nix ];

  config = {
    desktop.displayManager = "ly";
    desktop.defaultSession = "xfce";
    desktop.otherSessions = [
      "xfce"
      "plasma6"
      "hyprland"
    ];
  };
}
