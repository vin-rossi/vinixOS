{config, pkgs, ...}:

{
  home.username="rhea";
  home.homeDirectory = "/home/rhea";

  home.packages = with pkgs; [

  neofetch
  nnn
  
  nautilus
  yazi
  zip
  unzip
  gzip
  kdePackages.dolphin 
  nmap

  cowsay
  btop
  
  amberol 
  vscodium
  emacs
  spotify
  vimb
  discord
  thunderbird
  ghostty
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
  radeontop

  networkmanagerapplet
  swww
  swaylock
  fuzzel
  mako
  alacritty
  xwayland-satellite
   
  syncthing
  quickemu
  qemu
  
  nomacs

  texlive.combined.scheme-tetex
  brightnessctl
];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    coc.enable = true;
    extraConfig = "
      set number
      set tabstop=4
      set shiftwidth=4
      set expandtab
      set smarttab
      set ignorecase
      set incsearch
      set hlsearch
      set smartcase
      set linebreak
      syntax enable
      set wrap
      set title
      set background=dark
      set history=1000
      set spell spelllang=en_us
      nnoremap <silent><C-s> :SemanticHighlightToggle<cr>
      nnoremap <silent><C-S-d> :NERDTree<cr>
      ";
    plugins = with pkgs.vimPlugins; [
        vimtex
	nerdtree
	semantic-highlight-vim

      ];
   };
  programs.git = {
	enable = true;
	userName = "Rhea-Morningstar";
	userEmail = "gavinmrossi@gmail.com";
	extraConfig = {
	  init.defaultBranch = "main";
	  safe.directory = "/etc/nixos";
    };
  };
 
  services.swayidle =
  let
    # Lock command
    lock = "${pkgs.swaylock}/bin/swaylock --daemonize";
    # Niri
     display = status: "${pkgs.niri}/bin/niri msg action power-${status}-monitors";
  in
  {
    enable = true;
    timeouts = [
      {
        timeout = 300; # in seconds
        command = "${pkgs.libnotify}/bin/notify-send 'Locking in 5 seconds' -t 5000";
      }
      {
        timeout = 305;
        command = lock;
      }
      {
        timeout = 420;
        command = display "off";
        resumeCommand = display "on";
      }
      {
        timeout = 600;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
     events = [
      {
        event = "before-sleep";
        # adding duplicated entries for the same event may not work
        command = (display "off") + "; " + lock;
      }
      {
        event = "after-resume";
        command = display "on";
      }
      {
        event = "lock";
        command = (display "off") + "; " + lock;
      }
    {
      event = "unlock";
      command = display "on";
    }
  ];
};

  home.stateVersion = "25.05";
}
