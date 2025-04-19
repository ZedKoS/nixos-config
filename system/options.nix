{ lib, ... }:
let
  sessions = [
    "xfce"
    "hyprland"
  ];
  displayManagers = [
    "ly"
    "sddm"
  ];
in
{
  options = with lib; {
    desktop.displayManager = mkOption {
      description = "Which Display Manager to use";
      type = types.enum displayManagers;
      default = builtins.head displayManagers;
    };

    desktop.defaultSession = mkOption {
      description = "Default Desktop Environment or Window Manager";
      type = types.enum sessions;
      default = builtins.head sessions;
    };

    desktop.otherSessions = mkOption {
      description = "Other enabled sessions";
      type = types.listOf (types.enum sessions);
      default = [ ];
    };
  };
}
