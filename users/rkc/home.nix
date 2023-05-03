{ pkgs, ... }:
let
  alacritty-config = import ./alacritty-config.nix;
  xmobar-config = builtins.readFile ./xmobarrc.conf;
  xmonad-config = builtins.readFile ./xmonadrc.hs;
  wallpaper = builtins.fetchurl "https://raw.githubusercontent.com/Zebreus/nixos-dark-wallpaper/master/thinknix-d.svg"
in
{
    home.username = "rkc";
    home.homeDirectory = "/home/rkc";
    home.packages = with pkgs; [
        evince
        firefox
        brave
        bluetuith
        alacritty
        haskellPackages.haskell-language-server
        haskellPackages.hoogle
        cabal-install
        stack
        ghc
        feh
        xmobar
        spectacle
        ranger
        multilockscreen
        neofetch
        vim
        vscode
        wget
        awscli2
        bc
        git 
        yarn
        python311
        python311.pkgs.pip
        nodejs
        docker
        xclip
        esbuild
        rofi
        brightnessctl
        tdesktop
        zoom-us
        qbittorrent
        vlc
    ];

    programs.home-manager = {
        enable = true;
	path = "~/.config/nixpkgs.home.nix";
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
	];
	viAlias = true;
	extraConfig = ''
	    set clipboard+=unnamedplus
	    syntax enable
	'';
    };

    home.stateVersion = "22.11";
    nixpkgs.config.allowUnfree = true;

}
