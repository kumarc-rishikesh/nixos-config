{ pkgs, ... }:
let
  alacritty-config = import ./alacritty-config.nix;
  xmobar-config = builtins.readFile ./xmobarrc.conf;
  xmonad-config = builtins.readFile ./xmonadrc.hs;
in
{
    home.username = "rkc";
    home.homeDirectory = "/home/rkc";
    home.packages = with pkgs; [
        xmobar
        bluetuith
        alacritty
        feh
        ksnip
        ranger
        multilockscreen
        neofetch
        vim
        wget
        bc
        git 
        xclip
        brightnessctl
        libqalculate
        todo
        tlp
        qemu
    ] ++ [
        nodejs
        awscli2
        nodePackages.npm
        esbuild
        yarn
        docker
        python311
        python311.pkgs.pip
        poetry
        gparted
        wine
    ] ++ [
        github-desktop
        qbittorrent
        gltron
        libreoffice
        discord
        vlc
        firefox
        brave
        vscode
        evince
        zoom-us
        okular
        ];

    programs.home-manager = {
        enable = true;
	};


    programs.alacritty = {
      enable = true;
      settings = alacritty-config;
    };


    programs.xmobar = {
        enable = true;
        extraConfig = xmobar-config;
	};
    

    xsession.windowManager.xmonad = {
        enable = true;
        enableContribAndExtras = true;
        config = pkgs.writeText "xmonad.hs" xmonad-config ;
    };

    services.picom = {
        enable = true;
	      fade = true;
    };

    services.screen-locker = {
        enable  = true;
	      inactiveInterval = 1;
	      lockCmd = "multilockscreen -l";
    };

    programs.neovim = {
        enable = true;
	      coc.enable = false;
	      plugins = with pkgs.vimPlugins;[
	          vim-sensible
	    {
	        plugin = nerdtree;
		      config = "let g:NERDTreeMinimalUI = 1";
	    }
	    purescript-vim
	    dracula-nvim
	    nvchad
	];
	viAlias = true;
	extraConfig = ''
	    set clipboard+=unnamedplus
	    syntax enable
	'';
    };
    
    programs.rofi = {
        enable = true;
	      plugins = [ pkgs.rofi-calc ];
        extraConfig = {	    
            display-drun = "Applications";
		    modi = "run,calc,drun,filebrowser";
        };
        theme = "gruvbox-dark-hard";
    };

    programs.helix = {
        enable = true;
        settings = {
            theme = "gruvbox_dark_hard";
            editor = {
                line-number = "relative";
                lsp.display-messages = true;
            };
        };
    };

    home.stateVersion = "23.05";
    nixpkgs.config.allowUnfree = true;

}