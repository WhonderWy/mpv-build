#!/bin/sh
# A file that installs all dependencies I could find to build in an Arch Linux environment.

echo "Updating all packages"
sudo pacman -Syuu

printf "%s\n" --enable-nonfree    >> ffmpeg_options
printf "%s\n" --enable-libx264    >> ffmpeg_options
printf "%s\n" --enable-libmp3lame >> ffmpeg_options
printf "%s\n" --enable-libfdk-aac >> ffmpeg_options

printf "%s\n" -Dlibmpv=true > mpv_options

# git clone https://github.com/KhronosGroup/SPIRV-Cross.git

# cd SPIRV-Cross && mkdir build && cd build && cmake .. && cd .. && make -j4 && cd ..

echo "Downloading libraries"
pacman_packages=( base-devel cmake wayland meson ffmpeg python-pip python-pipx python-docutils python-pillow python-myst-parser python-pygments ninja yt-dlp libpulse pipewire noto-fonts noto-fonts-cjk noto-fonts-emoji libiconv lua lua52 luajit mujs pkgconfig libbluray libdvdnav libjpeg libarchive unzip libxkbcommon wayland-protocols libiconv smbclient libcdio libdvdnav libdvdread lcms2 rubberband sdl2 vapoursynth zimg jack openal fluidsynth sndio libcaca libdrm libjpeg shaderc libsixel libegl egl-wayland libva libvdpau libcdio libxpresent uchardet )
sudo pacman -S ${pacman_packages[*]}

echo "Downloading extra dependencies"
pipx install meson yt-dlp mitmproxy ffmpeg docutils pillow
pipx upgrade-all

git clone https://git.videolan.org/git/ffmpeg/nv-codec-headers.git
cd nv-codec-headers
make
sudo make install

cd ~/git/mpv-build

echo "Building..."
./rebuild -j4

echo "Installing"
sudo ./install
