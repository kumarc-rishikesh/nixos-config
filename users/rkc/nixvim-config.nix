{ pkgs }:
{
  settings = {
    enable = true;
    viAlias = true;
    extraPlugins = with pkgs.vimPlugins; [ monokai-pro-nvim ];
    colorscheme = "monokai-pro";

    globals = {
      mapleader = "\ ";
    };

    plugins = {
      lualine.enable = true;
      lsp.enable = true;
      lsp-format.enable = true;
      lsp-status.enable = true;
      neo-tree = {
        enable = true;
        enableGitStatus = true;
        enableRefreshOnWrite = true;
      };
      web-devicons.enable = true;
      gitsigns.enable = true;
      telescope.enable = true;
      indent-blankline.enable = true;
      treesitter = {
        enable = true;
        folding = false;

      };
    };

    opts = {
      number = true;
      relativenumber = true;
      wrap = false;
      linebreak = false;
      shiftwidth = 4;
      tabstop = 4;
      softtabstop = 4;
      expandtab = true;
      smartindent = true;
      pumheight = 10;
    };
    clipboard.register = "unnamedplus";

    keymaps = [
      {
        key = ''\'';
        action = ":Neotree<CR>";
      }
      {
        mode = "v";
        key = "<";
        action = "<gv";
      }
      {
        mode = "v";
        key = ">";
        action = ">gv";
      }
      {
        mode = "n";
        key = "n";
        action = "nzzzv";
      }
      {
        mode = "n";
        key = "N";
        action = "Nzzzv";
      }

      {
        mode = "n";
        key = "<Tab>";
        action = ":bnext<CR>";
      }
      {
        mode = "n";
        key = "<S-Tab>";
        action = ":bprevious<CR>";
      }
      {
        mode = "n";
        key = "<leader>x";
        action = ":bdelete!<CR>";
      }
      {
        mode = "n";
        key = "<leader>b";
        action = "<cmd> enew <CR>";
      }
      {
        mode = "n";
        key = "<leader>v";
        action = "<C-w>v";
      }
      {
        mode = "n";
        key = "<leader>xs";
        action = ":close<CR>";
      }
      {
        mode = "n";
        key = "<C-k>";
        action = ":wincmd k<CR>";
      }
      {
        mode = "n";
        key = "<C-l>";
        action = ":wincmd l<CR>";
      }
      {
        mode = "v";
        key = "p";
        action = ''"_dp'';
      }
      {
        mode = "n";
        key = "[d";
        action = "vim.diagnostic.goto_prev";
      }
      {
        mode = "n";
        key = "]d";
        action = "vim.diagnostic.goto_next";
      }
      {
        mode = "n";
        key = "<leader>d";
        action = "vim.diagnostic.open_float";
      }
      {
        mode = "n";
        key = "<leader>q";
        action = "vim.diagnostic.setloclist";
      }
    ];
  };
}
