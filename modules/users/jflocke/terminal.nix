{ config, pkgs, ... }:

{
    # Shell setup
    programs.fish = {
        enable = true;
        interactiveShellInit = ''
          set fish_greeting # Disable greeting
        '';
        # Configure fish shell
        shellAliases = {
            btw = "echo I use nixos, btw";
        };
    };

    home.sessionVariables = {
        SHELL = "${pkgs.fish}/bin/fish";
    };

    # Starship prompt
    programs.starship = {
        enable = true;
        # Configuration written to ~/.config/starship.toml
        settings = {
            add_newline = false;

            # character = {
            #   success_symbol = "[➜](bold green)";
            #   error_symbol = "[➜](bold red)";
            # };

            # package.disabled = true;
        };
    };

    # catppuccin theme
    catppuccin.enable = true;
    catppuccin.flavor = "mocha"; # Options: latte, frappe, macchiato, mocha
    
    programs = {
        bat.catppuccin. enable = true;
        starship.catppuccin.enable = true;
        fish.catppuccin.enable = true;
        alacritty.catppuccin.enable = true;
        btop.catppuccin.enable = true;
        fzf.catppuccin.enable = true;
        # eza.catppuccin.enable = true;
    };

    # zoxide for smarter cd
    programs.zoxide = {
        enable = true;
        enableFishIntegration = true;
        options = [
            "--cmd cd"
        ];
    };

    # fzf configuration
    programs.fzf = {
        enable = true;
        enableFishIntegration = true;
        # Optionally, you can add extra options:
        # defaultOptions = [ "--height 40%" "--border" ];
    };

    programs.eza = {
        enable = true;
        enableFishIntegration = true;
        icons = "auto";
        colors = "auto";
        git = true;
        extraOptions = [
            "--group-directories-first"
            "--no-quotes"
            "--header" # Show header row
            "--git-ignore"
            "--icons=always"
            # "--time-style=long-iso" # ISO 8601 extended format for time
            "--classify" # append indicator (/, *, =, @, |)
            "--hyperlink" # make paths clickable in some terminals
        ];
    };

    programs.zellij = {
        enable = true;
        enableFishIntegration = true;
    };

    home.shellAliases = {
        ls = "eza";
        ll = "eza -la --long";
        l = "eza -la --long --git";
        cat = "bat";
        f = "fzf";
        tldr = "tlrc";
    };

    # Terminal utilities
    home.packages = with pkgs; [
        bat             # Better cat
        tldr            # Simplified man pages
        scc             # Sloc, complexity and code metrics
        btop            # Resource monitor
        procs           # Better top command
        ripgrep         # Fast grep alternative
        tree            # Tree command replacement
        gping           # Ping with a graph
        speedtest-cli   # Speed test from terminal
        ddgr            # DuckDuckGo search from terminal
        lazygit         # A simple terminal UI for git commands
        asciinema       # Terminal screen recorder
    ];
    
}