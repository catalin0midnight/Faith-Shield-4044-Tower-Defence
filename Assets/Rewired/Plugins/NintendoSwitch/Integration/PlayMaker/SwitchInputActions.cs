using UnityEngine;
using System.Collections.Generic;

namespace Rewired.Integration.PlayMaker.NintendoSwitch {

    using HutongGames.PlayMaker;
    using HutongGames.PlayMaker.Actions;
    using HutongGames.Extensions;
    using HutongGames.Utility;
    using System;
    using Rewired.Platforms.Switch;

    #region Config

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Gets which Npad styles are supported.")]
    public class RewiredSwitchConfigGetAllowedNpadStyles : BaseFsmStateAction {

        [UIHint(UIHint.Variable)]
        [Tooltip("Npad type that represents full key operation mode. (Pro Controller)")]
        public FsmBool fullKey;

        [UIHint(UIHint.Variable)]
        [Tooltip("Npad type that represents handheld operation. (Joy-Cons attached to the Switch unit.")]
        public FsmBool handheld;

        [UIHint(UIHint.Variable)]
        [Tooltip("The Npad type representing Joy-Con dual-controller grip operations.")]
        public FsmBool joyConDual;

        [UIHint(UIHint.Variable)]
        [Tooltip("The Npad type representing Joy-Con (L) operations.")]
        public FsmBool joyConLeft;

        [UIHint(UIHint.Variable)]
        [Tooltip("The Npad type representing Joy-Con (R) operations.")]
        public FsmBool joyConRight;

        protected override bool defaultValue_everyFrame { get { return false; } }

        public override void Reset() {
            base.Reset();
            fullKey = false;
            handheld = false;
            joyConDual = false;
            joyConLeft = false;
            joyConRight = false;
        }

        protected override void DoUpdate() {
            NpadStyle styles = SwitchInput.Config.allowedNpadStyles;
            fullKey = (styles & NpadStyle.FullKey) != 0;
            handheld = (styles & NpadStyle.Handheld) != 0;
            joyConDual = (styles & NpadStyle.JoyConDual) != 0;
            joyConLeft = (styles & NpadStyle.JoyConLeft) != 0;
            joyConRight = (styles & NpadStyle.JoyConRight) != 0;
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Sets which Npad styles are supported.")]
    public class RewiredSwitchConfigSetAllowedNpadStyles : BaseFsmStateAction {

        [Tooltip("Npad type that represents full key operation mode. (Pro Controller)")]
        public FsmBool fullKey;

        [Tooltip("Npad type that represents handheld operation. (Joy-Cons attached to the Switch unit.")]
        public FsmBool handheld;

        [Tooltip("The Npad type representing Joy-Con dual-controller grip operations.")]
        public FsmBool joyConDual;

        [Tooltip("The Npad type representing Joy-Con (L) operations.")]
        public FsmBool joyConLeft;

        [Tooltip("The Npad type representing Joy-Con (R) operations.")]
        public FsmBool joyConRight;

        protected override bool defaultValue_everyFrame { get { return false; } }

        public override void Reset() {
            base.Reset();
            fullKey = false;
            handheld = false;
            joyConDual = false;
            joyConLeft = false;
            joyConRight = false;
        }

        protected override void DoUpdate() {
            NpadStyle style = NpadStyle.None;
            if(fullKey.Value) style |= NpadStyle.FullKey;
            if(handheld.Value) style |= NpadStyle.Handheld;
            if(joyConDual.Value) style |= NpadStyle.JoyConDual;
            if(joyConLeft.Value) style |= NpadStyle.JoyConLeft;
            if(joyConRight.Value) style |= NpadStyle.JoyConRight;
            SwitchInput.Config.allowedNpadStyles = style;
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip(
        "Gets the Joy-Con grip style. " +
        "Determines how the user should hold individual Joy-Cons. " +
        "Vertical: Joy-Con held like a remote control using one hand with L/R and ZL/ZR facing forward/up. " +
        "Horizontal: Joy-Con held like a gamepad with SL and SR facing forward/up. ")]
    public class RewiredSwitchConfigGetJoyConGripStyle : GetEnumFsmStateAction {

        [RequiredField, UIHint(UIHint.Variable), ObjectType(typeof(JoyConGripStyle))]
        [Tooltip("The enum value to store.")]
        public FsmEnum storeValue;

        protected override FsmEnum _storeValue { get { return storeValue; } set { storeValue = value; } }

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            UpdateStoreValue(SwitchInput.Config.joyConGripStyle);
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip(
        "Sets the Joy-Con grip style. " +
        "Determines how the user should hold individual Joy-Cons. " +
        "Vertical: Joy-Con held like a remote control using one hand with L/R and ZL/ZR facing forward/up. " +
        "Horizontal: Joy-Con held like a gamepad with SL and SR facing forward/up. ")]
    public class RewiredSwitchConfigSetJoyConGripStyle : BaseFsmStateAction {

        [RequiredField, ObjectType(typeof(JoyConGripStyle))]
        [Tooltip("The Joy-Con grip style.")]
        public FsmEnum joyConGripStyle;

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            SwitchInput.Config.joyConGripStyle = (JoyConGripStyle)joyConGripStyle.Value;
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip(
        "Gets whether IMU's should be adjusted for the current grip style. " +
        "If enabled, returned values from six-axis sensors " +
        "will be modified to reflect the Joy-Con grip style for single Joy-Cons. " +
        "When using a horizontal grip style, +Z points out from the SL/SR buttons. " +
        "When using a vertical grip style, +Z points out from the L/ZL/R/ZR buttons.")]
    public class RewiredSwitchConfigGetAdjustIMUsForGripStyle : GetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            UpdateStoreValue(SwitchInput.Config.adjustIMUsForGripStyle);
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip(
        "Sets whether IMU's should be adjusted for the current grip style. " +
        "If enabled, returned values from six-axis sensors " +
        "will be modified to reflect the Joy-Con grip style for single Joy-Cons. " +
        "When using a horizontal grip style, +Z points out from the SL/SR buttons. " +
        "When using a vertical grip style, +Z points out from the L/ZL/R/ZR buttons.")]
    public class RewiredSwitchConfigSetAdjustIMUsForGripStyle : SetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            SwitchInput.Config.adjustIMUsForGripStyle = value.Value;
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip(
        "Gets the Handheld Activation Mode. " +
        "Determines how many Joy-Cons must be attached for the Handheld mode to become active.")]
    public class RewiredSwitchConfigGetHandheldActivationMode : GetEnumFsmStateAction {

        [RequiredField, UIHint(UIHint.Variable), ObjectType(typeof(HandheldActivationMode))]
        [Tooltip("The enum value to store.")]
        public FsmEnum storeValue;

        protected override FsmEnum _storeValue { get { return storeValue; } set { storeValue = value; } }

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            UpdateStoreValue(SwitchInput.Config.handheldActivationMode);
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip(
        "Sets the Handheld Activation Mode. " +
        "Determines how many Joy-Cons must be attached for the Handheld mode to become active.")]
    public class RewiredSwitchConfigSetHandheldActivationMode : BaseFsmStateAction {

        [RequiredField, ObjectType(typeof(HandheldActivationMode))]
        [Tooltip("The Handheld activation mode.")]
        public FsmEnum handheldActivationMode;

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            SwitchInput.Config.handheldActivationMode = (HandheldActivationMode)handheldActivationMode.Value;
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip(
        "Gets Assign Joysticks by Npad Id. " +
        "If enabled, Joysticks will be assigned to Players based on the npad id of the controller. " +
        "Otherwise, the standard Rewired Joystick auto-assignment system will be used. " +
        "Enable this to keep the Switch npad id aligned to the Rewired Player id when Joysticks are assigned."
        )]
    public class RewiredSwitchConfigGetAssignJoysticksByNpadId : GetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            UpdateStoreValue(SwitchInput.Config.assignJoysticksByNpadId);
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip(
        "Sets Assign Joysticks by Npad Id. " +
        "If enabled, Joysticks will be assigned to Players based on the npad id of the controller. " +
        "Otherwise, the standard Rewired Joystick auto-assignment system will be used. " +
        "Enable this to keep the Switch npad id aligned to the Rewired Player id when Joysticks are assigned."
        )]
    public class RewiredSwitchConfigSetAssignJoysticksByNpadId : SetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            SwitchInput.Config.assignJoysticksByNpadId = value.Value;
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Gets the Is Allowed setting for a specific Npad id.")]
    public class RewiredSwitchConfigGetNpadSettingsIsAllowed : GetBoolFsmStateAction {

        [RequiredField, ObjectType(typeof(NpadId))]
        [Tooltip("The Npad Id.")]
        public FsmEnum npadId;

        public override void Reset() {
            base.Reset();
            npadId = NpadId.No1;
        }

        protected override void DoUpdate() {
            if((NpadId)npadId.Value == NpadId.Invalid) return;
            UpdateStoreValue(SwitchInput.Config.GetNpadSettings((NpadId)npadId.Value).isAllowed);
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Sets the Is Allowed setting for a specific Npad id.")]
    public class RewiredSwitchConfigSetNpadSettingsIsAllowed : SetBoolFsmStateAction {

        [RequiredField, ObjectType(typeof(NpadId))]
        [Tooltip("The Npad Id.")]
        public FsmEnum npadId;

        public override void Reset() {
            base.Reset();
            npadId = NpadId.No1;
        }

        protected override void DoUpdate() {
            if((NpadId)npadId.Value == NpadId.Invalid) return;
            SwitchInput.Config.GetNpadSettings((NpadId)npadId.Value).isAllowed = value.Value;
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Gets the Joy-Con Assignment Mode setting for a specific Npad id.")]
    public class RewiredSwitchConfigGetNpadSettingsJoyConAssignmentMode : GetEnumFsmStateAction {

        [RequiredField, ObjectType(typeof(NpadId))]
        [Tooltip("The Npad Id.")]
        public FsmEnum npadId;

        [RequiredField, UIHint(UIHint.Variable), ObjectType(typeof(JoyConAssignmentMode))]
        [Tooltip("The enum value to store.")]
        public FsmEnum storeValue;

        protected override FsmEnum _storeValue { get { return storeValue; } set { storeValue = value; } }

        public override void Reset() {
            base.Reset();
            npadId = NpadId.No1;
        }

        protected override void DoUpdate() {
            if((NpadId)npadId.Value == NpadId.Invalid) return;
            UpdateStoreValue(SwitchInput.Config.GetNpadSettings((NpadId)npadId.Value).joyConAssignmentMode);
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Sets the Joy-Con Assignment Mode setting for a specific Npad id.")]
    public class RewiredSwitchConfigSetNpadSettingsJoyConAssignmentMode : BaseFsmStateAction {

        [RequiredField, ObjectType(typeof(NpadId))]
        [Tooltip("The Npad Id.")]
        public FsmEnum npadId;

        [RequiredField, ObjectType(typeof(JoyConAssignmentMode))]
        [Tooltip("The Joy-Con Assignment Mode.")]
        public FsmEnum joyConAssignmentMode;

        public override void Reset() {
            base.Reset();
            npadId = NpadId.No1;
            joyConAssignmentMode = JoyConAssignmentMode.Dual;
        }

        protected override void DoUpdate() {
            if((NpadId)npadId.Value == NpadId.Invalid) return;
            SwitchInput.Config.GetNpadSettings((NpadId)npadId.Value).joyConAssignmentMode = (JoyConAssignmentMode)joyConAssignmentMode.Value;
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Gets the Rewired Player Id setting for a specific Npad id.")]
    public class RewiredSwitchConfigGetNpadSettingsRewiredPlayerId : GetIntFsmStateAction {

        [RequiredField, ObjectType(typeof(NpadId))]
        [Tooltip("The Npad Id.")]
        public FsmEnum npadId;

        public override void Reset() {
            base.Reset();
            npadId = NpadId.No1;
        }

        protected override void DoUpdate() {
            if((NpadId)npadId.Value == NpadId.Invalid) return;
            UpdateStoreValue(SwitchInput.Config.GetNpadSettings((NpadId)npadId.Value).rewiredPlayerId);
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Sets the Rewired Player Id setting for a specific Npad id.")]
    public class RewiredSwitchConfigSetNpadSettingsRewiredPlayerId : SetIntFsmStateAction {

        [RequiredField, ObjectType(typeof(NpadId))]
        [Tooltip("The Npad Id.")]
        public FsmEnum npadId;

        public override void Reset() {
            base.Reset();
            npadId = NpadId.No1;
        }

        protected override void DoUpdate() {
            if((NpadId)npadId.Value == NpadId.Invalid) return;
            SwitchInput.Config.GetNpadSettings((NpadId)npadId.Value).rewiredPlayerId = value.Value;
        }
    }

    /* REMOVED SUPPORT FOR DEBUG PAD
    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Gets the Enabled setting for the Debug Pad.")]
    public class RewiredSwitchConfigGetDebugPadSettingsEnabled : GetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            UpdateStoreValue(SwitchInput.Config.GetDebugPadSettings().enabled);
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Sets the Enabled setting for the Debug Pad.")]
    public class RewiredSwitchConfigSetDebugPadSettingsEnabled : SetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            SwitchInput.Config.GetDebugPadSettings().enabled = value.Value;
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Gets the Rewired Player Id setting for the Debug Pad.")]
    public class RewiredSwitchConfigGetDebugPadSettingsRewiredPlayerId : GetIntFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            UpdateStoreValue(SwitchInput.Config.GetDebugPadSettings().rewiredPlayerId);
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Sets the Rewired Player Id setting for the Debug Pad.")]
    public class RewiredSwitchConfigSetDebugPadSettingsRewiredPlayerId : SetIntFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            SwitchInput.Config.GetDebugPadSettings().rewiredPlayerId = value.Value;
        }
    }
    */

    #endregion

    #region Controller Applet

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Gets which Npad styles are supported.")]
    public class RewiredSwitchConfigShowControllerApplet : BaseFsmStateAction {

        [Tooltip("The minimum number of players that will get wireless controller connections. Ignored in single-player mode. [Min = 0, Max = 4]")]
        public FsmInt playerCountMin;

        [Tooltip("The maximum number of players that will get wireless controller connections. Ignored in single-player mode. [Min = 0, Max = 4]")]
        public FsmInt playerCountMax;

        [Tooltip("Specifies whether to maintain the connection of controllers that are already connected. Specify false to disconnect all controllers.")]
        public FsmBool keepConnections;

        [Tooltip("Specifies whether to collapse the controller numbers when the controller applet is ended. When false is specified, there may be gaps in controller numbers when the controller applet is ended. Ignored in single-player mode.")]
        public FsmBool collapseIds;

        [Tooltip("Specifies whether to permit actions when both controllers are being held in a dual-controller grip. When false is specified, actions cannot be made when both controllers are being held in a dual-controller grip. This is designed for times like during local communication when you want to prohibit the dual-controller grip.")]
        public FsmBool allowDualJoyCon;

        [Tooltip("Specifies whether to start the controller applet in single-player mode.")]
        public FsmBool singlePlayerMode;

        [Tooltip("Specifies whether to use colors to identify the individual controller numbers shown in the controller applet UI.")]
        public FsmBool showColors;

        [Tooltip("Specifies whether to use explanatory text for the individual controller numbers shown in the controller support UI.")]
        public FsmBool showLabels;

        [Tooltip("Specifies the colors to use to identify the individual controller numbers shown in the controller applet UI. If showColors is false, the values specified here will not be applied.")]
        public FsmColor player1Color;

        [Tooltip("The text to use for the individual controller number shown in the controller applet UI. You can specify up to 32 characters. If showLabels is false, the values specified here will not be applied. Check how the text actually displays to make sure it is not too long and otherwise displays appropriately.")]
        public FsmString player1Label;

        [Tooltip("Specifies the colors to use to identify the individual controller numbers shown in the controller applet UI. If showColors is false, the values specified here will not be applied.")]
        public FsmColor player2Color;

        [Tooltip("The text to use for the individual controller number shown in the controller applet UI. You can specify up to 32 characters. If showLabels is false, the values specified here will not be applied. Check how the text actually displays to make sure it is not too long and otherwise displays appropriately.")]
        public FsmString player2Label;

        [Tooltip("Specifies the colors to use to identify the individual controller numbers shown in the controller applet UI. If showColors is false, the values specified here will not be applied.")]
        public FsmColor player3Color;

        [Tooltip("The text to use for the individual controller number shown in the controller applet UI. You can specify up to 32 characters. If showLabels is false, the values specified here will not be applied. Check how the text actually displays to make sure it is not too long and otherwise displays appropriately.")]
        public FsmString player3Label;

        [Tooltip("Specifies the colors to use to identify the individual controller numbers shown in the controller applet UI. If showColors is false, the values specified here will not be applied.")]
        public FsmColor player4Color;

        [Tooltip("The text to use for the individual controller number shown in the controller applet UI. You can specify up to 32 characters. If showLabels is false, the values specified here will not be applied. Check how the text actually displays to make sure it is not too long and otherwise displays appropriately.")]
        public FsmString player4Label;

        [Tooltip("The number of players determined by the controller applet. Returns 0 if controller support is canceled. Ignored in single-player mode.")]
        [UIHint(UIHint.Variable)]
        public FsmInt playerCountResult;

        [Tooltip("The NpadIdType selected in single-player mode. If the controller applet is canceled, returns the NpadId with which it was canceled. This is invalid in anything other than single-player mode.")]
        [UIHint(UIHint.Variable), ObjectType(typeof(NpadId))]
        public FsmEnum selectedIdResult;

        [Tooltip("Event to send when applet returns a result.")]
        public FsmEvent finishedEvent;

        [Tooltip("Event to send if the applet fails to open.")]
        public FsmEvent failedEvent;

        protected override bool defaultValue_everyFrame { get { return false; } }

        public override void Reset() {
            base.Reset();
            playerCountMin = 0;
            playerCountMax = 1;
            keepConnections = true;
            collapseIds = true;
            allowDualJoyCon = true;
            singlePlayerMode = false;
            showColors = false;
            showLabels = false;
            player1Color = Color.white;
            player1Label = string.Empty;
            player2Color = Color.white;
            player2Label = string.Empty;
            player3Color = Color.white;
            player3Label = string.Empty;
            player4Color = Color.white;
            player4Label = string.Empty;
            playerCountResult = 0;
            selectedIdResult = NpadId.Invalid;
            finishedEvent = null;
            failedEvent = null;
        }

        protected override void DoUpdate() {
            if(playerCountMin.Value > playerCountMax.Value) {
                LogError("Player Count Min cannot be greater than Player Count Max.");
                return;
            }
            if(playerCountMin.Value < 0) {
                LogError("Player Count Min cannot be less than zero.");
                return;
            } else if(playerCountMin.Value > 4) {
                LogError("Player Count Min cannot be greater than 4.");
                return;
            }
            if(playerCountMax.Value < 0) {
                LogError("Player Count Max cannot be less than zero.");
                return;
            } else if(playerCountMax.Value > 4) {
                LogError("Player Count Max cannot be greater than 4.");
                return;
            }

            ControllerAppletOptions options = new ControllerAppletOptions();
            options.playerCountMin = playerCountMin.Value;
            options.playerCountMax = playerCountMax.Value;
            options.keepConnections = keepConnections.Value;
            options.collapseIds = collapseIds.Value;
            options.allowDualJoyCon = allowDualJoyCon.Value;
            options.singlePlayerMode = singlePlayerMode.Value;
            options.showColors = showColors.Value;
            options.showLabels = showLabels.Value;
            options.players[0].color = player1Color.Value;
            options.players[0].label = player1Label.Value;
            options.players[1].color = player2Color.Value;
            options.players[1].label = player2Label.Value;
            options.players[2].color = player3Color.Value;
            options.players[2].label = player3Label.Value;
            options.players[3].color = player4Color.Value;
            options.players[3].label = player4Label.Value;
            ControllerAppletResult result;
#if UNITY_SWITCH
            UnityEngine.Switch.Applet.Begin();
#endif
            bool success = SwitchInput.ControllerApplet.Show(options, out result);
#if UNITY_SWITCH
            UnityEngine.Switch.Applet.End();
#endif
            if(success) {
                playerCountResult = result.playerCount;
                selectedIdResult = result.selectedId;
                TrySendEvent(finishedEvent);
            } else {
                TrySendEvent(failedEvent);
            }
        }
    }

#endregion

#region Npad

#region Static

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip(
        "Enables the specified Npad. " +
        "Enables the Npad used by the application. You must call this API when starting to use the Npad. " +
        "Specify the Npad to enable using NpadId. " +
        "You can specify multiple instances of NpadId at the same time. " +
        "Specify all Npads used by the application at the same time. The Npad used during the application can be updated. " +
        "All Npads not specified with an NpadId by this function are disabled. " +
        "You cannot set a wireless controller as the controller to use, for example, when that Npad was not enabled with this function. " +
        "When an enabled Npad becomes disabled, any controllers that were connected to that Npad are disconnected."
    )]
    public class RewiredSwitchNpadSetSupportedNpadIds : BaseFsmStateAction {

        [Tooltip("Support Npad 1.")]
        public FsmBool npad1;

        [Tooltip("Support Npad 2.")]
        public FsmBool npad2;

        [Tooltip("Support Npad 3.")]
        public FsmBool npad3;

        [Tooltip("Support Npad 4.")]
        public FsmBool npad4;

        [Tooltip("Support Npad 5.")]
        public FsmBool npad5;

        [Tooltip("Support Npad 6.")]
        public FsmBool npad6;

        [Tooltip("Support Npad 7.")]
        public FsmBool npad7;

        [Tooltip("Support Npad 8.")]
        public FsmBool npad8;

        [Tooltip("Support Handheld.")]
        public FsmBool handheld;

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            List<NpadId> ids = new List<NpadId>();
            if(npad1.Value) ids.Add(NpadId.No1);
            if(npad2.Value) ids.Add(NpadId.No2);
            if(npad3.Value) ids.Add(NpadId.No3);
            if(npad4.Value) ids.Add(NpadId.No4);
            if(npad5.Value) ids.Add(NpadId.No5);
            if(npad6.Value) ids.Add(NpadId.No6);
            if(npad7.Value) ids.Add(NpadId.No7);
            if(npad8.Value) ids.Add(NpadId.No8);
            if(handheld.Value) ids.Add(NpadId.Handheld);
            SwitchInput.Npad.SetSupportedIds(ids.ToArray());
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip(
        "Starts the operation style mode assigned by pressing the L/R Buttons on the Joy-Con. " +
        "When this function is called, both NpadStyle and JoyConAssignmentMode are determined based on how the buttons are pressed on the Joy-Con. Enabled until StopLRAssignmentMode() is called. " +
        "If the L Button on the Joy-Con (L) and the R Button on the Joy-Con (R) are pressed simultaneously, the two Joy-Con are assigned to the Npad as a pair. If the Npad is already set to dual mode, nothing changes when the L/R Buttons are pressed. " +
        "If either NpadStyle.JoyConRight or NpadStyle.JoyConLeft is enabled and JoyConGripStyle is JoyConGripStyle.Horizontal, " +
        "pressing the SL and SR Buttons simultaneously setsNpadStyle to either NpadStyle.JoyConRight or NpadStyle.JoyConLeft. " +
        "The assignment for the relevant Npad changes to JoyConAssignmentMode.Single. Pressing the SL or SR Button on either Joy-Con of the pair disconnects the other Joy-Con of the pair. " +
        "If either NpadStyle.JoyConRight or NpadStyle.JoyConLeft is enabled and JoyConGripStyle JoyConGripStyle.Vertical, " +
        "the Joy-Con is connected preferentially as either NpadStyle.JoyConRight or NpadStyle.JoyConLeft and the assignment changes to JoyConAssignmentMode.Single." +
        "There is no effect on operations when StartLrAssignmentMode has already been called."
    )]
    public class RewiredSwitchNpadStartJoyConLRAssignmentMode : BaseFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            SwitchInput.Npad.StartJoyConLRAssignmentMode();
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip(
        "Ends the operation style mode that was assigned by pressing the L/R Buttons on the Joy-Con. " +
        "Ends the operation style assigned mode based on the L and R Button presses that began using StartLRAssignmentMode(). " +
        "This function has no effect on operations if StartLRAssignmentMode() was not called."
    )]
    public class RewiredSwitchNpadStopJoyConLRAssignmentMode : BaseFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            SwitchInput.Npad.StopJoyConLRAssignmentMode();
        }
    }

#endregion

#region Base Classes

    public abstract class NpadBaseFsmStateAction : BaseFsmStateAction {

        [RequiredField, ObjectType(typeof(NpadId))]
        [Tooltip("The Npad Id.")]
        public FsmEnum npadId;

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected bool isValid {
            get { return (NpadId)npadId.Value != NpadId.Invalid; }
        }

        protected SwitchInput.Npad npad { get { return isValid ? SwitchInput.Npad.GetNpad((NpadId)npadId.Value) : null; } }

        public override void Reset() {
            base.Reset();
            npadId = NpadId.No1;
        }
    }

    public abstract class NpadGetEnumFsmStateAction : GetEnumFsmStateAction {

        [RequiredField, ObjectType(typeof(NpadId))]
        [Tooltip("The Npad Id.")]
        public FsmEnum npadId;

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected bool isValid {
            get { return (NpadId)npadId.Value != NpadId.Invalid; }
        }

        protected SwitchInput.Npad npad { get { return isValid ? SwitchInput.Npad.GetNpad((NpadId)npadId.Value) : null; } }

        public override void Reset() {
            base.Reset();
            npadId = NpadId.No1;
        }
    }

    public abstract class NpadGetBoolFsmStateAction : GetBoolFsmStateAction {

        [RequiredField, ObjectType(typeof(NpadId))]
        [Tooltip("The Npad Id.")]
        public FsmEnum npadId;

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected bool isValid {
            get { return (NpadId)npadId.Value != NpadId.Invalid; }
        }

        protected SwitchInput.Npad npad { get { return isValid ? SwitchInput.Npad.GetNpad((NpadId)npadId.Value) : null; } }

        public override void Reset() {
            base.Reset();
            npadId = NpadId.No1;
        }
    }

#endregion

#region nn.hid.NpadCommon

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip(
        "Gets the Npad operation mode. " +
        "The Npad supports several different operation modes. " +
        "Use this function to get the current operation mode of the Npad with the specified Npad ID.  " +
        "The supported operation modes are determined by the operation modes set using the SetSupportedStyleSet() " +
        "function and the type of controller that is connected. " +
        "This function returns NpadStyle.None when there is no controller with the specified Npad ID connected."
    )]
    public class RewiredSwitchNpadGetStyleSet : BaseFsmStateAction {

        [RequiredField, ObjectType(typeof(NpadId))]
        [Tooltip("The Npad Id.")]
        public FsmEnum npadId;

        [UIHint(UIHint.Variable)]
        [Tooltip("Npad type that represents full key operation mode. (Pro Controller)")]
        public FsmBool fullKey;

        [UIHint(UIHint.Variable)]
        [Tooltip("Npad type that represents handheld operation. (Joy-Cons attached to the Switch unit.")]
        public FsmBool handheld;

        [UIHint(UIHint.Variable)]
        [Tooltip("The Npad type representing Joy-Con dual-controller grip operations.")]
        public FsmBool joyConDual;

        [UIHint(UIHint.Variable)]
        [Tooltip("The Npad type representing Joy-Con (L) operations.")]
        public FsmBool joyConLeft;

        [UIHint(UIHint.Variable)]
        [Tooltip("The Npad type representing Joy-Con (R) operations.")]
        public FsmBool joyConRight;

        protected override bool defaultValue_everyFrame { get { return false; } }

        public override void Reset() {
            base.Reset();
            npadId = NpadId.No1;
            fullKey = false;
            handheld = false;
            joyConDual = false;
            joyConLeft = false;
            joyConRight = false;
        }

        protected override void DoUpdate() {
            if((NpadId)npadId.Value == NpadId.Invalid) return;
            NpadStyle styles = SwitchInput.Npad.GetNpad((NpadId)npadId.Value).GetStyleSet();
            fullKey = (styles & NpadStyle.FullKey) != 0;
            handheld = (styles & NpadStyle.Handheld) != 0;
            joyConDual = (styles & NpadStyle.JoyConDual) != 0;
            joyConLeft = (styles & NpadStyle.JoyConLeft) != 0;
            joyConRight = (styles & NpadStyle.JoyConRight) != 0;
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip(
        "Disconnects the Npad. " +
        "This function can be used on Npads with Npad IDs from NpadId.No1 to NpadId.No8. " +
        "This function will not do anything if called on other Npads."
    )]
    public class RewiredSwitchNpadDisconnect : NpadBaseFsmStateAction {
        protected override void DoUpdate() {
            if(!isValid) return;
            npad.Disconnect();
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip(
        "Gets the pattern of lit Npad player LEDs. " +
        "The pattern of lit LEDs is expressed using the lower 4 bits of Bit8. The lowest-order bit represents the lit state of the player LED furthest to the left. " +
        "Player LEDs can be obtained for NpadId.No1 through NpadId.No8. " +
        "This function will return GamepadPlayerLight.None if it is called on other Npads."
    )]
    public class RewiredSwitchNpadGetPlayerLedPattern : NpadBaseFsmStateAction {

        [UIHint(UIHint.Variable)]
        [Tooltip("The first light.")]
        public FsmBool light1;

        [UIHint(UIHint.Variable)]
        [Tooltip("The second light.")]
        public FsmBool light2;

        [UIHint(UIHint.Variable)]
        [Tooltip("The third light.")]
        public FsmBool light3;

        [UIHint(UIHint.Variable)]
        [Tooltip("The fourth light.")]
        public FsmBool light4;

        public override void Reset() {
            base.Reset();
            light1 = false;
            light2 = false;
            light3 = false;
            light4 = false;
        }

        protected override void DoUpdate() {
            if(!isValid) return;
            GamepadPlayerLight pattern = npad.GetPlayerLedPattern();
            if((pattern & GamepadPlayerLight.Light1) != 0) light1.Value = true;
            if((pattern & GamepadPlayerLight.Light2) != 0) light2.Value = true;
            if((pattern & GamepadPlayerLight.Light3) != 0) light3.Value = true;
            if((pattern & GamepadPlayerLight.Light4) != 0) light4.Value = true;
        }
    }

#endregion

#region nn.hid.NpadJoyCommon

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip(
        "Gets the Joy-Con assignment mode. " +
        "There are two assignment modes. In dual mode, the pair of Joy-Con controllers is assigned to one Npad. " +
        "In single mode, each controller for the Joy-Con is assigned individually to an Npad. " +
        "Dual controller assignment mode (NpadStyle.JoyConDual): " +
        "A single Npad is assigned the set of left and right Joy-Con. " +
        "Player LEDs flash on both the right and left Joy-Con controllers, using the same controller number. " +
        "In dual assignment mode, the NpadStyle.JoyConDual style of operation is enabled. " +
        "Even if only one of the Joy-Con pair is attached, the input is taken to be NpadStyle.JoyConDual input. " +
        "Single controller assignment mode: (JoyConAssignmentMode.Single): " +
        "A single Npad is assigned either Joy-Con (R) or Joy-Con (L).  " +
        "Different player LEDs flash on both the right and left Joy-Con controllers, for different controller numbers.  " +
        "In single assignment mode, either the NpadStyle.JoyConRight or the NpadStyle.JoyConLeft style of operation is enabled. " +
        "The valid NpadStyle varies, depending on the type of Joy-Con that is connected."
    )]
    public class RewiredSwitchNpadGetJoyConAssignmentMode : NpadGetEnumFsmStateAction {

        [RequiredField, UIHint(UIHint.Variable), ObjectType(typeof(JoyConGripStyle))]
        [Tooltip("The enum value to store.")]
        public FsmEnum storeValue;

        protected override FsmEnum _storeValue { get { return storeValue; } set { storeValue = value; } }

        protected override void DoUpdate() {
            if(!isValid) return;
            UpdateStoreValue(npad.GetJoyConAssignmentMode());
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip(
        "Changes the Npad's Joy-Con assignment mode to \"Single.\". " +
        "There are two assignment modes. In dual mode, the pair of Joy-Con controllers is assigned to one Npad.  " +
        "In single mode, each controller for the Joy-Con is assigned individually to an Npad. " +
        "This function assigns a single connected Joy-Con to the specified Npad.  " +
        "Joy-Con (R) and Joy-Con (L) take different NpadId, and the left and right Joy-Con take different player numbers. " +
        "To change the assignment mode, specify one NpadId.  " +
        "If a Joy-Con pair is already connected to one NpadId, the Joy-Con (R) is disconnected from the Npad and reconnected to a different Npad to which no Joy-Con is connected. " +
        "If only one Joy-Con was connected in the first place, the mode is simply changed to single assignment mode. " +
        "The Npad assignment mode can be changed externally by a system feature. Use the GetJoyConAssignmentMode() function to get the current assignment mode."
    )]
    public class RewiredSwitchNpadSetJoyConAssignmentModeToSingle : NpadBaseFsmStateAction {

        [Tooltip("If enabled, you can specify the Left or Right Joy-Con to be kept when changing modes.")]
        public FsmBool keepJoyConOfType;

        [RequiredField, ObjectType(typeof(JoyConType))]
        [Tooltip("If the pair of controllers is connected, specify whether to keep Joy-Con (R) or Joy-Con (L).")]
        public FsmEnum joyConType;

        public override void Reset() {
            base.Reset();
            keepJoyConOfType = false;
            joyConType = JoyConType.Left;
        }

        protected override void DoUpdate() {
            if(!isValid) return;
            if(keepJoyConOfType.Value) {
                npad.SetJoyConAssignmentModeToSingle((JoyConType)joyConType.Value);
            } else {
                npad.SetJoyConAssignmentModeToSingle();
            }
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip(
        "Changes the Joy-Con assignment mode for the Npad to dual mode. " +
        "There are two assignment modes. In dual mode, the pair of Joy-Con controllers is assigned to one Npad.  " +
        "In single mode, each controller for the Joy-Con is assigned individually to an Npad. " +
        "This function sets the Joy-Con assignment mode to dual mode for the specified Npad. " +
        "Joy-Con (R) and Joy-Con (L) take different Npad IDs, and the left and right Joy-Con take different player numbers. " +
        "To change the assignment mode, specify one Npad ID.  " +
        "If the assignment mode is set to dual, when a Joy-Con is newly connected it is assigned as the pair of controllers. " +
        "The Npad assignment mode can be changed externally by a system feature. Use the GetJoyConAssignmentMode() function to get the current assignment mode."
    )]
    public class RewiredSwitchNpadSetJoyConAssignmentModeToDual : NpadBaseFsmStateAction {
        protected override void DoUpdate() {
            if(!isValid) return;
            npad.SetJoyConAssignmentModeToDual();
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip(
        "Merges two Npads with single-mode assignments into one Npad with a dual-mode assignment. " +
        "To change the assignment mode using this function, specify the Npad ID for the two Npad in advance. " +
        "Merges two Npads with single-mode assignments into one Npad with a dual-mode assignment. " +
        "The two Npads must be connected respectively to the left and right Joy-Con controllers. " +
        "The change fails if a Joy-Con controller pair is connected to one of the two Npads, or if a Joy-Con (R) is connected to both Npads. " +
        "When the function makes the change, the mode for NpadId changes to dual assignment mode."
    )]
    public class RewiredSwitchNpadMergeSingleJoyCons : BaseFsmStateAction {

        [Tooltip("The first Npad Id.")]
        [RequiredField, ObjectType(typeof(NpadId))]
        public FsmEnum npadId1;

        [Tooltip("The first Npad Id.")]
        [RequiredField, ObjectType(typeof(NpadId))]
        public FsmEnum npadId2;

        protected override bool defaultValue_everyFrame { get { return false; } }

        public override void Reset() {
            base.Reset();
            npadId1 = NpadId.No1;
            npadId2 = NpadId.No1;
        }

        protected override void DoUpdate() {
            if((NpadId)npadId1.Value == NpadId.Invalid) return;
            if((NpadId)npadId2.Value == NpadId.Invalid) return;
            if(npadId1.Value == npadId2.Value) {
                Debug.LogWarning("Npad 1 cannot be the same as Npad 2");
                return;
            }
            SwitchInput.Npad.GetNpad((NpadId)npadId1.Value).MergeSingleJoyCons((NpadId)npadId2.Value);
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip(
        "Swaps the npadIds of two controllers. " +
        "This function will run even if the physical controllers are not mapped. " +
        "If a controller is mapped to id1 but nothing is mapped to id2, the controller set to id1 will be mapped to id2."
    )]
    public class RewiredSwitchNpadSwapAssignment : BaseFsmStateAction {

        [Tooltip("The first Npad Id.")]
        [RequiredField, ObjectType(typeof(NpadId))]
        public FsmEnum npadId1;

        [Tooltip("The first Npad Id.")]
        [RequiredField, ObjectType(typeof(NpadId))]
        public FsmEnum npadId2;

        protected override bool defaultValue_everyFrame { get { return false; } }

        public override void Reset() {
            base.Reset();
            npadId1 = NpadId.No1;
            npadId2 = NpadId.No1;
        }

        protected override void DoUpdate() {
            if((NpadId)npadId1.Value == NpadId.Invalid) return;
            if((NpadId)npadId2.Value == NpadId.Invalid) return;
            if(npadId1.Value == npadId2.Value) {
                Debug.LogWarning("Npad 1 cannot be the same as Npad 2");
                return;
            }
            SwitchInput.Npad.GetNpad((NpadId)npadId1.Value).SwapAssignment((NpadId)npadId2.Value);
        }
    }

#endregion

#region Misc

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("The connection state of the Npad.")]
    public class RewiredSwitchNpadGetIsConnected : NpadGetBoolFsmStateAction {
        protected override void DoUpdate() {
            if(!isValid) return;
            UpdateStoreValue(npad.IsConnected());
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("The connection state of a specific Joy-Con in a Dual Joy-Con controller.")]
    public class RewiredSwitchNpadGetChildIsConnected : NpadGetBoolFsmStateAction {

        [Tooltip("The Left or Right Joy-Con.")]
        [RequiredField, ObjectType(typeof(JoyConType))]
        public FsmEnum joyConType;

        protected override void DoUpdate() {
            if(!isValid) return;
            UpdateStoreValue(npad.IsConnected((JoyConType)joyConType.Value));
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Indicates whether the Npad is connected to a supported device via a cable.")]
    public class RewiredSwitchNpadGetIsWired : NpadGetBoolFsmStateAction {
        protected override void DoUpdate() {
            if(!isValid) return;
            UpdateStoreValue(npad.IsWired());
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Indicates whether a specific Joy-Con in a Dual Joy-Con controller is connected to a supported device via a cable.")]
    public class RewiredSwitchNpadGetChildIsWired : NpadGetBoolFsmStateAction {

        [Tooltip("The Left or Right Joy-Con.")]
        [RequiredField, ObjectType(typeof(JoyConType))]
        public FsmEnum joyConType;

        protected override void DoUpdate() {
            if(!isValid) return;
            UpdateStoreValue(npad.IsConnected((JoyConType)joyConType.Value));
        }
    }

#endregion

#endregion
}