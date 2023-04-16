{
  description = "Nix flakke for system config";

  inputs = {
	nixpkgs.url = "nixpkgs/nixos-22.11";
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
    
    homeManagerConfigurations ={
      rkc = home-manager.lib.homeManagerConfiguration {
	inherit system pkgs;
        username = "rkc";
	homeDirectory = "/home/rkc";
        configuration = {
	  imports = [
	    /home/rkc/.config/nixpkgs/home.nix
	  ];
	};
      };
    };

    nixosConfigurations = {
      nixos = lib.nixosSystem {
        inherit system;

	modules = [
          ./system/configuration.nix
	];
      };
    };
  };
    
}
