
{ config, pkgs, ... }:

{

	imports = [
		./gaming.nix
		./virtualization.nix
		./docker.nix
	];

	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	boot.kernelPackages = pkgs.linuxPackages_latest;
	boot.kernelModules = [ "iptable_nat" "iptables" ];


	hardware.bluetooth.enable = true;
	services.blueman.enable = true;

	time.timeZone = "Europe/Berlin";
	i18n.defaultLocale = "en_US.UTF-8";

	services.xserver = {
		enable = true;
		layout = "de";

		# You can still use GDM if you want to switch between GNOME and Qtile
		# displayManager.gdm.enable = true;

		desktopManager.gnome = {
			enable = true;
		};

		autoRepeatDelay = 200;
		autoRepeatInterval = 35;

		windowManager.qtile.enable = true;
	};


	networking.firewall.allowedTCPPorts = [ 3000 ];
	networking.firewall.allowedUDPPorts = [ 3000 ];
	networking.firewall.enable = true;

	# services.displayManager.gdm.enable = true;
	# services.desktopManager.gnome.enable = true;

	services.gnome.core-apps.enable = true;
	services.gnome.core-developer-tools.enable = true;

	services.displayManager.ly.enable = true;
	services.xserver.xkb.layout = "de";
	services.printing.enable = true;
	# Enable sound with pipewire.
	services.pulseaudio.enable = false;
	security.rtkit.enable = true;
		services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		pulse.enable = true;
	};

	console.keyMap = "de";

	services.udev.packages = [ 
    pkgs.platformio-core
    pkgs.openocd
  ];

	nixpkgs.config.allowUnfree = true;
	nixpkgs.config.permittedInsecurePackages = [
		"ventoy-gtk3-1.1.07"
	];

	# enbable AppImage support ...
	programs.appimage = {
		enable = true;
	};

	# enable flatpak support
	services.flatpak.enable = true;

	# Needed for AppImage mounting
	services.gvfs.enable = true;
	services.udisks2.enable = true;

	# programs.nix-ld.enable = true;

	# Add common libraries AppImages need
	# programs.nix-ld.libraries = with pkgs; [
	# 	stdenv.cc.cc
	# 	glib
	# 	zlib
	# 	libGL
	# 	libxkbcommon
	# 	xorg.libX11
	# 	xorg.libXcursor
	# 	xorg.libXrandr
	# 	xorg.libXi
	# 	xorg.libXext
	# 	xorg.libXrender
	# 	xorg.libXfixes
	# 	xorg.libXcomposite
	# 	xorg.libXdamage
	# 	xorg.libXtst
	# 	xorg.libXxf86vm
	# 	xorg.libXScrnSaver
	# ];

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

		freecad
		cura-appimage

		nautilus
		gnomecast
		gnome-boxes
		gnome-tweaks

		cifs-utils

		freerdp

		protonvpn-gui

		flatpak
		gnome-software

		obsidian

		python3
	];

	fonts.packages = with pkgs; [
		nerd-fonts.jetbrains-mono
	];
	

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.jflocke = {
		isNormalUser = true;
		shell = pkgs.fish;
		extraGroups = [ "wheel" "networkmanager" "docker" ];
		packages = with pkgs; [
			tree
			networkmanager_dmenu
			networkmanager
		];
	};


	programs.hyprland.enable = true;

	xdg.portal = {
		enable = true;
		extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
	};

	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	system.stateVersion = "25.05";
}