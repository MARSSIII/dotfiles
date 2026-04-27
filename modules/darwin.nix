{
  pkgs,
  username,
  hostname,
  ...
}:

{
  networking = {
    computerName = hostname;
    hostName = hostname;
    localHostName = hostname;
  };

  # Determinate Nix manages itself
  nix.enable = false;

  nixpkgs.config.allowUnfree = true;

  security.pam.services.sudo_local.touchIdAuth = true;

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };

  system = {
    stateVersion = 5;

    primaryUser = username;

    defaults = {
      dock = {
        autohide = true;
        autohide-delay = 0.0;
        autohide-time-modifier = 0.2;
        show-recents = false;
        mru-spaces = false;
        minimize-to-application = true;
      };

      finder = {
        ShowPathbar = true;
        ShowStatusBar = true;
        FXPreferredViewStyle = "Nlsv";
        FXDefaultSearchScope = "SCcf";
        FXEnableExtensionChangeWarning = false;
        AppleShowAllFiles = true;
        AppleShowAllExtensions = true;
      };

      NSGlobalDomain = {
        _HIHideMenuBar = false;
        KeyRepeat = 2;
        InitialKeyRepeat = 15;
        ApplePressAndHoldEnabled = false;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
      };

      LaunchServices.LSQuarantine = false;
      screencapture.location = "~/Pictures/Screenshots";
      loginwindow.GuestEnabled = false;
    };
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.monaspace
    nerd-fonts.symbols-only
  ];

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };

    brews = [
      "mas"
      "powerlevel10k"
      "gemini-cli"
      "felixkratz/formulae/borders"
    ];

    taps = [
      "felixkratz/formulae"
      "nikitabobko/tap"
    ];

    casks = [
      "nikitabobko/tap/aerospace"
      "1password"
      "claude-code"
      "alt-tab"
      "amneziavpn"
      "arc"
      "balenaetcher"
      "capacities"
      "claude"
      "cursor"
      "discord"
      "figma"
      "ghostty"
      "google-chrome"
      "iina"
      "jetbrains-toolbox"
      "linear-linear"
      "mac-mouse-fix"
      "mattermost"
      "moonlight"
      "obs"
      "obsidian"
      "ollama-app"
      "orbstack"
      "pritunl"
      "qbittorrent"
      "qobuz"
      "raindropio"
      "raycast"
      "rustdesk"
      "signal"
      "spotify"
      "steam"
      "telegram"
      "tidal"
      "todoist-app"
      "utm"
      "via"
      "visual-studio-code"
      "whatsapp"
      "yaak"
      "zed"
      "zoom"
      "actual"
      "homerow"
      "input-source-pro"
      "mactex"
      "skim"
    ];

    masApps = {
      "Keynote" = 409183694;
      "Numbers" = 409203825;
      "Pages" = 409201541;
    };
  };

  programs.zsh.enable = true;
  environment.shells = [ pkgs.zsh ];
}
