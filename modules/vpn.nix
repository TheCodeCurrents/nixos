{ lib, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    openvpn
    pritunl-client
  ];

	# networking.networkmanager = {
	# 	enable = true;
	# 	plugins = with pkgs; [
	# 		networkmanager-openvpn
	# 	];
	# };

	# services.openvpn.servers = {
	# 	uni = {
	# 		config = '' /home/jflocke/ovpn/uni.ovpn '';
	# 	};
	# };
}