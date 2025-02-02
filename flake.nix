{
  description = "Nix flae for system config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix.url = "github:ryantm/agenix";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      agenix,
      hyprland,
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
      lib = nixpkgs.lib;

    in
    {

      nixosConfigurations = {
        nixos = lib.nixosSystem {
          inherit system;
          modules = [ ./system/configuration.nix ];
          specialArgs = {
            inherit inputs;
          };
        };
      };

      homeConfigurations.rkc = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./users/rkc/home.nix ];
        extraSpecialArgs = {
          inherit pkgs-unstable;
        };
      };
    };
}
