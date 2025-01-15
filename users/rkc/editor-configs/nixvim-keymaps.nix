[
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
    key = "<C-j>";
    action = ":wincmd j<CR>";
  }
  {
    mode = "n";
    key = "<C-k>";
    action = ":wincmd k<CR>";
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
  {
    mode = "v";
    key = "<leader>y";
    action = ''"+y'';
  }
  {
    mode = "n";
    key = "<leader>y";
    action = ''"+y'';
  }
  {
    mode = "n";
    key = "<leader>d";
    action = ''"+d'';
  }
  {
    mode = [
      "n"
      "v"
    ];
    key = "<A-d>";
    action = ''_d'';
  }
  {
    mode = "n";
    key = "<leader>gr";
    action = ":Gitsigns reset_hunk<CR>";
  }
  {
    mode = "n";
    key = "<leader>gb";
    action = ":Gitsigns blame<CR>";
  }
]
