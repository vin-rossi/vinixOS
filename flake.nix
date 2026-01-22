{

 description = " vinix flake";
 
 inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    


    flake-utils.url = "github:numtide/flake-utils";

    # home-manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake"; 
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";


    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-colors = {
      url = "github:misterio77/nix-colors";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
     };

  };

  outputs = { self, niri, nixpkgs, nixos-hardware, nix-colors,  home-manager, flake-utils, sops-nix, nixvim}@inputs: {
    # The host with the hostname `my-nixos` will use this configuration
    nixosConfigurations.vinixOS = nixpkgs.lib.nixosSystem {
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        nixos-hardware.nixosModules.lenovo-thinkpad-x1-6th-gen
	{
	  home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;
	  home-manager.sharedModules = [
	    nixvim.homeManagerModules.nixvim
	  ];
	  home-manager.users.rhea =  import  ./home.nix;
       }
      ];
     };
   };
}
