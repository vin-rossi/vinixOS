{

 description = " vinix flake";
 
 inputs = {
    # officially cool enough for unstable
    nixpkgs.url = "github:NixOS/nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";

    # home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake"; # TODO stop the madness
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:nixos/nixos-hardware";


    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors = {
      url = "github:misterio77/nix-colors";
    };

  };

  outputs = { self, niri, nixpkgs, nixos-hardware, nix-colors,  home-manager, flake-utils, sops-nix  }@inputs: {
    # The host with the hostname `my-nixos` will use this configuration
    nixosConfigurations.vinixOS = nixpkgs.lib.nixosSystem {
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
	{
	  home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;
	  home-manager.users.rhea = import ./home.nix; 
       }
      ];
     };
   };
}
