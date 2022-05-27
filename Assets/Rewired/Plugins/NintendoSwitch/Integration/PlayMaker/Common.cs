using UnityEngine;
using System.Collections.Generic;

namespace Rewired.Integration.PlayMaker.NintendoSwitch {

    using HutongGames.PlayMaker;
    using HutongGames.PlayMaker.Actions;
    using HutongGames.Extensions;
    using HutongGames.Utility;
    using System;
    using Rewired.Platforms.Switch;

    public static class Tools {

        public static Controller.Extension GetControllerExtension(Joystick joystick, SwitchControllerExtensionType extensionType) {
            if(joystick == null) return null;
            switch(extensionType) {
                case SwitchControllerExtensionType.SwitchGamepadExtension: return joystick.GetExtension<SwitchGamepadExtension>();
                case SwitchControllerExtensionType.JoyConExtension: return joystick.GetExtension<JoyConExtension>();
                case SwitchControllerExtensionType.DualJoyConExtension: return joystick.GetExtension<DualJoyConExtension>();
                case SwitchControllerExtensionType.HandheldExtension: return joystick.GetExtension<HandheldExtension>();
                default:
                    return null;
            }
        }
    }

    public static class Consts { // do not change the name of this - used in reflection to detect that this is installed
        
        public const string playMakerActionCategory = "Rewired Nintendo Switch";
    }

    public enum SwitchControllerExtensionType {
        SwitchGamepadExtension = 0,
        JoyConExtension = 1,
        DualJoyConExtension = 2,
        HandheldExtension = 3
    }
}
