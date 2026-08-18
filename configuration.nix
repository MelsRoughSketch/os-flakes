# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ inputs, pkgs, username, ... }:

{
  wsl.enable = true;
  wsl.defaultUser = username;
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
  };

  nixpkgs.config.allowUnfree = true;

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  environment = {
    systemPackages = with pkgs; [
      git
      vim
    ];
    sessionVariables = {
      COLORTERM = "truecolor";
    };
  };

  programs.bash.interactiveShellInit = ''
      nixos-update() {
      (
        set -e
        cd /etc/nixos

        case "''${1:-all}" in
          all)
            nix flake update
            ;;
          stable)
            nix flake update nixpkgs home-manager
            ;;
          unstable)
            nix flake update nixpkgs-unstable
            ;;
          *)
            echo "Usage: nixos-update [all|stable|unstable]" >&2
            exit 2
            ;;
        esac

        sudo nixos-rebuild switch --flake path:/etc/nixos#wsl
      )
    }
  '';

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs username; };
    users.${username} = import ./home.nix;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?
}
