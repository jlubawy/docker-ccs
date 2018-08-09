FROM ubuntu:16.04

# Update and install all packages as listed here:
# http://processors.wiki.ti.com/index.php/Linux_Host_Support_CCSv6#Ubuntu_16.04_64bit
#
# Other essential packages:
#   * at-spi2-core: for warning solved here https://github.com/NixOS/nixpkgs/issues/16327
#   * libpython2.7: ti.xpcom dependency
#
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        at-spi2-core \
        binutils \
        gtk2-engines-murrine:i386 \
        libasound2:i386 \
        libatk1.0-0:i386 \
        libc6:i386 \
        libcairo2:i386 \
        libcanberra-gtk-module:i386 \
        libcups2:i386 \
        libdbus-glib-1-2:i386 \
        libgconf-2-4:i386 \
        libgcrypt20:i386 \
        libgdk-pixbuf2.0-0:i386 \
        libgnomeui-0:i386 \
        libgtk-3-0:i386 \
        libice6:i386 \
        libncurses5:i386 \
        liborbit2:i386 \
        libpython2.7 \
        libsm6:i386 \
        libstdc++6:i386 \
        libudev1:i386 \
        libusb-0.1-4:i386 \
        libusb-1.0-0-dev:i386 \
        libx11-6:i386 \
        libxt6:i386 \
        libxtst6:i386 \
        unzip

# Unattended response file generated on Windows using the following command:
# ccs_setup_8.1.0.00011.exe --save-response-file %TEMP%\ccs_installer_responses.txt --skip-install true
COPY ccs_installer_responses.txt /x/

# Download and install CCS
RUN apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
    && mkdir -p /x \
    && curl -L http://software-dl.ti.com/ccs/esd/CCSv8/CCS_8_1_0/exports/CCS8.1.0.00011_linux-x64.tar.gz | tar xvz --strip-components=1 -C /x \
    && apt-get remove -y \
        ca-certificates \
        curl \
    && /x/ccs_setup_linux64_8.1.0.00011.bin --mode unattended --response-file /x/ccs_installer_responses.txt \
    && rm -rf /x/
