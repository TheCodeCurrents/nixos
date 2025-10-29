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
    };

    outputs = { self, nixpkgs, catppuccin, home-manager, nixvim, ... }: {
        nixosConfigurations.ideapad = nixpkgs.lib.nixosSystem {
            system = "x86_64-Linux";
            modules = [
                ./hosts/ideapad/configuration.nix
                home-manager.nixosModules.home-manager
                {
                    home-manager = {
                        useGlobalPkgs = true;
                        useUserPackages = true;
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
        };
        nixosConfigurations.yoga = nixpkgs.lib.nixosSystem {
            system = "x86_64-Linux";
            modules = [
                ./hosts/yoga/configuration.nix
                home-manager.nixosModules.home-manager
                {
                    home-manager = {
                        useGlobalPkgs = true;
                        useUserPackages = true;
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
        };
        nixosConfigurations.onyx = nixpkgs.lib.nixosSystem {
            system = "x86_64-Linux";
            modules = [
                ./hosts/onyx/configuration.nix
                home-manager.nixosModules.home-manager
                {
                    home-manager = {
                        useGlobalPkgs = true;
                        useUserPackages = true;
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
        };
    };
}
