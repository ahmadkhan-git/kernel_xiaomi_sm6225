# Use the official Arch Linux image
FROM archlinux:latest

# Set the timezone environment variable
ENV TZ=Etc/UTC

# Update the system and install base-devel and other essential tools
RUN pacman -Syu --noconfirm \
    && pacman -S --noconfirm base-devel git vim sudo curl wget ccache automake lzop bison gperf base-devel zip curl zlib gcc-multilib libxml2 bzip2 squashfs-tools pngcrush schedtool dpkg lz4 make optipng cpio less python nano bc

# Create the gitpod group with the specific GID
RUN groupadd -g 33333 gitpod

# Create the gitpod user with the specific UID and GID, and add to sudoers
RUN useradd -u 33333 -g 33333 -m -s /bin/bash gitpod \
    && echo 'gitpod ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/99_gitpod \
    && chmod 440 /etc/sudoers.d/99_gitpod

# Switch to the non-root user
USER gitpod
WORKDIR /home/gitpod

# Set the default command to start a bash shell
CMD ["/bin/bash"]
