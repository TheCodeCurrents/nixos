
{ config, pkgs, ... }:

{


	imports = [
    ./gaming.nix
  ];

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.kernelPackages = pkgs.linuxPackages_latest;

	time.timeZone = "Europe/Berlin";
	i18n.defaultLocale = "en_US.UTF-8";

	services.xserver = {
		enable = true;
		layout = "de";
		displayManager.gdm.enable = true;
		desktopManager.gnome.enable = true;
		autoRepeatDelay = 200;
		autoRepeatInterval = 35;
		windowManager.qtile.enable = true;
	};

	services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.gnome.core-apps.enable = false;
  services.gnome.core-developer-tools.enable = false;


	services.displayManager.ly.enable = true;
	services.xserver.xkb.layout = "de";
	services.printing.enable = true;
	services.pipewire = {
		enable = true;
		pulse.enable = true;
	};

	nixpkgs.config.allowUnfree = true;

	environment.systemPackages = with pkgs; [
		vim
		vscode
		neovim
		wget
		git
		alacritty
		direnv
		htop
		btop
		networkmanager
	];

	fonts.packages = with pkgs; [
		nerd-fonts.jetbrains-mono
	];

	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	system.stateVersion = "25.05";
}
