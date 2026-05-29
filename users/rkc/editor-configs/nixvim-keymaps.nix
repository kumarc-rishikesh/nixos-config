[
  # Open Neotree file explorer
  {
    key = ''\'';
    action = ":Neotree<CR>";
  }
  # Stay in indent mode after shifting left
  {
    mode = "v";
    key = "<";
    action = "<gv";
  }
  # Stay in indent mode after shifting right
  {
    mode = "v";
    key = ">";
    action = ">gv";
  }
  # Keep cursor centered when cycling forward through search results
  {
    mode = "n";
    key = "n";
    action = "nzzzv";
  }
  # Keep cursor centered when cycling backward through search results
  {
    mode = "n";
    key = "N";
    action = "Nzzzv";
  }
  # Next buffer
  {
    mode = "n";
    key = "<Tab>";
    action = ":bnext<CR>";
  }
  # Previous buffer
  {
    mode = "n";
    key = "<S-Tab>";
    action = ":bprevious<CR>";
  }
  # Force close current buffer
  {
    mode = "n";
    key = "<leader>x";
    action = ":bdelete!<CR>";
  }
  # New empty buffer
  {
    mode = "n";
    key = "<leader>b";
    action = "<cmd> enew <CR>";
  }
  # Vertical split
  {
    mode = "n";
    key = "<leader>v";
    action = "<C-w>v";
  }
  # Close current split
  {
    mode = "n";
    key = "<leader>xs";
    action = ":close<CR>";
  }
  # Move to right split
  {
    mode = "n";
    key = "<C-l>";
    action = ":wincmd l<CR>";
  }
  # Move to split below
  {
    mode = "n";
    key = "<C-j>";
    action = ":wincmd j<CR>";
  }
  # Move to split above
  {
    mode = "n";
    key = "<C-k>";
    action = ":wincmd k<CR>";
  }
  # Move to left split
  {
    mode = "n";
    key = "<C-h>";
    action = ":wincmd h<CR>";
  }
  # Paste without overwriting the default register
  {
    mode = "v";
    key = "p";
    action = ''"_dp'';
  }
  # Go to previous diagnostic
  {
    mode = "n";
    key = "[d";
    action.__raw = "vim.diagnostic.goto_prev";
  }
  # Go to next diagnostic
  {
    mode = "n";
    key = "]d";
    action.__raw = "vim.diagnostic.goto_next";
  }
  # Show diagnostic float for current line
  {
    mode = "n";
    key = "<leader>d";
    action.__raw = "vim.diagnostic.open_float";
  }
  # Send diagnostics to location list
  {
    mode = "n";
    key = "<leader>q";
    action.__raw = "vim.diagnostic.setloclist";
  }
  # Yank selection to system clipboard
  {
    mode = "v";
    key = "<leader>y";
    action = ''"+y'';
  }
  # Yank line to system clipboard
  {
    mode = "n";
    key = "<leader>y";
    action = ''"+y'';
  }
  # Delete without yanking (black hole register)
  {
    mode = [
      "n"
      "v"
    ];
    key = "<A-d>";
    action = ''_d'';
  }
  # Reset current git hunk
  {
    mode = "n";
    key = "<leader>gr";
    action = ":Gitsigns reset_hunk<CR>";
  }
  # Toggle git blame for current line
  {
    mode = "n";
    key = "<leader>gb";
    action = ":Gitsigns blame<CR>";
  }
  # Open git diff for all changed files
  {
    mode = "n";
    key = "<leader>gd";
    action = ":DiffviewOpen<CR>";
  }
  # View current file's git history
  {
    mode = "n";
    key = "<leader>gf";
    action = ":DiffviewFileHistory %<CR>";
  }
]
