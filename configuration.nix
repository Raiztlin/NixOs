# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     git
#     unzip
     enlightenment.terminology
#     wget
     curl
#     wireshark
#     cutter
      dmenu
      #haskellPackages.xmobar
   ];

  # Bootloader
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

   networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
   networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
   time.timeZone = "Europe/Stockholm";

  # Activate virtualbox guest additions.
  virtualisation.virtualbox.guest.enable = true;
  virtualisation.virtualbox.guest.x11 = true;


  # Exlude default packages
  # services.gnome.core-utilities.enable = false;

  # Configure keymap, window- desktop- and displaymanager.
   services.xserver = {
     enable = true;
     layout = "se";
     xkbVariant = "mac";
     windowManager.xmonad = {
         enable = true;
         enableContribAndExtras = true;
     };
     desktopManager.xterm.enable = false;
     displayManager.defaultSession = "none+xmonad";
   };
  # Configure keymap in X11
  console.keyMap = "sv-latin1";



  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.gorb = {
     isNormalUser = true;
     extraGroups = [ "networkmanager" "wheel" ]; # Enable ‘sudo’ for the user.
     hashedPassword = "$6$eAv2VnGROIaWSh/Z$uoUfLQmCOG70Vy7Z3naoAqR6P1qIOzM1/WJmvLX3FUFWbkYXPsfF.LvrMHnDZKtpDho5YJ/q9ZPzGkV9uGU0o.";
   };





  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
   system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.11"; # Did you read the comment?

}

