# Clean up the nix store
sudo nix-store --gc
# Update the channel
sudo nix-channel --update
# Rebuild and switch to the new generation
sudo nixos-rebuild switch
# Delete old generations except the last 4
sudo nix-env -p /nix/var/nix/profiles/system --delete-generations +4
# Collect garbage
sudo nix-collect-garbage -d
# Remove old generations from /boot
sudo nixos-rebuild boot