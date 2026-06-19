{
  description = "Nix flake for system config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    nixpkgs-old.url = "nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    agenix.url = "github:ryantm/agenix";
    hyprland.url = "github:hyprwm/Hyprland";
    niri.url = "github:sodiboo/niri-flake";
    stylix = {
      url = "github:nix-community/stylix/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    thinknix-wallpaper.url = "github:zebreus/nixos-dark-wallpaper";
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      nixpkgs-old,
      home-manager,
      niri,
      stylix,
      ...
    }@inputs:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
        };
      };
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };

      pkgs-old = import nixpkgs-old {
        inherit system;
        config.allowUnfree = true;
      };

      lib = nixpkgs.lib;
    in
    {

      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
          modules = [
            ./system/configuration.nix
            stylix.nixosModules.stylix
          ];
          specialArgs = {
            inherit inputs;
          };
        };
      };

      homeConfigurations.rkc = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./users/rkc/home.nix
          niri.homeModules.config
          stylix.homeModules.stylix
        ];
        extraSpecialArgs = {
          inherit
            inputs
            system
            pkgs-unstable
            pkgs-old
            ;
        };
      };
    };
}
