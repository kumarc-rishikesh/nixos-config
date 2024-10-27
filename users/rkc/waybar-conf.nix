{
  style = ''
    * {
        border: none;
        border-radius: 0px;
        /*font-family: VictorMono, Iosevka Nerd Font, Noto Sans CJK;*/
        font-family: MesloLGS NF;
        font-size: 14.5px;
        font-style: normal;
        min-height: 0;
    }

    window#waybar {
        background: transparent; /*rgba(30, 30, 46, 0.5);*/
        color: #83A598;
    }

    #workspaces {
        background: #11111D; /* rgba(26,26,26,.9); */
        padding: 0 1rem;
        border-radius: 0.75rem;
       	margin: 5px 5px 5px 5px;
        padding: 0px 5px 0px 5px;
        border: solid 0px #f4d9e1;
        font-weight: normal;
        font-style: normal;
    }
    #workspaces button {
        padding: 0px 5px;
        border-radius: 15px;
        color: #7aa2f7;
    }

    #workspaces button.active {
        color: black;
        background-color: white;
        border-radius: 15px;
    }

    #workspaces button:hover {
    	background-color: transparent;
    	color: black;
    	border-radius: 15px;
    }


    #custom-date, #clock, #battery, #pulseaudio, #network, #custom-os_button {
    	background: transparent;
    	padding: 5px 5px 5px 5px;
    	margin: 5px 5px 5px 5px;
      border-radius: 8px;
      border: solid 0px #f4d9e1;
    }

    #tray {
        background: transparent;
        margin: 5px 5px 5px 5px;
        border-radius: 16px;
        padding: 0px 5px;
        /*border-right: solid 1px #282738;*/
    }

    #clock {
        background: #11111D; /* rgba(26,26,26,.9); */
        padding: 0 1rem;
        border-radius: 0.75rem;;
        color: #fff;
        margin-right: 15px;
        /*font-weight: bold;*/
        /*border-left: solid 1px #282738;*/
    }

    #battery {
        background: #11111D; /* rgba(26,26,26,.9); */
        padding: 0 1rem;
        border-radius: 0.75rem;;
        color: #fff;
        margin-right: 5px;
        /*font-weight: bold;*/
        /*border-left: solid 1px #282738;*/
    }

    #network {
        background: #11111D; /* rgba(26,26,26,.9); */
        padding: 0 1rem;
        border-radius: 0.75rem;;
        color: #fff;
        margin-right: 10px;
    }

    #pulseaudio {
        background: #11111D; /* rgba(26,26,26,.9); */
        padding: 0 1rem;
        border-radius: 0.75rem;;
        color: #fff;
        margin-right: 10px;
    }

    #pulseaudio.muted {
        background: #11111D; /* rgba(26,26,26,.9); */
        padding: 0 1rem;
        border-radius: 0.75rem;;
        color: red;
        margin-right: 9px;
    }

    #window {
        background: #282828;
        padding-left: 15px;
        padding-right: 15px;
        border-radius: 16px;
        /*border-left: solid 1px #282738;*/
        /*border-right: solid 1px #282738;*/
        margin-top: 5px;
        margin-bottom: 5px;
        font-weight: normal;
        font-style: normal;
    }

    #cpu {
        background: #282828;
        color: #83A598;
        border-radius: 16px;
        margin: 5px;
        margin-left: 5px;
        margin-right: 5px;
        padding: 0px 10px 0px 10px;
        font-weight: bold;
    }

    #memory {
        background: #282828;
        color: #83A598;
        border-radius: 16px;
        margin: 5px;
        margin-left: 5px;
        margin-right: 5px;
        padding: 0px 10px 0px 10px;
        font-weight: bold;
    }

    #disk {
        background-color: #282828;
        /*color: #8EC07C;*/
        border-radius: 16px;
        margin: 5px;
        margin-left: 5px;
        margin-right: 5px;
        padding: 0px 10px 0px 10px;
        font-weight: bold;
    }
  '';

  settings = [
    {
      height = 35;
      layer = "top";
      position = "top";
      margin-bottom = 0;
      modules-center = [ ];
      modules-left = [
        "hyprland/workspaces"
        "hyprland/window"
      ];
      modules-right = [
        "pulseaudio"
        "network"
        "cpu"
        "memory"
        # "temperature"
        "battery"
        "clock"
        "tray"
      ];
      "tray" = {
        "icon-size" = 18;
        "spacing" = 5;
        "show-passive-items" = true;
      };

      "hyprland/workspaces" = {
        all-outputs = true;
        on-scroll-up = "hyprctl dispatch workspace e+1";
        on-scroll-down = "hyprctl dispatch workspace e-1";
      };
      battery = {
        format = "{capacity}% {icon}";
        format-alt = "{time} {icon}";
        format-charging = "{capacity}% ";
        format-icons = [
          ""
          ""
          ""
          ""
          ""
        ];
        format-plugged = "{capacity}% ";
        states = {
          critical = 15;
          warning = 30;
        };
      };
      clock = {
        format-alt = "{:%Y-%m-%d}";
        tooltip-format = "{:%Y-%m-%d | %H:%M}";
      };
      cpu = {
        format = "{usage}% ";
        tooltip = false;
      };
      memory = {
        format = "{}% ";
      };
      network = {
        interval = 1;
        format-disconnected = "Disconnected ⚠";
        format-ethernet = "{ifname}: {ipaddr}/{cidr}   up: {bandwidthUpBits} down: {bandwidthDownBits}";
        format-linked = "{ifname} (No IP) ";
        format-wifi = "{essid} ({signalStrength}%) ";
        tooltip = false;
      };
      pulseaudio = {
        format = "{volume}% {icon} {format_source}";
        format-bluetooth = "{volume}% {icon} {format_source}";
        format-bluetooth-muted = " {icon} {format_source}";
        format-icons = {
          car = "";
          default = [
            ""
            ""
            ""
          ];
          headphones = "";
          phone = "";
          portable = "";
        };
        format-muted = " {format_source}";
        format-source = "{volume}% ";
        format-source-muted = "";
      };
    }
  ];
}
