{ config, pkgs, ... }:

{
  programs.nixvim = {
    enable = true;

    # Theme
    colorschemes.catppuccin = {
      enable = true;
      # flavour = "mocha"; # latte, frappe, macchiato, mocha
    };

    # Treesitter for syntax highlighting
    plugins.treesitter = {
      enable = true;
      settings = {
        ensure_installed = [
          "lua" "nix" "python" "rust" "javascript" "typescript"
          "html" "css" "json" "yaml" "toml" "markdown"
          "c" "cpp" "verilog" "bash"
        ];
      };
    };


    # Markdown preview
    plugins.markdown-preview.enable = true;

    # Statusline
    # plugins.lualine.enable = true;

    # File explorer + fuzzy finder
    plugins.nvim-tree.enable = true;
    plugins.telescope.enable = true;
    plugins.web-devicons.enable = true;

    # Autocompletion
    plugins = {
      cmp = {
        enable = true;
        autoEnableSources = false;
        settings.sources = [
          { name = "nvim_lsp"; }
          { name = "path"; }
          { name = "buffer"; }
        ];
      };
      cmp-nvim-lsp.enable = true;
      cmp-path.enable = true;
      cmp-buffer.enable = true;
    };
    plugins.luasnip.enable = true;
    plugins.glow.enable = true;

    # LSP servers
    plugins.lsp = {
      enable = true;
      servers = {
        lua_ls.enable = true;
        rust_analyzer.enable = true;
        pyright.enable = true;
        clangd.enable = true;       # C/C++
        verible.enable = true;      # Verilog/SystemVerilog
        tsserver.enable = true;     # JS/TS
        html.enable = true;
        cssls.enable = true;
        jsonls.enable = true;
        yamlls.enable = true;
      };
    };

    # Debugging (DAP)
    plugins.dap.enable = true;
    plugins.dap-ui.enable = true;

    # Git integration
    plugins.gitsigns.enable = true;

    # Quality of life
    plugins.comment.enable = true;       # `gc` to comment
    plugins.which-key.enable = true;     # keybinding hints
    plugins.nvim-autopairs.enable = true;     # auto close brackets/quotes
    plugins.bufferline.enable = true;    # tab-like bufferline
    plugins.toggleterm.enable = true;    # integrated terminal

    globals.mapleader = " ";

    # Extra Lua config
    extraConfigLua = ''
      -- UI
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.termguicolors = true

      -- Indentation
      vim.opt.tabstop = 4
      vim.opt.shiftwidth = 4
      vim.opt.expandtab = true
      vim.opt.smartindent = true

      -- Search
      vim.opt.ignorecase = true
      vim.opt.smartcase = true

      -- Clipboard
      vim.opt.clipboard = "unnamedplus"

      -- Telescope keymaps
      vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
      vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
      vim.keymap.set("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help tags" })

      -- Nvim-tree toggle
      vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "File Explorer" })
    '';
  };
}
