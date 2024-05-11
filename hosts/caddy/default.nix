{
  inputs,
  outputs,
  pkgs,
  lib,
  ...
}:
{
  imports = [

    # Generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix

    # Repo Modules
    ../common/global
    ../common/users/tk

  ];

  # Overlays
  nixpkgs = {
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.other-packages
    ];
    config = {
      allowUnfree = true;
    };
  };

  # use default bash
  # TODO: find a better way to do this
  users.users.tk.shell = lib.mkForce pkgs.bash;
  users.users.tk.extraGroups = lib.mkForce [ "networkmanager" "wheel" "docker" ];

  # Hostname & Network Manager
  networking.hostName = "caddy";
  networking.networkmanager.enable = true;

  # System Packages
  environment.systemPackages = with pkgs; [
    vim
  ];

  # Enable Docker
  virtualisation.docker = {
    enable = true;
  };

  # Caddy Config
  services.caddy = {
    enable = true;
    virtualHosts."localhost".extraConfig = ''
      respond "Hello, world!"
    '';
  };

  # Open HTTP/HTTPS ports
  networking.firewall.allowedTCPPorts = [ 80 443 ];

  # Adding CA root & intermediate certs
  security.pki.certificateFiles = [
    ../common/intermediate_ca.crt
    ../common/root_ca.crt
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11";
}