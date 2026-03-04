{
  description = "NixOS + macOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    apple-silicon = {
      url = "github:tpwrules/nixos-apple-silicon";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, apple-silicon, home-manager, nix-darwin, ... }@inputs: {

    nixosConfigurations.macbook-nixos = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/nixos/configuration.nix
        apple-silicon.nixosModules.apple-silicon-support
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.gideon = import ./home/home-nixos.nix;
          home-manager.backupFileExtension = "backup";
        }
      ];
    };

    darwinConfigurations.gideon-mac = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/darwin/configuration.nix
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.gideonmarcus-trask = import ./home/home-darwin.nix;
          home-manager.extraSpecialArgs = {
            homeDirectory = "/Users/gideon";
          };
        }
      ];
    };
  };
}
