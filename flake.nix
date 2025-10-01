{
  description = "NixOS configuration flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  }: let
    username = "zeta";
    lib = nixpkgs.lib;

    # Helper function that creates a host record
    # Corresponding system nixpkgs gets instantiated
    mkHost = {
      hostname,
      system,
      config ? {},
    }: rec {
      inherit hostname system config;
      pkgs = nixpkgs.legacyPackages.${system};
    };

    hosts = [
      (mkHost {
        hostname = "zeta-asus";
        system = "x86_64-linux";
      })
      (mkHost {
        hostname = "zeta-xps";
        system = "x86_64-linux";
      })
    ];
  in
    # Generate configurations for each host and choose the correct one
    builtins.foldl' lib.recursiveUpdate
    # host-independent config
    {
      devShells."x86_64-linux".default = let
        pkgs = nixpkgs.legacyPackages."x86_64";
      in
        import ./devshell.nix {inherit pkgs;};
    }
    # per-host config
    (
      builtins.map (
        host @ {
          hostname,
          system,
          pkgs,
          ...
        }: let
          commonModules = [
            ./options.nix
            ./hosts/${host.hostname}/config.nix
          ];
        in {
          formatter.${system} = pkgs.alejandra;

          # -- System configuration --
          nixosConfigurations.${hostname} = lib.nixosSystem {
            inherit system;

            specialArgs = {
              inherit username;
              inherit host;
            };

            modules =
              commonModules
              ++ [
                ./hosts/${host.hostname}/hardware-configuration.nix
                ./system
              ];
          };

          # -- Home configuration --
          homeConfigurations."${username}@${hostname}" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            extraSpecialArgs = {
              inherit username;
              inherit host;
            };

            modules =
              commonModules
              ++ [
                ./home
              ];
          };
        }
      )
      hosts
    );
}
