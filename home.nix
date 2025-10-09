{config, pkgs, ...}:

{
  home.username="rhea";
  home.homeDirectory = "/home/rhea";

  home.packages = with pkgs; [

  neofetch
  nnn

  zip
  gzip
  
  nmap

  cowsay
  btop
 
  swww 
  emacs
  spotify
  vim
  discord
  thunderbird
  ghostty
  vscodium
  vlc 
  wget
  racket
  darktable
  libreoffice-qt
  git
  ghidra-bin 
  gdb
  gcc
  libgcc
  signal-desktop-bin
  python3
  valgrind
  gnumake
  jdk
  jetbrains.idea-community-src
  
  hackrf
  cubicsdr 

  fuzzel
  mako
  alacritty
  xwayland-satellite
];
  
  programs.git = {
	enable = true;
	userName = "Rhea-Morningstar";
	userEmail = "gavinmrossi@gmail.com";
	extraConfig = {
	  init.defaultBranch = "main";
	  safe.directory = "/etc/nixos";
    };
  };


  home.stateVersion = "25.05";
}
