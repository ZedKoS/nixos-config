{
  config,
  lib,
  pkgs,
  stylix,
  ...
}: {
  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";

  # Wallpaper
  # stylix.image = null;
  stylix.imageScalingMode = "fill";

  # stylix.cursor = null;

  stylix.polarity = "dark";

  stylix.fonts = rec {
    sizes = {
      applications = 12;
      desktop = 10;
      popups = 10;
      terminal = 12;
    };

    # Nobody likes serif.
    serif = sansSerif;

    sansSerif = {
      package = pkgs.ubuntu_font_family;
      name = "Ubuntu Sans";
    };

    monospace = {
      package = pkgs.nerd-fonts.fira-code;
      name = "Fira Code";
    };

    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };
  };

  # stylix.iconTheme = {
  #   enable = true;
  #   package = pkgs.papirus-icon-theme;
  # };
 
}
