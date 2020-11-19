{ config, pkgs, ... }:

{

nix.binaryCaches = [ "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store" "https://cache.nixos.org/" ];
# List packages installed in system profile. To search by name, run:
# $ nix-env -qaP | grep wget
environment.systemPackages =
[
  ];

services.yabai = {
  enable = true;
  package = pkgs.yabai;
  enableScriptingAddition = true;
  config = {
    layout = "bsp";
    window_gap = 5;
  };
  extraConfig = ''
    yabai -m config mouse_follows_focus on
    #rules
    yabai -m rule --add app='System Preference' manage=off
    yabai -m rule --add app='zoom.us' space=4
    yabai -m rule --add app='Maps' space=4
    yabai -m rule --add app='iTerm' space=2
    yabai -m rule --add app='VirtualBox' space=8
    yabai -m rule --add app='VirtualBox VM' space=4
  '';
};

services.skhd = {
    enable = true;
    package = pkgs.skhd;
    skhdConfig = "
alt - h : yabai -m window --focus west
alt - j : yabai -m window --focus south
alt - k : yabai -m window --focus north
alt - l : yabai -m window --focus east
ctrl - j : yabai -m display --focus 2
ctrl - k : yabai -m display --focus 1
ctrl - 1 : yabai -m space --focus 1
ctrl - 2 : yabai -m space --focus 2
ctrl - 3 : yabai -m space --focus 3
ctrl - 4 : yabai -m space --focus 4
ctrl + cmd - 1 : yabai -m space --focus 5
ctrl + cmd - 2 : yabai -m space --focus 6
ctrl + cmd - 3 : yabai -m space --focus 7
ctrl + cmd - 4 : yabai -m space --focus 8
alt - f : yabai -m window --toggle zoom-fullscreen
    ";
  };

# Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";

  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Create /etc/bashrc that loads the nix-darwin environment.
  programs.zsh.enable = true;  # default shell on catalina
  # programs.fish.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
