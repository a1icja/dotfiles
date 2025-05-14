{
  config,
  pkgs,
  services,
  ...
}:
{
  # NixOS Power Management
  powerManagement = {
    enable = true;
    powertop.enable = true;
    cpuFreqGovernor = "ondemand";
  };


  # Prevents overheating
  services.thermald.enable = false;

  # Conflicts with TLP
  services.power-profiles-daemon.enable = false;

  # services.auto-cpufreq.enable = false;

  services.tlp = {
    enable = true;
    settings = {
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 20;

      INTEL_GPU_MIN_FREQ_ON_BAT = 500;

      #Optional helps save long term battery health
      START_CHARGE_THRESH_BAT0 = 75; # 75 and bellow it starts to charge
      STOP_CHARGE_THRESH_BAT0 = 85; # 85 and above it stops charging

    };
  };
}
