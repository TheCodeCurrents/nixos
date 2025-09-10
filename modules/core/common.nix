
{ config, pkgs, ... }:

{
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.kernelPackages = pkgs.linuxPackages_latest;

	time.timeZone = "Europe/Berlin";
	i18n.defaultLocale = "en_US.UTF-8";

	services.xserver = {
		enable = true;
		layout = "de";
		autoRepeatDelay = 200;
		autoRepeatInterval = 35;
		windowManager.qtile.enable = true;
	};
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
    nmcli
	];

	fonts.packages = with pkgs; [
		nerd-fonts.jetbrains-mono
	];

	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	system.stateVersion = "25.05";
}
