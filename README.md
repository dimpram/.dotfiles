# ~/.dotfiles [WIP]

![Preview](https://user-images.githubusercontent.com/44473195/128847571-0301a148-1265-4467-b094-a296142948d5.png)



My configuration files for my 2021 Arch Linux rice which is based around Mac OS Big Sur. This configuration runs currently on my Xiaomi MI Air 13.3 2018 global edition and thus the bootstraping script contains some optional optimizations (disable nvidia GPU, screen calibration, drivers, keyboard...) that you can install in case that you have the same laptop.

## Programs

+ __WM:__ [dwm](https://github.com/dimpram/dwm/)
+ __Compositor:__ [ibhagwan/picom (for rounded corners)](https://github.com/ibhagwan/picom)
+ __GTK theme:__ [WhiteSur](https://github.com/vinceliuice/WhiteSur-gtk-theme)
+ __Launcher:__ [rofi (spotlight dark LR-tech theme)](https://github.com/lr-tech/rofi-themes-collection#squared-red)
+ __Notifications:__ [dunst](https://dunst-project.org/)
+ __Terminal:__ [urxvt](https://wiki.archlinux.org/title/Rxvt-unicode) + zsh
+ __Editor:__ [nvim](https://github.com/dimpram/.dotfiles/tree/master/.config/nvim), [vscode](https://code.visualstudio.com/)
+ __Image Viewer:__ [feh](https://feh.finalrewind.org/)
+ __File Manager:__ [vifm](https://vifm.info/)
+ __Browser:__ [firefox](https://www.mozilla.org/en-US/firefox/new/)
+ __Power:__ [tlp](https://wiki.archlinux.org/index.php/TLP)
+ __Hardware:__ [bashmount](https://github.com/jamielinux/bashmount)

## Getting Started

First clone the repo.
```
$ git clone --recurse-submodules https://github.com/dimpram/dotfiles.git ~/git/.dotfiles
```

After cloning the respository, update the submodules.
```
$ cd ~/git/.dotfiles && git submodule update --remote --merge
```

Finally, run the setup script.
```
# ./setup.sh
```

Once this script completes you'll be loaded into my build of dwm window manager with everything configured according to my configs (and preferences).

## Notes

In order to set up this rice you need to install Arch Linux and create a user. This can be done by following [the Arch Wiki](https://wiki.archlinux.org/index.php/Installation_guide).

The automatic bootstrap script uses `sudo`, so you'll need to ensure your user is apart of the `wheel` group.