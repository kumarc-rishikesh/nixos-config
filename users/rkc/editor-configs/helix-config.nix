{
  settings = {
    enable = true;
    settings = {
      theme = "gruvbox_dark_hard";
      editor = {
        lsp.display-messages = true;
      };
      keys.normal = {
        space.r = ":reset-diff-change";
        C-e = "goto_line_end";
        C-a = "goto_line_start";
      };
    };
    languages = {
      language-server.haskell-language-server = {
        config.formattingProvider = "fourmolu";
      };
      language = [
        {
          name = "haskell";
          auto-format = true;
        }
        {
          name = "nix";
          auto-format = true;
          formatter = {
            command = "nixfmt";
          };
        }
        {
          name = "elixir";
          auto-format = true;
          formatter = {
            command = "mix format";
          };
        }
        {
          name = "scala";
          auto-format = true;
          formatter = {
            command = "scalafmt";
          };
        }
      ];
    };
  };
}
