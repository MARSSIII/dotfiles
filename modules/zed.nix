{ config, ... }:

let
  zedConfigDir = "${config.home.homeDirectory}/.config/.dotfiles/configs/zed";
in
{
  home.file = {
    ".config/zed/settings.json".source =
      config.lib.file.mkOutOfStoreSymlink "${zedConfigDir}/settings.json";
    ".config/zed/keymap.json".source =
      config.lib.file.mkOutOfStoreSymlink "${zedConfigDir}/keymap.json";
    ".config/zed/tasks.json".source =
      config.lib.file.mkOutOfStoreSymlink "${zedConfigDir}/tasks.json";
  };
}
