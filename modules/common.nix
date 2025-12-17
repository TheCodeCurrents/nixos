
{ config, pkgs, ... }:

{

	imports = [
		./gaming.nix
		./virtualization.nix
		./docker.nix
		./syncthing.nix
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
		xkb.layout = "de";

		# displayManager.gdm.enable = true;

		autoRepeatDelay = 200;
		autoRepeatInterval = 35;
	};

	services.desktopManager.gnome = {
		enable = true;
	};

	services.desktopManager.gnome.extraGSettingsOverrides = ''
		[org.gnome.mutter]
		experimental-features=['scale-monitor-framebuffer', 'xwayland-native-scaling']
	'';

	services.ollama = {
		enable = true;
		# Optional: preload models, see https://ollama.com/library
		loadModels = [ "llama3.2:3b" "deepseek-r1:1.5b" "olmo-3:7b-think" ];
  	acceleration = "cuda";
	};

	environment.sessionVariables = {
		NIXOS_OZONE_WL = "1";

		# Optional, useful for some non-Electron apps:
		MOZ_ENABLE_WAYLAND = "1";   # Firefox
		SDL_VIDEODRIVER = "wayland";
		QT_QPA_PLATFORM = "wayland";
	};

	networking.firewall.allowedTCPPorts = [ 3000 ];
	networking.firewall.allowedUDPPorts = [ 3000 ];
	networking.firewall.enable = true;

	services.gnome.core-apps.enable = true;
	services.gnome.core-developer-tools.enable = true;

	services.displayManager.ly.enable = true;
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

	services.udev.packages = with pkgs; [ 
    platformio-core.udev
    openocd
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

	programs.nix-ld.enable = true;

	environment.systemPackages = with pkgs; [
	  vim
		vscode
		vscode.fhs
		wget
		git
		alacritty
		direnv
		htop
		btop
		networkmanager
			
		wineWowPackages.stable

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
		syncthing
		
		obsidian

		# mangowc related packages
		foot
		wmenu
		wl-clipboard
		grim
		slurp
		swaybg


		python3
		# javaPackages.compiler.temurin-bin.jre-8
		javaPackages.compiler.temurin-bin.jdk-21
		# javaPackages.compiler.temurin-bin.jre-23
		# javaPackages.compiler.temurin-bin.jre-25
	];

	fonts = {
		fontDir.enable = true;
		packages = with pkgs; [
			noto-fonts
			liberation_ttf
			corefonts
			vista-fonts
			nerd-fonts.jetbrains-mono
			nerd-fonts.fira-code
			nerd-fonts.hack
			nerd-fonts.dejavu-sans-mono
		];
	};	

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

	programs.niri.enable = true;
	programs.mango.enable = true;

	xdg.portal = {
		enable = true;
		extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
	};

	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	system.stateVersion = "25.05";
}
