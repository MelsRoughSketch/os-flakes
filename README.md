# NixOS-WSL Configuration

## Usage

1. Install NixOS on WSL.
2. Clone this repository into `/etc/nixos`.
3. Run the `Initial build` command below.

### Initial build

```sh
sudo env NIX_CONFIG='experimental-features = nix-command flakes' \
  nixos-rebuild switch \
  --flake path:/etc/nixos#wsl
```

### Apply changes

```sh
sudo nixos-rebuild switch --flake path:/etc/nixos#wsl
```
