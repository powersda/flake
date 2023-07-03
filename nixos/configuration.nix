# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }@inputs:

{
    system.stateVersion = "23.05"; # Did you read the comment?
    imports = [ # Include the results of the hardware scan.
        ./hardware-configuration.nix
    ];

    # BOOT
    boot = {
        loader.systemd-boot.enable = true;
        loader.systemd-boot.configurationLimit = 4;
        loader.efi.canTouchEfiVariables = true;
        initrd.luks.devices.crypted.device = "/dev/nvme0n1p2";
        initrd.luks.devices.crypted.preLVM = true;
        kernelParams = [];
        kernelModules = [];
    };

    # NETWORKING
    networking = {
        hostName = "powrNix";
        hosts = { };
        usePredictableInterfaceNames = true;
        #interfaces.wlan0.name = "wlp3s0";
        #interfaces.eth0.name = "enp5s0";
        useDHCP = true;
        nameservers = [];
        defaultGateway = null;
        supplicant = {
            "wlp3s0" = {
                configFile.path = "/etc/wpa_supplicant.conf";
                configFile.writable = true;
                userControlled.enable = true;
            };
        };
    };

    # BLUETOOTH
    hardware.bluetooth = {
        enable = true;
        powerOnBoot = false;
    };

    # SWAP
    swapDevices = [{
        device = "/var/lib/swapfile";
        size = 8 * 1024;
    }];

    # USER
    users = {
        users.pwrhs.isNormalUser = true;
        users.pwrhs.extraGroups = [ "wheel" "video"];
        users.pwrhs.initialPassword = "password";
    };

    # LOCALE
    time.timeZone = "Canada/Eastern";
    i18n.defaultLocale = "en_US.UTF-8";

    # FONTS
    fonts.fonts = with pkgs; [
        (nerdfonts.override { fonts = [ "Ubuntu" "Hack" ]; })
    ];

    # SECURITY
    security.pam.services = {
        swaylock.text = "auth include login";
    };

    # POWER
    powerManagement = {
        enable = true;
        powertop.enable = true;
    };

    
    # MODULES
    programs = {
        light.enable = true;
        htop.enable = true;
        hyprland = {
            enable = true;
            package = inputs.hyprland.packages.${inputs.system}.hyprland;
        };
    };

    # SERVICES
    services = {
        tlp.enable = true;
        pipewire = {
            enable = true;
            audio.enable = true;
            pulse.enable = true;
            alsa.enable = true;
        };
    };

    # PACKAGES
    environment.systemPackages = with pkgs; [
        wget
        curl
        dig
        whois
        killall
        powertop
    ];

    # NIX
    nix = {
        extraOptions = "experimental-features = nix-command flakes";
        settings.auto-optimise-store = true;
    };
    

    # TODO:
    # Virtd
    # gnupg
    # IRC
}

