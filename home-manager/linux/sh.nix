{ config, pkgs, ... }:

let
  myAliases = {
    top = "${pkgs.bottom}/bin/btm";
    htop = "${pkgs.bottom}/bin/btm";
    ls = "${pkgs.eza}/bin/eza --icons -F --group-directories-first --git";
    cat = "${pkgs.bat}/bin/bat";
    du = "${pkgs.du-dust}/bin/dust";
    grep = "${pkgs.ripgrep}/bin/rg";
    ll = "ls -la";
    vi = "${pkgs.vim}/bin/vim";
  };
  myEnvVars = {
    PASTA = "Spaghetti";
    EDITOR = "vim";
  };
in
{
  # Environment Variables
  home.sessionVariables = myEnvVars;
  
  programs.zsh = {
    enable = true;
    shellAliases = myAliases;
  };
}
