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
      lsp = {
        enable = true;
        servers = {
          rust_analyzer = {
            enable = true;
            installCargo = false;
            installRustc = false;
          };
          nixd.enable = true;
          metals.enable = true;
          hls = {
            enable = true;
            installGhc = false;
          };
          pylsp.enable = true;
          elixirls.enable = true;
        };
        keymaps.lspBuf = {
          "K" = "hover";
          "gD" = "references";
          "gd" = "definition";
          "gi" = "implementation";
          "gt" = "type_definition";
          "<leader>ca" = "code_action";
        };
        keymaps.diagnostic = {
          "<leader>j" = "goto_next";
          "<leader>k" = "goto_prev";
        };
      };
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "buffer"; }
            { name = "path"; }
          ];
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-n>" = "cmp.mapping.select_next_item()";
            "<C-p>" = "cmp.mapping.select_prev_item()";
            "<C-y>" = "cmp.mapping.confirm({ select = true })";
            "<C-e>" = "cmp.mapping.abort()";
          };
        };
      };
      fidget.enable = true;
      lsp-format.enable = true;
      lsp-status.enable = true;
      neo-tree = {
        enable = true;
        enableGitStatus = true;
        enableRefreshOnWrite = true;
      };
      web-devicons.enable = true;
      nvim-autopairs.enable = true;
      nvim-colorizer.enable = true;
      todo-comments.enable = true;
      gitsigns.enable = true;
      indent-blankline.enable = true;
      treesitter = {
        enable = true;
        folding = false;
      };
      telescope = {
        enable = true;
        extensions = {
          ui-select.enable = true;
        };
        keymaps = {
          "<leader>sh" = "help_tags"; # [S]earch [H]elp
          "<leader>sk" = "keymaps"; # [S]earch [K]eymaps
          "<leader>sf" = "find_files"; # [S]earch [F]iles
          "<leader>ss" = "builtin"; # [S]earch [S]elect Telescope
          "<leader>sw" = "grep_string"; # [S]earch current [W]ord
          "<leader>sg" = "live_grep"; # [S]earch by [G]rep
          "<leader>sd" = "diagnostics"; # [S]earch [D]iagnostics
          "<leader>sr" = "resume"; # [S]earch [R]esume
          "<leader>s" = "oldfiles"; # [S]earch Recent Files ("." for repeat)
          "<leader><leader>" = "buffers"; # [ ] Find existing buffers
        };
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
        key = "<C-l>";
        action = ":wincmd l<CR>";
      }
      {
        mode = "n";
        key = "<C-h>";
        action = ":wincmd h<CR>";
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
