{ config, pkgs, ... }:

{
  programs.nixvim = {
    enable = true;

    # Theme
    colorschemes.catppuccin = {
      enable = true;
      flavour = "mocha"; # latte, frappe, macchiato, mocha
    };

    # Syntax highlighting
    plugins.treesitter = {
      enable = true;
      ensureInstalled = [ "lua" "nix" "python" "rust" "javascript" "typescript" "html" "css" "json" "yaml" "toml" "markdown"];
    };

    # Markdown preview
    markdown-preview = {
      enable = true;
    };

    # Statusline
    plugins.lualine.enable = true;

    # Autocompletion
    plugins.nvim-cmp = {
      enable = true;
      sources = [ "nvim_lsp" "buffer" "path" ];
    };

    # LSP
    plugins.lsp = {
      enable = true;
      servers = {
        lua_ls.enable = true;
        rust_analyzer.enable = true;
        pyright.enable = true;
      };
    };

    # Extra Lua config if needed
    extraConfigLua = ''
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.termguicolors = true

      vim.opt.tabstop = 4        -- number of spaces a <Tab> counts for
      vim.opt.shiftwidth = 4     -- spaces for autoindent
      vim.opt.expandtab = true   -- convert tabs to spaces
      vim.opt.smartindent = true -- smart autoindenting
    '';
  };
}
