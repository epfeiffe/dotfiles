# dotfiles
All of my public dotfiles.

Installation
------------
```
git clone https://github.com/epfeiffe/dotfiles.git
rsync -av dotfiles/ ~/
rm -rf dotfiles/
./.installVimPlugins        # Optional
```

### Warning
This will overwrite your exsisting dotfiles, so be careful. Certain plugins in the .vimrc may also not work since they will also need to be downloaded, so the script .installVimPlugins has been provided to install the correct tools. Check the bottom of the .vimrc file for additional details. 
### Sidenote
I am using Windows Subsystem for Linux which uses the bash shell, not all configurations may transfer correctly to other shells.
