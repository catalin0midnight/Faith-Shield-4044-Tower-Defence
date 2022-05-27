using UnityEngine;
using System.Collections.Generic;

namespace Rewired.Integration.PlayMaker {

    using HutongGames.PlayMaker;
    using HutongGames.PlayMaker.Actions;
    using HutongGames.Extensions;
    using HutongGames.Utility;
    using System;
    using Rewired.Config;
    using Rewired.Platforms;

    #region Players

    [ActionCategory("Rewired")]
    [Tooltip("Count of Players excluding system player.")]
    public class RewiredGetPlayerCount : GetIntFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            UpdateStoreValue(ReInput.players.playerCount);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Count of all players including system player.")]
    public class RewiredGetAllPlayersCount : GetIntFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            UpdateStoreValue(ReInput.players.allPlayerCount);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets a collection of Player ids. Does not include the System Player.")]
    public class RewiredGetPlayerIds : GetIntArrayFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            IList<Player> players = ReInput.players.Players;
            int count = players != null ? players.Count : 0;

            for(int i = 0; i < count; i++) {
                workingList.Add(players[i].id);
            }

            UpdateStoreValue();
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets a collection of Player ids including the System Player.")]
    public class RewiredGetAllPlayerIds : GetIntArrayFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            IList<Player> players = ReInput.players.AllPlayers;
            int count = players != null ? players.Count : 0;

            for(int i = 0; i < count; i++) {
                workingList.Add(players[i].id);
            }

            UpdateStoreValue();
        }
    }

    #endregion

    #region Controllers

    [ActionCategory("Rewired")]
    [Tooltip("The number of controllers of all types currently connected.")]
    public class RewiredGetControllerCount : GetIntFsmStateAction
    {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            UpdateStoreValue(ReInput.controllers.controllerCount);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("The number of joysticks currently connected.")]
    public class RewiredGetJoystickCount : GetIntFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            UpdateStoreValue(ReInput.controllers.joystickCount);
        }
    }

    // REMOVED AT THIS TIME BECAUSE OF POTENTIAL MEMORY BLOAT ISSUES
    // Wait until PlayMaker adds support for storing non-serialized objects.
    /*[ActionCategory("Rewired")]
    [Tooltip("Gets a collection of connected Joysticks.")]
    public class RewiredGetJoysticks : GetSystemObjectArrayFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            IList<Joystick> joysticks = ReInput.controllers.Joysticks;
            int count = joysticks != null ? joysticks.Count : 0;

            for(int i = 0; i < count; i++) {
                workingList.Add(joysticks[i]);
            }

            UpdateStoreValue();
        }
    }*/

    [ActionCategory("Rewired")]
    [Tooltip("Gets a collection of connected Joystick ids.")]
    public class RewiredGetJoystickIds : GetIntArrayFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            IList<Joystick> joysticks = ReInput.controllers.Joysticks;
            int count = joysticks != null ? joysticks.Count : 0;

            for(int i = 0; i < count; i++) {
                workingList.Add(joysticks[i].id);
            }

            UpdateStoreValue();
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets a collection of Custom Controller ids.")]
    public class RewiredGetCustomControllerIds : GetIntArrayFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            IList<CustomController> customControllers = ReInput.controllers.CustomControllers;
            int count = customControllers != null ? customControllers.Count : 0;

            for(int i = 0; i < count; i++) {
                workingList.Add(customControllers[i].id);
            }

            UpdateStoreValue();
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("The number of custom controllers.")]
    public class RewiredGetCustomControllerCount : GetIntFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }
        
        protected override void DoUpdate() {
            UpdateStoreValue(ReInput.controllers.customControllerCount);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Get the last controller type that produced input.")]
    public class RewiredGetLastActiveControllerType : BaseFsmStateAction {

        [UIHint(UIHint.Variable), ObjectType(typeof(ControllerType))]
        [Tooltip("Store the result in an enum variable.")]
        public FsmEnum storeValue;

        [Tooltip("Event to send when the value changes.")]
        public FsmEvent valueChangedEvent;

        public override void Reset() {
            base.Reset();
            storeValue = null;
        }

        protected override void DoUpdate() {
            UpdateStoreValue(ReInput.controllers.GetLastActiveControllerType());
        }

        protected void UpdateStoreValue(Enum newValue) {
            if(!newValue.Equals(storeValue.Value)) { // value changed
                // Store new value
                storeValue.Value = newValue;
                TrySendEvent(valueChangedEvent); // send value changed event
            }
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Is the specified controller assigned to any players?")]
    public class RewiredIsControllerAssigned : GetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField, ObjectType(typeof(ControllerType))]
        [Tooltip("The type of the controller.")]
        public FsmEnum controllerType;

        [RequiredField]
        [Tooltip("Controller Id of the controller. This currently only applies to Joystick and Custom controller types.")]
        public FsmInt controllerId = 0;

        public override void Reset() {
            base.Reset();
            controllerType = null;
            controllerId = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue(ReInput.controllers.IsControllerAssigned((ControllerType)controllerType.Value, controllerId.Value));
        }

        protected override bool ValidateVars() {
            if(!base.ValidateVars()) return false;

            if(ReInput.controllers.GetController((ControllerType)controllerType.Value, controllerId.Value) == null) {
                return false;
            }

            return true;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Is the specified controller assigned to the specified player?")]
    public class RewiredIsControllerAssignedToPlayer : GetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField]
        [Tooltip("The Rewired Player Id. To use the System Player, enter any value < 0 or 9999999.")]
        public FsmInt playerId;

        [RequiredField, ObjectType(typeof(ControllerType))]
        [Tooltip("The type of the controller.")]
        public FsmEnum controllerType;

        [RequiredField]
        [Tooltip("Controller Id of the controller. This currently only applies to Joystick and Custom controller types.")]
        public FsmInt controllerId = 0;

        public override void Reset() {
            base.Reset();
            playerId = 0;
            controllerType = null;
            controllerId = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue(ReInput.controllers.IsControllerAssignedToPlayer((ControllerType)controllerType.Value, controllerId.Value, playerId.Value));
        }

        protected override bool ValidateVars() {
            if(!base.ValidateVars()) return false;

            if(playerId.IsNone) {
                LogError("Rewired Player Id must be assigned!");
                return false;
            }
            if(playerId.Value != Rewired.Consts.systemPlayerId && (playerId.Value < 0 || playerId.Value >= ReInput.players.playerCount)) {
                LogError("Rewired Player Id is out of range!");
                return false;
            }

            if(ReInput.controllers.GetController((ControllerType)controllerType.Value, controllerId.Value) == null) {
                return false;
            }

            return true;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("De-assigns the specified controller from all players.")]
    public class RewiredRemoveControllerFromAllPlayers : BaseFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField, ObjectType(typeof(ControllerType))]
        [Tooltip("The type of the controller.")]
        public FsmEnum controllerType;

        [RequiredField]
        [Tooltip("Controller Id of the controller. This currently only applies to Joystick and Custom controller types.")]
        public FsmInt controllerId = 0;

        [Tooltip("Do we de-assign from the System player also?")]
        public FsmBool includeSystemPlayer = true;

        public override void Reset() {
            base.Reset();
            controllerType = null;
            controllerId = 0;
            includeSystemPlayer = true;
        }

        protected override void DoUpdate() {
            ReInput.controllers.RemoveControllerFromAllPlayers((ControllerType)controllerType.Value, controllerId.Value, includeSystemPlayer.Value);
        }

        protected override bool ValidateVars() {
            if(!base.ValidateVars()) return false;

            if(ReInput.controllers.GetController((ControllerType)controllerType.Value, controllerId.Value) == null) {
                return false;
            }

            return true;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Auto-assigns a Joystick to a Player based on the joystick auto-assignment settings in the Rewired Input Manager. If the Joystick is already assigned to a Player, the Joystick will not be re-assigned.")]
    public class RewiredAutoAssignJoystick : RewiredJoystickFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            ReInput.controllers.AutoAssignJoystick(Joystick);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Auto-assigns all unassigned Joysticks to Players based on the joystick auto-assignment settings in the Rewired Input Manager.")]
    public class RewiredAutoAssignJoysticks : BaseFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            ReInput.controllers.AutoAssignJoysticks();
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Create a new CustomController object from a source definition in the Rewired Input Manager.")]
    public class RewiredCreateCustomController : BaseFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField]
        [Tooltip("Source id of the CustomController definition.")]
        public FsmInt sourceId;

        [RequiredField]
        [Tooltip("Tag to assign.")]
        public FsmString tag;

        [RequiredField, UIHint(UIHint.Variable)]
        [Tooltip("Store the controller id in an int variable.")]
        public FsmInt storeValue;

        public override void Reset() {
            base.Reset();
            sourceId = 0;
            tag = string.Empty;
            storeValue = 0;
        }

        protected override void DoUpdate() {
            Controller controller = !string.IsNullOrEmpty(tag.Value) ? ReInput.controllers.CreateCustomController(sourceId.Value, tag.Value) : ReInput.controllers.CreateCustomController(sourceId.Value);
            int controllerId = controller != null ? controller.id : -1;
            UpdateStoreValue(controllerId);
        }

        protected void UpdateStoreValue(int newValue) {
            storeValue.Value = newValue;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Destroys a CustomController.")]
    public class RewiredDestroyCustomController : BaseFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField]
        [Tooltip("Custom Controller id.")]
        public FsmInt controllerId;

        public override void Reset() {
            base.Reset();
            controllerId = 0;
        }

        protected override void DoUpdate() {
            CustomController controller = ReInput.controllers.GetCustomController(controllerId.Value);
            if(controller == null) return;
            ReInput.controllers.DestroyCustomController(controller);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Get the button held state of all buttons on all controllers. Returns TRUE if any button is held. This retrieves the value from the actual hardware buttons, not Actions as mapped by Controller Maps in Player.")]
    public class RewiredGetAnyButton : GetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        [RequiredField]
        [Tooltip("If enabled, the button state will be obtained only for controllers matching the chosen Controller Type.")]
        public FsmBool useControllerType;

        [RequiredField, ObjectType(typeof(ControllerType))]
        [Tooltip("The type of controller. This is ignored if Use Controller Type is false.")]
        public FsmEnum controllerType;

        public override void Reset() {
            base.Reset();
            useControllerType = false;
            controllerType = null;
        }

        protected override void DoUpdate() {
            bool value;
            if(useControllerType.Value) {
                value = ReInput.controllers.GetAnyButton((ControllerType)controllerType.Value);
            } else {
                value = ReInput.controllers.GetAnyButton();
            }
            UpdateStoreValue(value);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Get the button just pressed state of all buttons on all controllers. This will only return TRUE only on the first frame a button is pressed. This retrieves the value from the actual hardware buttons, not Actions as mapped by Controller Maps in Player.")]
    public class RewiredGetAnyButtonDown : GetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        [RequiredField]
        [Tooltip("If enabled, the button state will be obtained only for controllers matching the chosen Controller Type.")]
        public FsmBool useControllerType;

        [RequiredField, ObjectType(typeof(ControllerType))]
        [Tooltip("The type of controller. This is ignored if Use Controller Type is false.")]
        public FsmEnum controllerType;

        public override void Reset() {
            base.Reset();
            useControllerType = false;
            controllerType = null;
        }

        protected override void DoUpdate() {
            bool value;
            if(useControllerType.Value) {
                value = ReInput.controllers.GetAnyButtonDown((ControllerType)controllerType.Value);
            } else {
                value = ReInput.controllers.GetAnyButtonDown();
            }
            UpdateStoreValue(value);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Get the button just released state of all buttons on all controllers of a specified type. This will only return TRUE only on the first frame a button is released. This retrieves the value from the actual hardware buttons, not Actions as mapped by Controller Maps in Player.")]
    public class RewiredGetAnyButtonUp : GetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        [RequiredField]
        [Tooltip("If enabled, the button state will be obtained only for controllers matching the chosen Controller Type.")]
        public FsmBool useControllerType;

        [RequiredField, ObjectType(typeof(ControllerType))]
        [Tooltip("The type of controller. This is ignored if Use Controller Type is false.")]
        public FsmEnum controllerType;

        public override void Reset() {
            base.Reset();
            useControllerType = false;
            controllerType = null;
        }

        protected override void DoUpdate() {
            bool value;
            if(useControllerType.Value) {
                value = ReInput.controllers.GetAnyButtonUp((ControllerType)controllerType.Value);
            } else {
                value = ReInput.controllers.GetAnyButtonUp();
            }
            UpdateStoreValue(value);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Get the previous button held state of all buttons on all controllers. Returns TRUE if any button was held in the previous frame. This retrieves the value from the actual hardware buttons, not Actions as mapped by Controller Maps in Player.")]
    public class RewiredGetAnyButtonPrev : GetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        [RequiredField]
        [Tooltip("If enabled, the button state will be obtained only for controllers matching the chosen Controller Type.")]
        public FsmBool useControllerType;

        [RequiredField, ObjectType(typeof(ControllerType))]
        [Tooltip("The type of controller. This is ignored if Use Controller Type is false.")]
        public FsmEnum controllerType;

        public override void Reset() {
            base.Reset();
            useControllerType = false;
            controllerType = null;
        }

        protected override void DoUpdate() {
            bool value;
            if(useControllerType.Value) {
                value = ReInput.controllers.GetAnyButtonPrev((ControllerType)controllerType.Value);
            } else {
                value = ReInput.controllers.GetAnyButtonPrev();
            }
            UpdateStoreValue(value);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Returns true if any button has changed state from the previous frame to the current. This retrieves the value from the actual hardware buttons, not Actions as mapped by Controller Maps in Player.")]
    public class RewiredGetAnyButtonChanged : GetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        [RequiredField]
        [Tooltip("If enabled, the button state will be obtained only for controllers matching the chosen Controller Type.")]
        public FsmBool useControllerType;

        [RequiredField, ObjectType(typeof(ControllerType))]
        [Tooltip("The type of controller. This is ignored if Use Controller Type is false.")]
        public FsmEnum controllerType;

        public override void Reset() {
            base.Reset();
            useControllerType = false;
            controllerType = null;
        }

        protected override void DoUpdate() {
            bool value;
            if(useControllerType.Value) {
                value = ReInput.controllers.GetAnyButtonChanged((ControllerType)controllerType.Value);
            } else {
                value = ReInput.controllers.GetAnyButtonChanged();
            }
            UpdateStoreValue(value);
        }
    }

    #endregion

    #region Time

    [ActionCategory("Rewired")]
    [Tooltip("Current unscaled time since start of the game. Always use this when doing current time comparisons for button and axis active/inactive times instead of Time.time or Time.unscaledTime.")]
    public class RewiredGetUnscaledTime : GetFloatFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue((float)ReInput.time.unscaledTime);
        }
    }

    #endregion

    #region Events

    [ActionCategory("Rewired")]
    [Tooltip("Event triggered when a controller is conected.")]
    public class RewiredControllerConnectedEvent : BaseFsmStateAction {
        
        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a string variable.")]
        public FsmString storeControllerName;

        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in an int variable.")]
        public FsmInt storeControllerId = -1;

        [ObjectType(typeof(ControllerType))]
        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in an enum variable.")]
        public FsmEnum storeControllerType;

        [Tooltip("Send event when a controller is connected.")]
        public FsmEvent sendEvent;

        private bool hasEvent = false;

        public override void Awake() {
            base.Awake();
            ReInput.ControllerConnectedEvent += OnControllerConnected;
        }

        public override void Reset() {
            base.Reset();
            storeControllerName = string.Empty;
            storeControllerId = -1;
            storeControllerType = null;
            hasEvent = false;
        }

        protected override void DoUpdate() {
            if(hasEvent) {
                if(!FsmEvent.IsNullOrEmpty(sendEvent)) Fsm.Event(sendEvent);
                hasEvent = false;
            }
        }

        private void OnControllerConnected(ControllerStatusChangedEventArgs args) {
            hasEvent = true;
            storeControllerName.Value = args.name;
            storeControllerId.Value = args.controllerId;
            storeControllerType.Value = args.controllerType;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Event triggered just before a controller is disconnected. You can use this event to save controller maps before the controller is removed.")]
    public class RewiredControllerPreDisconnectEvent : BaseFsmStateAction {

        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a string variable.")]
        public FsmString storeControllerName;

        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in an int variable.")]
        public FsmInt storeControllerId = -1;

        [ObjectType(typeof(ControllerType))]
        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in an enum variable.")]
        public FsmEnum storeControllerType;

        [Tooltip("Send event just before a controller is disconnected.")]
        public FsmEvent sendEvent;

        private bool hasEvent = false;

        public override void Awake() {
            base.Awake();
            ReInput.ControllerPreDisconnectEvent += OnControllerPreDisconnect;
        }

        public override void Reset() {
            base.Reset();
            storeControllerName = string.Empty;
            storeControllerId = -1;
            storeControllerType = null;
            hasEvent = false;
        }

        protected override void DoUpdate() {
            if(hasEvent) {
                if(!FsmEvent.IsNullOrEmpty(sendEvent)) Fsm.Event(sendEvent);
                hasEvent = false;
            }
        }

        private void OnControllerPreDisconnect(ControllerStatusChangedEventArgs args) {
            hasEvent = true;
            storeControllerName.Value = args.name;
            storeControllerId.Value = args.controllerId;
            storeControllerType.Value = args.controllerType;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Event triggered after a controller is disconnected.")]
    public class RewiredControllerDisconnectedEvent : BaseFsmStateAction {

        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a string variable.")]
        public FsmString storeControllerName;

        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in an int variable.")]
        public FsmInt storeControllerId = -1;

        [ObjectType(typeof(ControllerType))]
        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in an enum variable.")]
        public FsmEnum storeControllerType;

        [Tooltip("Send event when a controller is disconnected.")]
        public FsmEvent sendEvent;

        private bool hasEvent = false;

        public override void Awake() {
            base.Awake();
            ReInput.ControllerDisconnectedEvent += OnControllerDisconnected;
        }

        public override void Reset() {
            base.Reset();
            storeControllerName = string.Empty;
            storeControllerId = -1;
            storeControllerType = null;
            hasEvent = false;
        }

        protected override void DoUpdate() {
            if(hasEvent) {
                if(!FsmEvent.IsNullOrEmpty(sendEvent)) Fsm.Event(sendEvent);
                hasEvent = false;
            }
        }

        private void OnControllerDisconnected(ControllerStatusChangedEventArgs args) {
            hasEvent = true;
            storeControllerName.Value = args.name;
            storeControllerId.Value = args.controllerId;
            storeControllerType.Value = args.controllerType;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Event triggered every time the last active controller changes.")]
    public class RewiredLastActiveControllerChangedEvent : BaseFsmStateAction {

        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in an int variable.")]
        public FsmInt storeControllerId = -1;

        [ObjectType(typeof(ControllerType))]
        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in an enum variable.")]
        public FsmEnum storeControllerType;

        [Tooltip("Send event when the controller changes.")]
        public FsmEvent sendEvent;

        private bool hasEvent = false;

        public override void Awake() {
            base.Awake();
            if(!ReInput.isReady) {
                Debug.LogError("Rewired is not initialized. You must have an enabled Rewired Input Manager in the scene.");
            }
            ReInput.controllers.AddLastActiveControllerChangedDelegate(OnLastActiveControllerChanged);
        }

        public override void Reset() {
            base.Reset();
            storeControllerId = -1;
            storeControllerType = null;
            hasEvent = false;
        }

        protected override void DoUpdate() {
            if(hasEvent) {
                if(!FsmEvent.IsNullOrEmpty(sendEvent)) Fsm.Event(sendEvent);
                hasEvent = false;
            }
        }

        private void OnLastActiveControllerChanged(Controller controller) {
            hasEvent = true;
            storeControllerId.Value = controller.id;
            storeControllerType.Value = controller.type;
        }
    }

    #endregion

    #region Config Helper

    [ActionCategory("Rewired")]
    [Tooltip("Toggles the use of XInput in Windows Standalone and Windows UWP during runtime. Rewired will be completely reset if this value is changed.")]
    public class RewiredConfigGetUseXInput : GetBoolFsmStateAction
    {
        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            UpdateStoreValue(ReInput.configuration.useXInput);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Toggles the use of XInput in Windows Standalone and Windows UWP during runtime. Rewired will be completely reset if this value is changed.")]
    public class RewiredConfigSetUseXInput : SetBoolFsmStateAction
    {
        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            ReInput.configuration.useXInput = value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Changes the Update Loop setting during runtime. Rewired will be completely reset if this value is changed. This can be set to multiple values simultaneously. Note: Update is required. Update will be enabled even if you unset the Update flag.")]
    public class RewiredConfigGetUpdateLoop : GetEnumFsmStateAction
    {
        [UIHint(UIHint.Variable), ObjectType(typeof(UpdateLoopSetting))]
        [Tooltip("Store the result in an enum variable.")]
        public FsmEnum storeValue;
        protected override FsmEnum _storeValue { get { return storeValue; } set { storeValue = value; } }

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            UpdateStoreValue(ReInput.configuration.updateLoop);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Changes the Update Loop setting during runtime. Rewired will be completely reset if this value is changed. This can be set to multiple values simultaneously. Note: Update is required. Update will be enabled even if you unset the Update flag.")]
    public class RewiredConfigSetUpdateLoop : BaseFsmStateAction
    {
        [RequiredField]
        [Tooltip("Update Rewired in the FixedUpdate loop.")]
        public FsmBool fixedUpdate;

        [RequiredField]
        [Tooltip("Update Rewired in the OnGUI loop.")]
        public FsmBool onGUI;

        protected override bool defaultValue_everyFrame { get { return false; } }

        public override void Reset()
        {
            base.Reset();
            fixedUpdate = false;
            onGUI = false;
        }

        protected override void DoUpdate()
        {
            UpdateLoopSetting value = UpdateLoopSetting.Update; // always enable Update
            if (fixedUpdate.Value) value |= UpdateLoopSetting.FixedUpdate;
            if (onGUI.Value) value |= UpdateLoopSetting.OnGUI;
            ReInput.configuration.updateLoop = value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Changes the primary input source in Windows Standalone during runtime. Rewired will be completely reset if this value is changed.")]
    public class RewiredConfigGetWindowsStandalonePrimaryInputSource : GetEnumFsmStateAction
    {
        [UIHint(UIHint.Variable), ObjectType(typeof(WindowsStandalonePrimaryInputSource))]
        [Tooltip("Store the result in an enum variable.")]
        public FsmEnum storeValue;
        protected override FsmEnum _storeValue { get { return storeValue; } set { storeValue = value; } }

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            UpdateStoreValue(ReInput.configuration.windowsStandalonePrimaryInputSource);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Changes the primary input source in Windows Standalone during runtime. Rewired will be completely reset if this value is changed.")]
    public class RewiredConfigSetWindowsStandalonePrimaryInputSource : SetEnumFsmStateAction
    {
        [RequiredField]
        [Tooltip("The value to set."), ObjectType(typeof(WindowsStandalonePrimaryInputSource))]
        public FsmEnum value;
        protected override FsmEnum _value { get { return value; } set { this.value = value; } }

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            ReInput.configuration.windowsStandalonePrimaryInputSource = (WindowsStandalonePrimaryInputSource)value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Changes the primary input source in OSX Standalone during runtime. Rewired will be completely reset if this value is changed.")]
    public class RewiredConfigGetOSXStandalonePrimaryInputSource : GetEnumFsmStateAction
    {
        [UIHint(UIHint.Variable), ObjectType(typeof(OSXStandalonePrimaryInputSource))]
        [Tooltip("Store the result in an enum variable.")]
        public FsmEnum storeValue;
        protected override FsmEnum _storeValue { get { return storeValue; } set { storeValue = value; } }

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            UpdateStoreValue(ReInput.configuration.osxStandalonePrimaryInputSource);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Changes the primary input source in OSX Standalone during runtime. Rewired will be completely reset if this value is changed.")]
    public class RewiredConfigSetOSXStandalonePrimaryInputSource : SetEnumFsmStateAction
    {
        [RequiredField]
        [Tooltip("The value to set."), ObjectType(typeof(OSXStandalonePrimaryInputSource))]
        public FsmEnum value;
        protected override FsmEnum _value { get { return value; } set { this.value = value; } }

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            ReInput.configuration.osxStandalonePrimaryInputSource = (OSXStandalonePrimaryInputSource)value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Changes the primary input source in Linux Standalone during runtime. Rewired will be completely reset if this value is changed.")]
    public class RewiredConfigGetLinuxStandalonePrimaryInputSource : GetEnumFsmStateAction
    {
        [UIHint(UIHint.Variable), ObjectType(typeof(LinuxStandalonePrimaryInputSource))]
        [Tooltip("Store the result in an enum variable.")]
        public FsmEnum storeValue;
        protected override FsmEnum _storeValue { get { return storeValue; } set { storeValue = value; } }

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            UpdateStoreValue(ReInput.configuration.linuxStandalonePrimaryInputSource);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Changes the primary input source in Linux Standalone during runtime. Rewired will be completely reset if this value is changed.")]
    public class RewiredConfigSetLinuxStandalonePrimaryInputSource : SetEnumFsmStateAction
    {
        [RequiredField]
        [Tooltip("The value to set."), ObjectType(typeof(LinuxStandalonePrimaryInputSource))]
        public FsmEnum value;
        protected override FsmEnum _value { get { return value; } set { this.value = value; } }

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            ReInput.configuration.linuxStandalonePrimaryInputSource = (LinuxStandalonePrimaryInputSource)value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Changes the primary input source in Windows 10 Universal during runtime. Rewired will be completely reset if this value is changed.")]
    public class RewiredConfigGetWindowsUWPPrimaryInputSource : GetEnumFsmStateAction
    {
        [UIHint(UIHint.Variable), ObjectType(typeof(WindowsUWPPrimaryInputSource))]
        [Tooltip("Store the result in an enum variable.")]
        public FsmEnum storeValue;
        protected override FsmEnum _storeValue { get { return storeValue; } set { storeValue = value; } }

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            UpdateStoreValue(ReInput.configuration.windowsUWPPrimaryInputSource);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Changes the primary input source in Windows 10 Universal during runtime. Rewired will be completely reset if this value is changed.")]
    public class RewiredConfigSetWindowsUWPPrimaryInputSource : SetEnumFsmStateAction
    {
        [RequiredField]
        [Tooltip("The value to set."), ObjectType(typeof(WindowsUWPPrimaryInputSource))]
        public FsmEnum value;
        protected override FsmEnum _value { get { return value; } set { this.value = value; } }

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            ReInput.configuration.windowsUWPPrimaryInputSource = (WindowsUWPPrimaryInputSource)value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Toggles support for HID devices in Windows UWP. This includes older gamepads, gamepads made for Android, flight controllers, racing wheels, " +
        "etc. In order to use this feature, you must add support for HID gamepads and joysticks to the app manifest file. " +
        "Please see the Special Platform Support -> Windows 10 Universal documentation for details. " +
        "Rewired will be completely reset if this value is changed.")]
    public class RewiredConfigGetWindowsUWPSupportHIDDevices : GetBoolFsmStateAction
    {
        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            UpdateStoreValue(ReInput.configuration.windowsUWPSupportHIDDevices);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Toggles support for HID devices in Windows UWP. This includes older gamepads, gamepads made for Android, flight controllers, racing wheels, " +
        "etc. In order to use this feature, you must add support for HID gamepads and joysticks to the app manifest file. " +
        "Please see the Special Platform Support -> Windows 10 Universal documentation for details. " +
        "Rewired will be completely reset if this value is changed.")]
    public class RewiredConfigSetWindowsUWPSupportHIDDevices : SetBoolFsmStateAction
    {
        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            ReInput.configuration.windowsUWPSupportHIDDevices = value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Changes the primary input source in Xbox One during runtime. Rewired will be completely reset if this value is changed.")]
    public class RewiredConfigGetXboxOnePrimaryInputSource : GetEnumFsmStateAction
    {
        [UIHint(UIHint.Variable), ObjectType(typeof(XboxOnePrimaryInputSource))]
        [Tooltip("Store the result in an enum variable.")]
        public FsmEnum storeValue;
        protected override FsmEnum _storeValue { get { return storeValue; } set { storeValue = value; } }

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            UpdateStoreValue(ReInput.configuration.xboxOnePrimaryInputSource);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Changes the primary input source in Xbox One during runtime. Rewired will be completely reset if this value is changed.")]
    public class RewiredConfigSetXboxOnePrimaryInputSource : SetEnumFsmStateAction
    {
        [RequiredField]
        [Tooltip("The value to set."), ObjectType(typeof(XboxOnePrimaryInputSource))]
        public FsmEnum value;
        protected override FsmEnum _value { get { return value; } set { this.value = value; } }

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            ReInput.configuration.xboxOnePrimaryInputSource = (XboxOnePrimaryInputSource)value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Changes the primary input source in PS4 during runtime. Rewired will be completely reset if this value is changed.")]
    public class RewiredConfigGetPS4PrimaryInputSource : GetEnumFsmStateAction
    {
        [UIHint(UIHint.Variable), ObjectType(typeof(PS4PrimaryInputSource))]
        [Tooltip("Store the result in an enum variable.")]
        public FsmEnum storeValue;
        protected override FsmEnum _storeValue { get { return storeValue; } set { storeValue = value; } }

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            UpdateStoreValue(ReInput.configuration.ps4PrimaryInputSource);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Changes the primary input source in PS4 during runtime. Rewired will be completely reset if this value is changed.")]
    public class RewiredConfigSetPS4PrimaryInputSource : SetEnumFsmStateAction
    {
        [RequiredField]
        [Tooltip("The value to set."), ObjectType(typeof(PS4PrimaryInputSource))]
        public FsmEnum value;
        protected override FsmEnum _value { get { return value; } set { this.value = value; } }

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            ReInput.configuration.ps4PrimaryInputSource = (PS4PrimaryInputSource)value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Changes the primary input source in WebGL during runtime. Rewired will be completely reset if this value is changed.")]
    public class RewiredConfigGetWebGLPrimaryInputSource : GetEnumFsmStateAction
    {
        [UIHint(UIHint.Variable), ObjectType(typeof(WebGLPrimaryInputSource))]
        [Tooltip("Store the result in an enum variable.")]
        public FsmEnum storeValue;
        protected override FsmEnum _storeValue { get { return storeValue; } set { storeValue = value; } }

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            UpdateStoreValue(ReInput.configuration.webGLPrimaryInputSource);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Changes the primary input source in WebGL during runtime. Rewired will be completely reset if this value is changed.")]
    public class RewiredConfigSetWebGLPrimaryInputSource : SetEnumFsmStateAction
    {
        [RequiredField]
        [Tooltip("The value to set."), ObjectType(typeof(WebGLPrimaryInputSource))]
        public FsmEnum value;
        protected override FsmEnum _value { get { return value; } set { this.value = value; } }

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            ReInput.configuration.webGLPrimaryInputSource = (WebGLPrimaryInputSource)value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Toggles the use of Unity input during runtime. Rewired will be completely reset if this value is changed. This is an alias for disableNativeInput.")]
    public class RewiredConfigGetAlwaysUseUnityInput : GetBoolFsmStateAction
    {
        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            UpdateStoreValue(ReInput.configuration.alwaysUseUnityInput);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Toggles the use of Unity input during runtime. Rewired will be completely reset if this value is changed. This is an alias for disableNativeInput.")]
    public class RewiredConfigSetAlwaysUseUnityInput : SetBoolFsmStateAction
    {
        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            ReInput.configuration.alwaysUseUnityInput = value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Toggles the use of Unity input during runtime. Rewired will be completely reset if this value is changed.")]
    public class RewiredConfigGetDisableNativeInput : GetBoolFsmStateAction
    {
        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            UpdateStoreValue(ReInput.configuration.disableNativeInput);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Toggles the use of Unity input during runtime. Rewired will be completely reset if this value is changed.")]
    public class RewiredConfigSetDisableNativeInput : SetBoolFsmStateAction
    {
        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            ReInput.configuration.disableNativeInput = value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Toggles the use of native mouse handling during runtime. Rewired will be completely reset if this value is changed.")]
    public class RewiredConfigGetNativeMouseSupport : GetBoolFsmStateAction
    {
        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            UpdateStoreValue(ReInput.configuration.nativeMouseSupport);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Toggles the use of native mouse handling during runtime. Rewired will be completely reset if this value is changed.")]
    public class RewiredConfigSetNativeMouseSupport : SetBoolFsmStateAction
    {
        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            ReInput.configuration.nativeMouseSupport = value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Toggles the use of native keyboard handling during runtime. Rewired will be completely reset if this value is changed.")]
    public class RewiredConfigGetNativeKeyboardSupport : GetBoolFsmStateAction
    {
        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            UpdateStoreValue(ReInput.configuration.nativeKeyboardSupport);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Toggles the use of native keyboard handling during runtime. Rewired will be completely reset if this value is changed.")]
    public class RewiredConfigSetNativeKeyboardSupport : SetBoolFsmStateAction
    {
        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            ReInput.configuration.nativeKeyboardSupport = value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Toggles the use of enhanced device support during runtime. Rewired will be completely reset if this value is changed.")]
    public class RewiredConfigGetEnhancedDeviceSupport : GetBoolFsmStateAction
    {
        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            UpdateStoreValue(ReInput.configuration.enhancedDeviceSupport);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Toggles the use of enhanced device support during runtime. Rewired will be completely reset if this value is changed.")]
    public class RewiredConfigSetEnhancedDeviceSupport : SetBoolFsmStateAction
    {
        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            ReInput.configuration.enhancedDeviceSupport = value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("The joystick refresh rate in frames per second. [0 - 2000] [0 = Default] Set this to a higher value if you need higher precision input timing at high frame rates such as for a music beat game. Higher values result in higher CPU usage. Note that setting this to a very high value when the game is running at a low frame rate will not result in higher precision input. This settings only applies to input sources that use a separate thread to poll for joystick input values (currently XInput and Direct Input). This setting does not apply to event-based input sources such as Raw Input. This setting can be changed without resetting Rewired.")]
    public class RewiredConfigGetJoystickRefreshRate : GetIntFsmStateAction
    {
        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            UpdateStoreValue(ReInput.configuration.joystickRefreshRate);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("The joystick refresh rate in frames per second. [0 - 2000] [0 = Default] Set this to a higher value if you need higher precision input timing at high frame rates such as for a music beat game. Higher values result in higher CPU usage. Note that setting this to a very high value when the game is running at a low frame rate will not result in higher precision input. This settings only applies to input sources that use a separate thread to poll for joystick input values (currently XInput and Direct Input). This setting does not apply to event-based input sources such as Raw Input. This setting can be changed without resetting Rewired.")]
    public class RewiredConfigSetJoystickRefreshRate : SetIntFsmStateAction
    {
        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            ReInput.configuration.joystickRefreshRate = value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Ignores input if the application is not in focus This setting has no effect on some platforms. NOTE: Disabling this does not guarantee that input will be processed when the application is out of focus. Whether input is received by the application or not is dependent on A) the input device type B) the current platform C) the input source(s) being used. This setting can be changed without resetting Rewired.")]
    public class RewiredConfigGetIgnoreInputWhenAppNotInFocus : GetBoolFsmStateAction
    {
        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            UpdateStoreValue(ReInput.configuration.ignoreInputWhenAppNotInFocus);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Ignores input if the application is not in focus This setting has no effect on some platforms. NOTE: Disabling this does not guarantee that input will be processed when the application is out of focus. Whether input is received by the application or not is dependent on A) the input device type B) the current platform C) the input source(s) being used. This setting can be changed without resetting Rewired.")]
    public class RewiredConfigSetIgnoreInputWhenAppNotInFocus : SetBoolFsmStateAction
    {
        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            ReInput.configuration.ignoreInputWhenAppNotInFocus = value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Toggles the support of unknown gamepads on the Android platform during runtime. Rewired will be completely reset if this value is changed.")]
    public class RewiredConfigGetAndroidSupportUnknownGamepads : GetBoolFsmStateAction
    {
        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            UpdateStoreValue(ReInput.configuration.android_supportUnknownGamepads);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Toggles the support of unknown gamepads on the Android platform during runtime. Rewired will be completely reset if this value is changed.")]
    public class RewiredConfigSetAndroidSupportUnknownGamepads : SetBoolFsmStateAction
    {
        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            ReInput.configuration.android_supportUnknownGamepads = value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip(
        "Changes the default axis sensitivity type for axes. This setting can be changed without resetting Rewired. " +
        "Changing this setting will not change the AxisSensitivityType on Controllers already connected during the game session. " +
        "It will also not change the AxisSensitivityType in saved user data that is loaded."
    )]
    public class RewiredConfigGetDefaultAxisSensitivityType : GetEnumFsmStateAction {
        [UIHint(UIHint.Variable), ObjectType(typeof(AxisSensitivityType))]
        [Tooltip("Store the result in an enum variable.")]
        public FsmEnum storeValue;
        protected override FsmEnum _storeValue { get { return storeValue; } set { storeValue = value; } }

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            UpdateStoreValue(ReInput.configuration.defaultAxisSensitivityType);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip(
        "Changes the default axis sensitivity type for axes. This setting can be changed without resetting Rewired. " +
        "Changing this setting will not change the AxisSensitivityType on Controllers already connected during the game session. " +
        "It will also not change the AxisSensitivityType in saved user data that is loaded."
    )]
    public class RewiredConfigSetDefaultAxisSensitivityType : SetEnumFsmStateAction {
        [RequiredField]
        [Tooltip("The value to set."), ObjectType(typeof(AxisSensitivityType))]
        public FsmEnum value;

        protected override FsmEnum _value { get { return value; } set { this.value = value; } }

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            ReInput.configuration.defaultAxisSensitivityType = (AxisSensitivityType)value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Changes the default dead zone type for 2D joystick axes for recognized controllers. This setting can be changed without resetting Rewired.")]
    public class RewiredConfigGetDefaultJoystickAxis2DDeadZoneType : GetEnumFsmStateAction
    {
        [UIHint(UIHint.Variable), ObjectType(typeof(DeadZone2DType))]
        [Tooltip("Store the result in an enum variable.")]
        public FsmEnum storeValue;
        protected override FsmEnum _storeValue { get { return storeValue; } set { storeValue = value; } }

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            UpdateStoreValue(ReInput.configuration.defaultJoystickAxis2DDeadZoneType);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Changes the default dead zone type for 2D joystick axes for recognized controllers. This setting can be changed without resetting Rewired.")]
    public class RewiredConfigSetDefaultJoystickAxis2DDeadZoneType : SetEnumFsmStateAction
    {
        [RequiredField]
        [Tooltip("The value to set."), ObjectType(typeof(DeadZone2DType))]
        public FsmEnum value;

        protected override FsmEnum _value { get { return value; } set { this.value = value; } }

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            ReInput.configuration.defaultJoystickAxis2DDeadZoneType = (DeadZone2DType)value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Changes the default sensitivity type for 2D joystick axes for recognized controllers. This setting can be changed without resetting Rewired.")]
    public class RewiredConfigGetDefaultJoystickAxis2DSensitivityType : GetEnumFsmStateAction {
        [UIHint(UIHint.Variable), ObjectType(typeof(AxisSensitivity2DType))]
        [Tooltip("Store the result in an enum variable.")]
        public FsmEnum storeValue;
        protected override FsmEnum _storeValue { get { return storeValue; } set { storeValue = value; } }

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            UpdateStoreValue(ReInput.configuration.defaultJoystickAxis2DSensitivityType);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Changes the default sensitivity type for 2D joystick axes for recognized controllers. This setting can be changed without resetting Rewired.")]
    public class RewiredConfigSetDefaultJoystickAxis2DSensitivityType : SetEnumFsmStateAction {
        [RequiredField]
        [Tooltip("The value to set."), ObjectType(typeof(AxisSensitivity2DType))]
        public FsmEnum value;

        protected override FsmEnum _value { get { return value; } set { this.value = value; } }

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            ReInput.configuration.defaultJoystickAxis2DSensitivityType = (AxisSensitivity2DType)value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Force all 8-way hats on recognized joysticks to be treated as 4-way hats. If enabled, the corner directions on all hats will activate the adjacent 2 cardinal direction buttons instead of the corner button. This is useful if you need joystick hats to behave like D-Pads instead of 8-way hats. This setting can be changed without resetting Rewired.")]
    public class RewiredConfigGetForce4WayHats : GetBoolFsmStateAction
    {
        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            UpdateStoreValue(ReInput.configuration.force4WayHats);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Force all 8-way hats on recognized joysticks to be treated as 4-way hats. If enabled, the corner directions on all hats will activate the adjacent 2 cardinal direction buttons instead of the corner button. This is useful if you need joystick hats to behave like D-Pads instead of 8-way hats. This setting can be changed without resetting Rewired.")]
    public class RewiredConfigSetForce4WayHats : SetBoolFsmStateAction
    {
        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            ReInput.configuration.force4WayHats = value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Determines how button values are calculated by Player Actions. If enabled, Actions with either a negative or positive Axis value will return True when queried with player.GetButton. If disabled, Actions with a negative Axis value will always return False when queried with player.GetButton, and must be queried with player.GetNegativeButton. This setting can be changed without resetting Rewired.")]
    public class RewiredConfigGetActivateActionButtonsOnNegativeValue : GetBoolFsmStateAction
    {
        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            UpdateStoreValue(ReInput.configuration.activateActionButtonsOnNegativeValue);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Determines how button values are calculated by Player Actions. If enabled, Actions with either a negative or positive Axis value will return True when queried with player.GetButton. If disabled, Actions with a negative Axis value will always return False when queried with player.GetButton, and must be queried with player.GetNegativeButton. This setting can be changed without resetting Rewired.")]
    public class RewiredConfigSetActivateActionButtonsOnNegativeValue : SetBoolFsmStateAction
    {
        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            ReInput.configuration.activateActionButtonsOnNegativeValue = value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Determines how throttles on recognized controllers are calibrated. By default, throttles are calibrated for a range of 0 to +1. This is suitable for most flight and racing games. Some games may require a range of -1 to +1 such as space flight games where a negative value denotes a reverse thrust. Changing this setting will revert all throttle calibrations to the default values for the chosen calibration mode.")]
    public class RewiredConfigGetThrottleCalibrationMode : GetEnumFsmStateAction
    {
        [UIHint(UIHint.Variable), ObjectType(typeof(ThrottleCalibrationMode))]
        [Tooltip("Store the result in an enum variable.")]
        public FsmEnum storeValue;
        protected override FsmEnum _storeValue { get { return storeValue; } set { storeValue = value; } }

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            UpdateStoreValue(ReInput.configuration.throttleCalibrationMode);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Determines how throttles on recognized controllers are calibrated. By default, throttles are calibrated for a range of 0 to +1. This is suitable for most flight and racing games. Some games may require a range of -1 to +1 such as space flight games where a negative value denotes a reverse thrust. Changing this setting will revert all throttle calibrations to the default values for the chosen calibration mode.")]
    public class RewiredConfigSetThrottleCalibrationMode : SetEnumFsmStateAction
    {
        [RequiredField]
        [Tooltip("The value to set."), ObjectType(typeof(ThrottleCalibrationMode))]
        public FsmEnum value;

        protected override FsmEnum _value { get { return value; } set { this.value = value; } }

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            ReInput.configuration.throttleCalibrationMode = (ThrottleCalibrationMode)value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Defer controller connected events for controllers already connected when Rewired initializes until the Start event instead of during initialization. Normally, it's impossible to receive controller connection events at the start of runtime because Rewired initializes before any other script is able to subscribe to the controller connected event. Enabling this will defer the controller connected events until the Start event, allowing your scripts to subscribe to the controller connected event in Awake and still receive the event callback. If disabled, controller connection events for controllers already connected before runtime starts will be missed.")]
    public class RewiredConfigGetDeferControllerConnectedEventsOnStart : GetBoolFsmStateAction
    {
        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            UpdateStoreValue(ReInput.configuration.deferControllerConnectedEventsOnStart);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Defer controller connected events for controllers already connected when Rewired initializes until the Start event instead of during initialization. Normally, it's impossible to receive controller connection events at the start of runtime because Rewired initializes before any other script is able to subscribe to the controller connected event. Enabling this will defer the controller connected events until the Start event, allowing your scripts to subscribe to the controller connected event in Awake and still receive the event callback. If disabled, controller connection events for controllers already connected before runtime starts will be missed.")]
    public class RewiredConfigSetDeferControllerConnectedEventsOnStart : SetBoolFsmStateAction
    {
        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            ReInput.configuration.deferControllerConnectedEventsOnStart = value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Toggles joystick auto-assignment during runtime. This setting can be changed without resetting Rewired.")]
    public class RewiredConfigGetAutoAssignJoysticks : GetBoolFsmStateAction
    {
        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            UpdateStoreValue(ReInput.configuration.autoAssignJoysticks);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Toggles joystick auto-assignment during runtime. This setting can be changed without resetting Rewired.")]
    public class RewiredConfigSetAutoAssignJoysticks : SetBoolFsmStateAction
    {
        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            ReInput.configuration.autoAssignJoysticks = value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Set the max number of joysticks assigned to each Player by joystick auto-assignment during runtime. This setting can be changed without resetting Rewired.")]
    public class RewiredConfigGetMaxJoysticksPerPlayer : GetIntFsmStateAction
    {
        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            UpdateStoreValue(ReInput.configuration.maxJoysticksPerPlayer);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Set the max number of joysticks assigned to each Player by joystick auto-assignment during runtime. This setting can be changed without resetting Rewired.")]
    public class RewiredConfigSetMaxJoysticksPerPlayer : SetIntFsmStateAction
    {
        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            ReInput.configuration.maxJoysticksPerPlayer = value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Toggles even joystick auto-assignment distribution among Players during runtime. This setting can be changed without resetting Rewired.")]
    public class RewiredConfigGetDistributeJoysticksEvenly : GetBoolFsmStateAction
    {
        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            UpdateStoreValue(ReInput.configuration.distributeJoysticksEvenly);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Toggles even joystick auto-assignment distribution among Players during runtime. This setting can be changed without resetting Rewired.")]
    public class RewiredConfigSetDistributeJoysticksEvenly : SetBoolFsmStateAction
    {
        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            ReInput.configuration.distributeJoysticksEvenly = value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Toggles even joystick auto-assignment to Players with isPlayer = True only during runtime. This setting can be changed without resetting Rewired.")]
    public class RewiredConfigGetAssignJoysticksToPlayingPlayersOnly : GetBoolFsmStateAction
    {
        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            UpdateStoreValue(ReInput.configuration.assignJoysticksToPlayingPlayersOnly);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Toggles even joystick auto-assignment to Players with isPlayer = True only during runtime. This setting can be changed without resetting Rewired.")]
    public class RewiredConfigSetAssignJoysticksToPlayingPlayersOnly : SetBoolFsmStateAction
    {
        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            ReInput.configuration.assignJoysticksToPlayingPlayersOnly = value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Toggles joystick auto-reassignment when re-connected to the last owning Player during runtime. This setting can be changed without resetting Rewired.")]
    public class RewiredConfigGetReassignJoystickToPreviousOwnerOnReconnect : GetBoolFsmStateAction
    {
        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            UpdateStoreValue(ReInput.configuration.reassignJoystickToPreviousOwnerOnReconnect);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Toggles joystick auto-reassignment when re-connected to the last owning Player during runtime. This setting can be changed without resetting Rewired.")]
    public class RewiredConfigSetReassignJoystickToPreviousOwnerOnReconnect : SetBoolFsmStateAction
    {
        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate()
        {
            ReInput.configuration.reassignJoystickToPreviousOwnerOnReconnect = value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Determines the level of internal logging.")]
    public class RewiredConfigGetLogLevel : GetEnumFsmStateAction
    {
        protected override bool defaultValue_everyFrame { get { return false; } }

        [UIHint(UIHint.Variable), ObjectType(typeof(LogLevelFlags))]
        [Tooltip("Store the result in an enum variable.")]
        public FsmEnum storeValue;
        protected override FsmEnum _storeValue { get { return storeValue; } set { storeValue = value; } }

        protected override void DoUpdate()
        {
            UpdateStoreValue(ReInput.configuration.logLevel);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Determines the level of internal logging.")]
    public class RewiredConfigSetLogLevel : BaseFsmStateAction
    {
        [RequiredField]
        [Tooltip("Log Info messages.")]
        public FsmBool info;

        [RequiredField]
        [Tooltip("Log Warning messages.")]
        public FsmBool warning;

        [RequiredField]
        [Tooltip("Log Error messages.")]
        public FsmBool error;

        [RequiredField]
        [Tooltip("Log Debug messages.")]
        public FsmBool debug;

        protected override bool defaultValue_everyFrame { get { return false; } }

        public override void Reset()
        {
            base.Reset();
            info = true;
            warning = true;
            error = true;
            debug = false;
        }

        protected override void DoUpdate()
        {
            Rewired.Config.LogLevelFlags value = Rewired.Config.LogLevelFlags.Off;
            if (info.Value) value |= LogLevelFlags.Info;
            if (warning.Value) value |= LogLevelFlags.Warning;
            if (error.Value) value |= LogLevelFlags.Error;
            if (debug.Value) value |= LogLevelFlags.Debug;
            ReInput.configuration.logLevel = value;
        }
    }

    #endregion
}
