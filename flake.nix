{
    description = "NixOS system configuration";
    inputs = {
        nixpkgs.url = "nixpkgs/nixos-25.05";
        home-manager ={
            url = "github:nix-community/home-manager/release-25.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        catppuccin = {
            url = "github:catppuccin/nix/release-25.05";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, catppuccin, home-manager, ... }: {
        nixosConfigurations.ideapad = nixpkgs.lib.nixosSystem {
            system = "x86_64-Linux";
            modules = [
                ./hosts/ideapad/configuration.nix
                home-manager.nixosModules.home-manager
                {
                    home-manager = {
                        useGlobalPkgs = true;
                        useUserPackages = true;
                        users.jflocke = imports [
                            ./modules/users/jflocke/home.nix
                            catppuccin.homeManagerModules.catppuccin
                        ];
                        backupFileExtension = "backup";
                    };
                }
            ];
        };
    };
}
