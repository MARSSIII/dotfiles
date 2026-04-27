{
  description = "marssiii's nix configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";

  };

  outputs = inputs@{ nix-darwin, home-manager, nix-homebrew, stylix, catppuccin, ... }:
    let
      system = "aarch64-darwin";
      hostname = "marssiii-mac";
      username = "marssiii";
    in
    {
      darwinConfigurations.${hostname} = nix-darwin.lib.darwinSystem {
        inherit system;
        specialArgs = { inherit inputs username hostname; };
        modules = [
          ./modules/darwin.nix
          stylix.darwinModules.stylix

          nix-homebrew.darwinModules.nix-homebrew
          {
            nix-homebrew = {
              enable = true;
              enableRosetta = true;
              user = username;
              autoMigrate = true;
            };
          }

          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "backup";
              extraSpecialArgs = { inherit inputs username system hostname; };
              sharedModules = [
                stylix.homeModules.stylix
                catppuccin.homeModules.catppuccin
              ];
              users.${username} = import ./modules/home.nix;
            };
          }
        ];
      };
    };
}
