{
	description = "My NixOS flake - laptop";
  
	inputs = {
		nixpkgs.url = "nixpkgs/nixos-26.05";

    # Nix home manager
		home-manager = {
			url = "github:nix-community/home-manager/release-26.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};

    # Noctalia
		noctalia = {
			url = "github:noctalia-dev/noctalia";
			inputs.nixpkgs.follows = "nixpkgs";
		};

    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Zen browser
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # VSC extension marketplace
    nix-vscode-extensions = {
      url ="github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Spotify CLI
    spotatui = {
      url = "github:LargeModGames/spotatui";
      inputs.nixpkgs.follows = "nixpkgs";
    };
	};

	outputs = inputs@{ self, nixpkgs, home-manager, ... } :
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  in
  {
		nixosConfigurations.nixflake = nixpkgs.lib.nixosSystem 
    {
			inherit system pkgs;
			specialArgs = { inherit inputs; };

			modules = [
				./configuration.nix
				home-manager.nixosModules.home-manager
				{
					home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						users.rares = ./home.nix;
						backupFileExtension = "backup";
						extraSpecialArgs = { inherit inputs; };
					};
				}
			];
		};
    devShells."x86_64-linux" = import ./devshells {
      pkgs = self.nixosConfigurations.nixflake.pkgs;
    };
	};
}
