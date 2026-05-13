{config, pkgs, inputs, nixvim, ...}:


{
  home.username="rhea";
  home.homeDirectory = "/home/rhea";


  home.packages = with pkgs; [

  #this is so unorganized but ill atttempt to fix that over time :3

  inputs.nix-alien.packages.${pkgs.system}.default
  #Langs
  go
  jdk
  racket
  ruby
  rustc
  cargo
  qemu


  signal-desktop
  proxmark3

  kew
  zoom

  btop
  cmake
  gparted
  hackrf
  sdrpp
  nnn
  
  nautilus
  yazi
  zip
  unzip
  gzip
  kdePackages.dolphin 
  nmap

  fastfetch
  hyfetch
  cowsay
  

  binaryninja-free
  ghidra-bin 
  burpsuite
  
  amberol 
  vscode
  spotify
  vimb
  discord
  vlc 
  wget
  darktable
  libreoffice-qt
  git
  gdb
  gcc
  libgcc
  python3
  valgrind
  gnumake
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

  emacsPackages.evil
  swww
  waypaper

];

  programs.noctalia-shell= {
      enable = true;
      settings = {
        # configure noctalia here
        bar = {
          density = "compact";
          position = "top";
          showCapsule = true;
          widgets = {
            left = [
              {
                id = "ControlCenter";
                useDistroLogo = true;
              }
              {
                hideUnoccupied = false;
                id = "Workspace";
                labelMode = "none";
              }
            ];
            center = [
            {
              id = "MediaMini";
            }
            ];
            right = [
              {
                id = "Volume";
              }
              {
                id = "Network";
              }
              {
                id = "Bluetooth";
              }
              {
                alwaysShowPercentage = true;
                id = "Battery";
                warningThreshold = 30;
              }
              {
                formatHorizontal = "HH:mm";
                formatVertical = "HH mm";
                id = "Clock";
                useMonospacedFont = true;
                usePrimaryColor = true;
              }
            ];
          };
        };
        colorSchemes.predefinedScheme = "Monochrome";
        general = {
          radiusRatio = 0.2;
        };
        location = {
          monthBeforeDay = true;
          name = "Boston, US";
          useFahrenheit = true;
        };
      };
      # this may also be a string or a path to a JSON file.
    };


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



  programs.ghostty = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      env = "TERM=xterm-256color";
      background = "000000";
      background-opacity = "0.75";
      gtk-single-instance = "false";
    };
  };
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
    extraPackages = epkgs: [
      epkgs.rustic
      epkgs.org
      epkgs.nix-mode
      epkgs.evil
      epkgs.nixfmt
    ];
    extraConfig = ''
      (evil-mode 1)
      (column-number-mode 1)
      (add-hook 'prog-mode-hook 'display-line-numbers-mode)
      (setq standard-indent 2)
      '';
    };
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
       {
        mode = "";
        key = "j";
        options.silent = true;
        action = "gj";
        }
        {
        mode = "";
        key = "k";
        options.silent = true;
        action = "gk";
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

programs.zsh = {
  enable = true;
  enableCompletion = false;
  autosuggestion.enable = true;
  syntaxHighlighting.enable = true;
  shellAliases = {
    ll = "ls -l";
    update = "sudo nixos-rebuild switch --flake ~/vinixOS#vinixOS";
  };
  history.size = 10000;
  history.ignoreAllDups = true;
  oh-my-zsh = {
    enable = true;
    plugins = ["git" "ruby" ];
    theme = "bira";
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
