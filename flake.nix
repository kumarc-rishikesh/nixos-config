{
  description = "Nix flakke for system config";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-22.11"; 
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
};

  outputs = { nixpkgs, home-manager, ... }: 
  let 
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
    };

    lib = nixpkgs.lib;

  in {

    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;
	modules = [
          ./system/configuration.nix
	];
      };
    };
    
    homeConfigurations.rkc = home-manager.lib.homeManagerConfiguration {
      inherit pkgs;
      modules = [
        ./users/rkc/home.nix
      ];
      # Optionally use extraSpecialArgs
      # to pass through arguments to home.nix
    };
  };
}
