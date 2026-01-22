
{ lib, pkgs, mensa, ... }:

{

    imports = [ ./vpn.nix ];

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

	services.desktopManager.gnome.enable = true;
	services.desktopManager.gnome.extraGSettingsOverrides = ''
		[org.gnome.mutter]
		experimental-features=['scale-monitor-framebuffer', 'xwayland-native-scaling']
	'';

	environment.sessionVariables = {
		NIXOS_OZONE_WL = "1";
		MOZ_ENABLE_WAYLAND = "1";
		SDL_VIDEODRIVER = "wayland";
		QT_QPA_PLATFORM = "wayland";
	};

	networking.firewall.allowedTCPPorts = [ 3000 ];
	networking.firewall.allowedUDPPorts = [ 3000 ];
	networking.firewall.enable = true;


	programs.fish.enable = true;
	programs.firefox.enable = true;

	services.gnome.core-apps.enable = true;
	services.gnome.core-developer-tools.enable = true;

	services.displayManager.ly.enable = true;
	services.printing.enable = true;
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

	services.udev.extraRules = ''
		# Cheap 24MHz Logic Analyzer (CH341/Logic clones)
		ATTR{idVendor}=="1a86", ATTR{idProduct}=="7523", MODE="0666"
		ATTR{idVendor}=="0925", ATTR{idProduct}=="3881", MODE="0666"
		ATTR{idVendor}=="1d50", ATTR{idProduct}=="602b", MODE="0666"
	'';


	nixpkgs.config.allowUnfree = true;

	programs.appimage.enable = true;
	services.flatpak.enable = true;
	services.gvfs.enable = true;
	services.udisks2.enable = true;
	programs.nix-ld.enable = true;

	environment.systemPackages = with pkgs; [
	  	vim
		vscode
		wget
		git
		alacritty
		direnv
		htop
		btop

		freecad
		cura-appimage

		nautilus
		gnomecast
		gnome-tweaks

		cifs-utils
		freerdp
		protonvpn-gui
		flatpak
		gnome-software
		obsidian
		mensa.packages.${pkgs.system}.mensa-tui

		python3
		javaPackages.compiler.temurin-bin.jdk-21
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

	users.users.jflocke = {
		isNormalUser = true;
		shell = pkgs.fish;
		extraGroups = [ "wheel" "networkmanager" ];
		packages = with pkgs; [
			tree
			networkmanager_dmenu
			networkmanager
		];
	};

	xdg.portal = {
		enable = true;
		extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
	};

	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	system.stateVersion = "25.05";
}
