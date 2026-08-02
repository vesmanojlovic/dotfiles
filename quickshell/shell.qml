//@ pragma UseQApplication

import Quickshell
import Quickshell.Io

import "modules" as Modules
import "services" as Services

ShellRoot {
    Variants {
        model: Quickshell.screens

        Modules.Bar {}
    }

    Variants {
        model: Quickshell.screens

        Modules.PowerMenu {}
    }

    IpcHandler {
        target: "powermenu"

        function toggle(): void {
            Services.PowerMenuState.toggle();
        }
    }
}
