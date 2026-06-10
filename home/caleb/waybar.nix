{ ... }:

{
  catppuccin.waybar.enable = false;

  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        margin-top = 5;
        margin-left = 5;
        margin-right = 5;

        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "clock#date" ];
        modules-right = [
          "pulseaudio"
          "network"
          "clock#time"
          "tray"
          "custom/power"
        ];

        "hyprland/workspaces" = {
          disable-scroll = true;
          sort-by-number = true;
          format = "󱄅";
        };

        "clock#date" = {
          format = "{:%A, %B %d}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "month";
            on-click-right = "mode";
            format = {
              months = "<span color='#cba6f7'><b>{}</b></span>";
              days = "<span color='#cdd6f4'>{}</span>";
              weekdays = "<span color='#89b4fa'><b>{}</b></span>";
              today = "<span color='#fab387'><b><u>{}</u></b></span>";
            };
          };
        };

        network = {
          format-wifi = "󰤨";
          format-ethernet = "󰈀";
          format-disconnected = "󰤭";
          tooltip-format-wifi = "{essid}  {signalStrength}%\n{ipaddr}";
          tooltip-format-ethernet = "{ifname}  {ipaddr}";
        };

        "clock#time" = {
          format = " {:%H:%M}";
          tooltip = false;
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "󰝟 ";
          format-icons.default = [ "󰕿" "󰖀" "󰕾" ];
          on-click = "pavucontrol";
          on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%+";
          on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-";
        };

        tray = {
          icon-size = 18;
          spacing = 8;
        };

        "custom/power" = {
          tooltip = false;
          on-click = "wlogout &";
          format = "󰐥";
        };
      };
    };

    style = /* css */ ''
      @define-color base      #1e1e2e;
      @define-color mantle    #181825;
      @define-color crust     #11111b;
      @define-color text      #cdd6f4;
      @define-color subtext0  #a6adc8;
      @define-color surface0  #313244;
      @define-color surface1  #45475a;
      @define-color overlay0  #6c7086;
      @define-color blue      #89b4fa;
      @define-color lavender  #b4befe;
      @define-color sapphire  #74c7ec;
      @define-color sky       #89dceb;
      @define-color green     #a6e3a1;
      @define-color yellow    #f9e2af;
      @define-color peach     #fab387;
      @define-color maroon    #eba0ac;
      @define-color red       #f38ba8;
      @define-color mauve     #cba6f7;

      * {
        font-family: "Iosevka Nerd Font";
        font-size: 20px;
        min-height: 0;
        border: none;
        border-radius: 0;
      }

      window#waybar {
        background-color: transparent;
        color: @text;
      }

      /* ── Workspaces ── */
      #workspaces {
        background-color: @base;
        border-radius: 8px;
        margin: 5px 4px;
        padding: 0 8px 0 4px;
      }

      #workspaces button {
        all: unset;
        color: @overlay0;
        padding: 5px 10px;
        border-radius: 6px;
        transition: color 0.15s ease;
      }

      #workspaces button.active {
        color: @lavender;
      }

      #workspaces button.urgent {
        color: @red;
      }

      #workspaces button:hover {
      }

      /* ── Shared module pill styles ── */
      #clock.date,
      #clock.time,
      #pulseaudio,
      #network,
      #tray,
      #custom-power {
        background-color: @base;
        padding: 0 12px;
        margin: 5px 0;
      }
      
      /* Left caps */
      #pulseaudio {
        border-radius: 8px 0 0 8px;
        margin-left: 4px;
        color: @maroon;
      }

      /* Internal joins — no radius */
      #network {
        border-radius: 0;
        color: @blue;
      }

      #clock.time {
        border-radius: 0 8px 8px 0;
        color: @green;
      }

      /* Standalone pills */
      #clock.date {
        border-radius: 8px;
        color: @mauve;
        padding: 0 16px;
      }

      #tray {
        border-radius: 8px;
        margin-left: 12px;
        margin-right: 4px;
      }

      #custom-power {
        border-radius: 8px;
        margin-left: 8px;
        margin-right: 4px;
        padding-right: 14px;
        color: @red;
      }

      tooltip {
        background: @base;
        border: 1px solid @surface1;
        border-radius: 8px;
        color: @text;
      }
    '';
  };
}
