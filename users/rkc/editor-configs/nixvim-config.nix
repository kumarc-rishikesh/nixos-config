{ pkgs }:
let
  nixvim-plugins = import ./nixvim-plugins.nix;
  nixvim-keymaps = import ./nixvim-keymaps.nix;
in
{
  settings = {
    enable = true;
    viAlias = true;
    colorschemes.gruvbox = {
      enable = true;
      settings = {
        palette_overrides = {
          contrast_dark = "hard";
          dark0 = "#1a1a1a";
          bright_blue = "#5476b2";
          bright_purple = "#fb4934";
          dark1 = "#323232";
          dark2 = "#383330";
          dark3 = "#323232";
        };
        terminal_colors = true;
      };
    };
    globals = {
      mapleader = "\ ";
    };
    opts = {
      number = true;
      relativenumber = true;
      wrap = false;
      linebreak = false;
      shiftwidth = 2;
      tabstop = 2;
      softtabstop = 2;
      expandtab = true;
      smartindent = true;
      pumheight = 10;
    };
    diagnostic.settings = {
      virtual_lines = {
        current_line = true;
      };
      virtual_text = false;
    };
    plugins = nixvim-plugins;
    keymaps = nixvim-keymaps;
  };
}
