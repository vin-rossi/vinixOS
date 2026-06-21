{ pkgs, inputs, ... }:
{
  home-manager.users.rhea = {
    
    imports = [
      inputs.noctalia.homeModules.default
    ];
    
     programs.noctalia = {
      enable = true;
      settings = {
        # configure noctalia here
        bar = {
          density = "compact";
          position = "top";
          showCapsule = true;
          widgets = {
            left = [
              {
                id = "ControlCenter";
                useDistroLogo = true;
              }
              {
                hideUnoccupied = false;
                id = "Workspace";
                labelMode = "none";
              }
              {
                id = "SystemMonitor";
              }
            ];
            center = [
            {
              id = "MediaMini";
            }
            ];
            right = [
              {
                id = "Volume";
              }
              {
                id = "Network";
              }
              {
                id = "Bluetooth";
              }
              {
                alwaysShowPercentage = true;
                id = "Battery";
                warningThreshold = 30;
              }
              {
                formatHorizontal = "HH:mm";
                formatVertical = "HH mm";
                id = "Clock";
                useMonospacedFont = true;
                usePrimaryColor = true;
              }
            ];
          };
        };
        colorSchemes.predefinedScheme = "Monochrome";
        general = {
          radiusRatio = 0.2;
        };
        location = {
          monthBeforeDay = true;
          name = "Boston, US";
          useFahrenheit = true;
        };
      };
      # this may also be a string or a path to a JSON file.
    };
  };
}

