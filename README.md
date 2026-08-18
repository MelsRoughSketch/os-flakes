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

After the initial build, use the `nrs` alias to apply configuration changes:

```sh
nrs
```

This alias runs:

```sh
sudo nixos-rebuild switch --flake path:/etc/nixos#wsl
```

### Update flake inputs

Update all flake inputs and apply the new configuration:

```sh
nixos-update
```

Update only the stable inputs (`nixpkgs` and `home-manager`):

```sh
nixos-update stable
```

Update only `nixpkgs-unstable`:

```sh
nixos-update unstable
```
