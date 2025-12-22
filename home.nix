{config, pkgs, inputs, nixvim, ...}:


{
  home.username="rhea";
  home.homeDirectory = "/home/rhea";

  home.packages = with pkgs; [

  kew

  gparted
  hackrf
  sdrpp
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
  
  
  amberol 
  vscode
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
  fuzzel
  mako
  alacritty-graphics
  xwayland-satellite
   
  syncthing
  quickemu
  qemu
  
  nomacs

  brightnessctl

  jetbrains-toolbox
];

  programs.eww = {
    enable = true;
    #configDir = ./vinixOS-dots/eww-widgets;
    };
  services.swww.enable = true;

  programs.swaylock.enable = true;
  programs.swaylock.settings = { color = "d10069"; };

  programs.rofi = {
    enable = true;
    font = "OpenDyslexic Nerd Font";
    modes = [
    "ssh"
    "filebrowser"
    "recursivebrowser"
    "keys"
    "combi"
    "window"
    "run"
    "drun"
    ];
  };

  /* programs.neovim = {
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
   }; */
  
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    colorschemes.catppuccin.enable = true;
    plugins.lualine.enable = true;
    plugins.vimtex = {
      enable = true;
      texlivePackage = pkgs.texliveFull;
      settings = {
	toc_config = {
	  split_pos = "vert topleft";
	  split_width = 40;
	};
	view_method = "zathura";
	};
     };
    extraPlugins = with pkgs.vimPlugins; [
      nerdtree
      semantic-highlight-vim
      ];
    opts = {
      number = true;
      relativenumber = true;

      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
      smarttab = true;
      history = 1000;
      spell = true;
    };

    keymaps = [
      {
        mode = "n";
	key = "<C-s>";
	options.silent = true;
	action = ":SemanticHighlightToggle<CR>";
       }
      {
        mode = "n";
	key = "<C-S-d>";
	options.silent = true;
	action = ":NERDTree<CR>";
       }
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
