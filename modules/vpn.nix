{ lib, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    openvpn
  ];

	networking.networkmanager = {
		enable = true;
		plugins = with pkgs; [
			networkmanager-openvpn
		];
	};

	# services.openvpn.servers = {
	# 	uni = {
	# 		config = '' /home/jflocke/ovpn/uni.ovpn '';
	# 	};
	# };
}