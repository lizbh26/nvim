##Installing Neovim
Firstly, download the Neovim AppImage from [the Releases page](https://github.com/neovim/neovim/releases).
Or just execute this command to download the latest stable version:

```
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage
```

If the ./nvim.appimage command fails, try:


```
./nvim.appimage --appimage-extract
./squashfs-root/AppRun --version

# Then, expose the AppImage globally
mv squashfs-root nvim
sudo mv nvim /
sudo ln -s /nvim/AppRun /usr/bin/nvim
nvim
```

##Before opening
Clone the Packer repository:
```
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

##First time 
Inside Neovim run `:PackerSync` and the warnings will be gone.
