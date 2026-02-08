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

    outputs = { self, nixpkgs, catppuccin, home-manager, nixvim, mensa, ... }:
    let
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
    in {

        # ── Dev shells ───────────────────────────────────────
        # Usage:  nix develop .#rust    (or cd into a project with `use flake` in .envrc)
        devShells.${system} = {

            # General-purpose C/C++ shell
            c = pkgs.mkShell {
                name = "c-dev";
                packages = with pkgs; [ gcc gnumake cmake gdb valgrind pkg-config ];
            };

            # Rust
            rust = pkgs.mkShell {
                name = "rust-dev";
                packages = with pkgs; [ rustc cargo rust-analyzer clippy rustfmt pkg-config openssl ];
                RUST_SRC_PATH = "${pkgs.rust.packages.stable.rustPlatform.rustLibSrc}";
            };

            # Zig
            zig = pkgs.mkShell {
                name = "zig-dev";
                packages = with pkgs; [ zig zls ];
            };

            # Node.js / TypeScript
            node = pkgs.mkShell {
                name = "node-dev";
                packages = with pkgs; [ nodejs_22 pnpm nodePackages.typescript typescript-language-server ];
            };

            # Python
            python = pkgs.mkShell {
                name = "python-dev";
                packages = with pkgs; [ python3 python3Packages.pip python3Packages.virtualenv ];
            };

            # Typst
            typst = pkgs.mkShell {
                name = "typst-dev";
                packages = with pkgs; [ typst typstyle tinymist ];
            };

            # Spade (FPGA HDL)
            spade = pkgs.mkShell {
                name = "spade-dev";
                packages = with pkgs; [ spade swim surfer yosys nextpnr openfpgaloader verilator ];
            };

            # Embedded / ESP
            embedded = pkgs.mkShell {
                name = "embedded-dev";
                packages = with pkgs; [ rustc cargo esp-generate platformio cargo-pio openocd ];
            };

            # Java
            java = pkgs.mkShell {
                name = "java-dev";
                packages = with pkgs; [ javaPackages.compiler.temurin-bin.jdk-21 gradle maven ];
            };
        };

        # ── NixOS configurations ─────────────────────────────
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
                        extraSpecialArgs = { inherit mensa; hostName = "ideapad"; };
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
            specialArgs = { inherit mensa; hostName = "ideapad"; };
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
                        extraSpecialArgs = { inherit mensa; hostName = "yoga"; };
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
            specialArgs = { inherit mensa; hostName = "yoga"; };
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
                        extraSpecialArgs = { inherit mensa; hostName = "onyx"; };
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
            specialArgs = { inherit mensa; hostName = "onyx"; };
        };
    };
}
