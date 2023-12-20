{ config, pkgs, inputs, ... }:

{
  imports = [
    ./sh.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home = {
    username = "tk";
    stateVersion = "23.11"; # Please read the comment before changing.
    homeDirectory = "/home/tk";
    packages = [
      # pkgs.tmux
      pkgs.ripgrep
      pkgs.tdrop # WM-Independent Dropdown Creator (terminal)
      (pkgs.nerdfonts.override { fonts = [ "CascadiaCode" ]; }) # only 1 font
    ];
  };

  # Enable managing fonts via Home Manager
  fonts.fontconfig.enable = true;

  # Alacritty Config (Fast GPU-Accelerated Terminal)
  programs.alacritty = {
    enable = true;
    settings = {
      window.decorations = "None"; # buttonless on MacOS
      window.opacity = 0.85;
      font.normal.family = "CaskaydiaCove Nerd Font Mono";
      font.normal.style = "Regular";
      font.size = 14.0;
      shell.program = "/home/tk/.nix-profile/bin/tmux";
      shell.args = [ "new-session" "-A" "-s" "general" ];
      key_bindings = [
        { key = "T"; mods = "Control|Shift"; chars = "\\x02\\x63"; } # open tab
        { key = "W"; mods = "Control|Shift"; chars = "\\x02\\x26"; } # close tab
        { key = "Key1"; mods = "Control"; chars = "\\x02\\x31"; } # jump to tab 1
        { key = "Key2"; mods = "Control"; chars = "\\x02\\x32"; } # jump to tab 2
        { key = "Key3"; mods = "Control"; chars = "\\x02\\x33"; } # jump to tab 3
        { key = "Key4"; mods = "Control"; chars = "\\x02\\x34"; } # jump to tab 4
        { key = "Key5"; mods = "Control"; chars = "\\x02\\x35"; } # jump to tab 5
        { key = "Key6"; mods = "Control"; chars = "\\x02\\x36"; } # jump to tab 6
        { key = "Key7"; mods = "Control"; chars = "\\x02\\x37"; } # jump to tab 7
        { key = "Key8"; mods = "Control"; chars = "\\x02\\x38"; } # jump to tab 8
        { key = "Key9"; mods = "Control"; chars = "\\x02\\x39"; } # jump to tab 9
        { key = "Key0"; mods = "Control"; chars = "\\x02\\x30"; } # jump to tab 0
      ];
    };
  };

  # tmux config (Terminal Multiplexer)
  programs.tmux = {
    enable = true;
    baseIndex = 1; # tmux tabs start at 1
    extraConfig = "set -g mouse on"; # mouse scroll up/down
  };

  # Enable Starship for Terminal
  programs.starship.enable = true;

  # KDE Plasma Config
  programs.plasma = {
    enable = true;
    shortcuts = {
      "tdrop.desktop"."_launch" = "Alt+G";
    };
    configFile = {
      "kglobalshortcutsrc"."tdrop.desktop"."_k_friendly_name" = "tdrop -a alacritty";
    };
  };
  
  #########################
  # Testing Section below #
  #########################
  # -------------------------------------------#
  home.file."/home/tk/Btestfile".text = ''
    SOME FILE WITH SOME CONTENT
  '';
  home.file."/home/tk/Ctestfile".source = ./Ctestfile;
  # -------------------------------------------#

}
