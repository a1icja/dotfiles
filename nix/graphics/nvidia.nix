{
  config,
  lib,
  pkgs,
  ...
}:
{
  # Creates separate boot entry for using GPU
  specialisation = {
    nvidia.configuration = {
      # Nvidia Configuration
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware.graphics.enable = true;

      # nvidia-drm.modeset=1 is required for some wayland compositors, e.g. sway
      hardware.nvidia.modesetting.enable = true;

      # Fixes Suspend - don't ask me why
      hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.latest;
      hardware.nvidia.open = false;
      hardware.nvidia.powerManagement.enable = true;
      
      hardware.nvidia.nvidiaSettings = true;

      hardware.nvidia.prime = {
        sync.enable = true;

        # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
        nvidiaBusId = "PCI:1:0:0";

        # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
        intelBusId = "PCI:0:2:0";
      };
    };
  };
}
