{
    description = "NixOS system configuration";
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        nixvim = {
            url = "github:nix-community/nixvim";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        catppuccin = {
            url = "github:catppuccin/nix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        mensa = {
            url = "git+https://git.cs.uni-paderborn.de/jflocke/mensa-tui.git";
        };
    };

    outputs = { self, nixpkgs, catppuccin, home-manager, nixvim, mensa, ... }: {
        # output for ideapad configuration
        nixosConfigurations.ideapad = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
                ./hosts/ideapad/configuration.nix
                home-manager.nixosModules.home-manager
                {
                    home-manager = {
                        useGlobalPkgs = true;
                        useUserPackages = true;
                        extraSpecialArgs = { inherit mensa; };
                        users.jflocke = {
                            imports = [
                                catppuccin.homeModules.catppuccin
                                nixvim.homeModules.nixvim
                                ./users/jflocke/home.nix
                          ];
                        };
                        backupFileExtension = "backup";
                    };
                }
            ];
            specialArgs = { inherit mensa; };
        };

        # output for yoga configuration
        nixosConfigurations.yoga = nixpkgs.lib.nixosSystem {
            system = "x86_64-Linux";
            modules = [
                ./hosts/yoga/configuration.nix
                home-manager.nixosModules.home-manager
                {
                    home-manager = {
                        useGlobalPkgs = true;
                        useUserPackages = true;
                        extraSpecialArgs = { inherit mensa; };
                        users.jflocke = {
                            imports = [
                                catppuccin.homeModules.catppuccin
                                nixvim.homeModules.nixvim
                                ./users/jflocke/home.nix
                          ];
                        };
                        backupFileExtension = "backup";
                    };
                }
            ];
            specialArgs = { inherit mensa; };
        };

        # output for onyx configuration
        nixosConfigurations.onyx = nixpkgs.lib.nixosSystem {
            system = "x86_64-Linux";
            modules = [
                ./hosts/onyx/configuration.nix
                home-manager.nixosModules.home-manager
                {
                    home-manager = {
                        useGlobalPkgs = true;
                        useUserPackages = true;
                        extraSpecialArgs = { inherit mensa; };
                        users.jflocke = {
                            imports = [
                                catppuccin.homeModules.catppuccin
                                nixvim.homeModules.nixvim
                                ./users/jflocke/home.nix
                          ];
                        };
                        backupFileExtension = "backup";
                    };
                }
            ];
            specialArgs = { inherit mensa; };
        };
    };
}
