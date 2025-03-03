{
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
      html.enable = true;
      cssls.enable = true;
      flow.enable = true;
      elmls.enable = true;
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
        "<C-A>" = "cmp.mapping.complete()";
        "<C-n>" = "cmp.mapping.select_next_item()";
        "<C-p>" = "cmp.mapping.select_prev_item()";
        "<C-y>" = "cmp.mapping.confirm({ select = true })";
        "<C-e>" = "cmp.mapping.abort()";
      };
    };
  };
  comment.enable = true;
  undotree.enable = true;
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
    settings.highlight.enable = true;
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
}
