using UnityEngine;
using System.Collections.Generic;

namespace Rewired.Integration.PlayMaker {

    using HutongGames.PlayMaker;
    using HutongGames.PlayMaker.Actions;
    using HutongGames.Extensions;
    using HutongGames.Utility;

    #region Get Button

    [ActionCategory("Rewired")]
    [Tooltip("Gets the button held state of an Action. This will return TRUE as long as the button is held. This also applies to axes being used as buttons.")]
    public class RewiredPlayerGetButton : RewiredPlayerActionGetBoolFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetButton(actionName.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the button just pressed state of an Action. This will only return TRUE only on the first frame the button is pressed or for the duration of the Button Down Buffer time limit if set in the Input Behavior assigned to this Action. This also applies to axes being used as buttons.")]
    public class RewiredPlayerGetButtonDown : RewiredPlayerActionGetBoolFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetButtonDown(actionName.Value));
        }

    }

    [ActionCategory("Rewired")]
    [Tooltip("Get the button just released state for an Action. This will only return TRUE for the first frame the button is released. This also applies to axes being used as buttons.")]
    public class RewiredPlayerGetButtonUp : RewiredPlayerActionGetBoolFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetButtonUp(actionName.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the button held state of an Action during the previous frame.")]
    public class RewiredPlayerGetButtonPrev : RewiredPlayerActionGetBoolFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetButtonPrev(actionName.Value));
        }
    }
    
    [ActionCategory("Rewired")]
    [Tooltip(
        "Gets the button single pressed and held state of an Action. " +
        "This will return TRUE after a button is held and the double press timeout has expired. " +
        "This will never return TRUE if a double press occurs. " +
        "This method is delayed because it only returns TRUE after the double press timeout has expired. " +
        "Only use this method if you need to check for both a single press and a double press on the same Action. " +
        "Otherwise, use GetButton instead for instantaneous button press detection. " +
        "The double press speed is set in the Input Behavior assigned to the Action."
    )]
    public class RewiredPlayerGetButtonSinglePressHold : RewiredPlayerActionGetBoolFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetButtonSinglePressHold(actionName.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip(
        "Gets the button just single pressed and held state of an Action. " +
        "This will return TRUE for only the first frame after a button press and after the double press timeout has expired.. " +
        "This will never return TRUE if a double press occurs. " +
        "This method is delayed because it only returns TRUE after the double press timeout has expired. " +
        "Only use this method if you need to check for both a single press and a double press on the same Action. " +
        "Otherwise, use GetButtonDown instead for instantaneous button press detection. " +
        "The double press speed is set in the Input Behavior assigned to the Action."
    )]
    public class RewiredPlayerGetButtonSinglePressDown : RewiredPlayerActionGetBoolFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetButtonSinglePressDown(actionName.Value));
        }
    }
    
    [ActionCategory("Rewired")]
    [Tooltip(
        "Gets the button single pressed and just released state of an Action. " +
        "This will return TRUE for only the first frame after the release of a single press. " +
        "This will never return TRUE if a double press occurs. " +
        "This method is delayed because it only returns TRUE after the double press timeout has expired. " +
        "Only use this method if you need to check for both a single press and a double press on the same Action. " +
        "Otherwise, use GetButtonUp instead for instantaneous button press detection. " +
        "The double press speed is set in the Input Behavior assigned to the Action."
    )]
    public class RewiredPlayerGetButtonSinglePressUp : RewiredPlayerActionGetBoolFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetButtonSinglePressUp(actionName.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the button double pressed and held state of an Action. This will return TRUE after a double press and the button is then held. The double press speed is set in the Input Behavior assigned to the Action.")]
    public class RewiredPlayerGetButtonDoublePressHold : RewiredPlayerActionGetBoolFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetButtonDoublePressHold(actionName.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the button double pressed state of an Action. This will return TRUE only on the first frame of a double press. The double press speed is set in the Input Behavior assigned to the Action.")]
    public class RewiredPlayerGetButtonDoublePressDown : RewiredPlayerActionGetBoolFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetButtonDoublePressDown(actionName.Value));
        }
    }
    
    [ActionCategory("Rewired")]
    [Tooltip("Gets the button double pressed and just released state of an Action. This will return TRUE only on the first frame after double press is released. The double press speed is set in the Input Behavior assigned to the Action.")]
    public class RewiredPlayerGetButtonDoublePressUp : RewiredPlayerActionGetBoolFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetButtonDoublePressUp(actionName.Value));
        }
    }
    
    [ActionCategory("Rewired")]
    [Tooltip("Gets the button held state of an Action after being held for a period of time. This will return TRUE only after the button has been held for the specified time and will continue to return TRUE until the button is released. This also applies to axes being used as buttons.")]
    public class RewiredPlayerGetButtonTimedPress : RewiredPlayerActionGetBoolFsmStateAction {

        [UIHint(UIHint.Variable)]
        [Tooltip("Minimum time the button must be held before returning true.")]
        public FsmFloat time;

        [UIHint(UIHint.Variable)]
        [Tooltip("Time in seconds after activation that the press will expire. Once expired, it will no longer return true even if held. [0 = Never expire]")]
        public FsmFloat expireIn;

        public override void Reset() {
            base.Reset();
            time = null;
            expireIn = null;
        }

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetButtonTimedPress(actionName.Value, time.Value, expireIn.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the button state of an Action after being held for a period of time. This will return TRUE only on the frame in which the button had been held for the specified time. This also applies to axes being used as buttons.")]
    public class RewiredPlayerGetButtonTimedPressDown : RewiredPlayerActionGetBoolFsmStateAction {

        [UIHint(UIHint.Variable)]
        [Tooltip("Minimum time the button must be held before returning true.")]
        public FsmFloat time;

        public override void Reset() {
            base.Reset();
            time = null;
        }

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetButtonTimedPressDown(actionName.Value, time.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the button state of an Action after being held for a period of time and then released. This will return TRUE only on the frame in which the button had been held for at least the specified time and then released. This also applies to axes being used as buttons.")]
    public class RewiredPlayerGetButtonTimedPressUp : RewiredPlayerActionGetBoolFsmStateAction {

        [UIHint(UIHint.Variable)]
        [Tooltip("Minimum time the button must be held before returning true.")]
        public FsmFloat time;

        [UIHint(UIHint.Variable)]
        [Tooltip("Time in seconds after activation that the press will expire. Once expired, it will no longer return true even if released. [0 = Never expire]")]
        public FsmFloat expireIn;

        public override void Reset() {
            base.Reset();
            time = null;
            expireIn = null;
        }

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetButtonTimedPressUp(actionName.Value, time.Value, expireIn.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the button held state of an Action after being held for a period of time. This will return TRUE only after the button has been held for the specified time and will continue to return TRUE until the button is released. This also applies to axes being used as buttons. The button short press time is set in the Input Behavior assigned to the Action. For a custom duration, use GetButtonTimedPress instead.")]
    public class RewiredPlayerGetButtonShortPress : RewiredPlayerActionGetBoolFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetButtonShortPress(actionName.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the button state of an Action after being held for a period of time. This will return TRUE only on the frame in which the button had been held for the specified time. This also applies to axes being used as buttons. The button short press time is set in the Input Behavior assigned to the Action. For a custom duration, use GetButtonTimedPressDown instead.")]
    public class RewiredPlayerGetButtonShortPressDown : RewiredPlayerActionGetBoolFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetButtonShortPressDown(actionName.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the button state of an Action after being held for a period of time and then released. This will return TRUE only on the frame in which the button had been held for at least the specified time and then released. This also applies to axes being used as buttons. The button short press time is set in the Input Behavior assigned to the Action. For a custom duration, use GetButtonTimedPressUp instead.")]
    public class RewiredPlayerGetButtonShortPressUp : RewiredPlayerActionGetBoolFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetButtonShortPressUp(actionName.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the button held state of an Action after being held for a period of time. This will return TRUE only after the button has been held for the specified time and will continue to return TRUE until the button is released. This also applies to axes being used as buttons. The button short press time is set in the Input Behavior assigned to the Action. For a custom duration, use GetButtonTimedPress instead.")]
    public class RewiredPlayerGetButtonLongPress : RewiredPlayerActionGetBoolFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetButtonLongPress(actionName.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the button state of an Action after being held for a period of time. This will return TRUE only on the frame in which the button had been held for the specified time. This also applies to axes being used as buttons. The button short press time is set in the Input Behavior assigned to the Action. For a custom duration, use GetButtonTimedPressDown instead.")]
    public class RewiredPlayerGetButtonLongPressDown : RewiredPlayerActionGetBoolFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetButtonLongPressDown(actionName.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the button state of an Action after being held for a period of time and then released. This will return TRUE only on the frame in which the button had been held for at least the specified time and then released. This also applies to axes being used as buttons. The button short press time is set in the Input Behavior assigned to the Action. For a custom duration, use GetButtonTimedPressUp instead.")]
    public class RewiredPlayerGetButtonLongPressUp : RewiredPlayerActionGetBoolFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetButtonLongPressUp(actionName.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the repeating button state of an Action. " +
        "This will return TRUE when immediately pressed, then FALSE until the Input Behaviour button repeat delay has elapsed, " +
        "then TRUE for a 1-frame duration repeating at the interval specified in the Input Behavior assigned to the Action. " +
        "This also applies to axes being used as buttons.")]
    public class RewiredPlayerGetButtonRepeating : RewiredPlayerActionGetBoolFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetButtonRepeating(actionName.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the length of time in seconds that a button has been continuously held down. Returns 0 if the button is not currently pressed.")]
    public class RewiredPlayerGetButtonTimePressed : RewiredPlayerActionGetFloatFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue((float)Player.GetButtonTimePressed(actionName.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the length of time in seconds that a button has not been pressed. Returns 0 if the button is currently pressed.")]
    public class RewiredPlayerGetButtonTimeUnpressed : RewiredPlayerActionGetFloatFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue((float)Player.GetButtonTimeUnpressed(actionName.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the button held state of all Actions. This will return TRUE as long as any button is held. This also applies to axes being used as buttons.")]
    public class RewiredPlayerGetAnyButton : RewiredPlayerGetBoolFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetAnyButton());
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the button just pressed state of all Actions. This will only return TRUE only on the first frame any button is pressed or for the duration of the Button Down Buffer time limit if set in the Input Behavior assigned to the Action. This will return TRUE each time any button is pressed even if others are being held down. This also applies to axes being used as buttons.")]
    public class RewiredPlayerGetAnyButtonDown : RewiredPlayerGetBoolFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetAnyButtonDown());
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Get the button just released state for all Actions. This will only return TRUE for the first frame the button is released. This will return TRUE each time any button is released even if others are being held down. This also applies to axes being used as buttons.")]
    public class RewiredPlayerGetAnyButtonUp : RewiredPlayerGetBoolFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetAnyButtonUp());
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the button held state of an any Action during the previous frame. This also applies to axes being used as buttons.")]
    public class RewiredPlayerGetAnyButtonPrev : RewiredPlayerGetBoolFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetAnyButtonPrev());
        }
    }



    #endregion

    #region Get Negative Button

    [ActionCategory("Rewired")]
    [Tooltip("Gets the negative button held state of an Action. This will return TRUE as long as the negative button is held. This also applies to axes being used as buttons.")]
    public class RewiredPlayerGetNegativeButton : RewiredPlayerActionGetBoolFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetNegativeButton(actionName.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the negative button just pressed state of an Action. This will only return TRUE only on the first frame the negative button is pressed or for the duration of the Button Down Buffer time limit if set in the Input Behavior assigned to this Action. This also applies to axes being used as buttons.")]
    public class RewiredPlayerGetNegativeButtonDown : RewiredPlayerActionGetBoolFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetNegativeButtonDown(actionName.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Get the negative button just released state for an Action. This will only return TRUE for the first frame the negative button is released. This also applies to axes being used as buttons.")]
    public class RewiredPlayerGetNegativeButtonUp : RewiredPlayerActionGetBoolFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetNegativeButtonUp(actionName.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the negative button held state of an Action during the previous frame.")]
    public class RewiredPlayerGetNegativeButtonPrev : RewiredPlayerActionGetBoolFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetNegativeButtonPrev(actionName.Value));
        }
    }
    
    [ActionCategory("Rewired")]
    [Tooltip(
        "Gets the negative button single pressed and held state of an Action. " +
        "This will return TRUE after a negative button is held and the double press timeout has expired. " +
        "This will never return TRUE if a double press occurs. " +
        "This method is delayed because it only returns TRUE after the double press timeout has expired. " +
        "Only use this method if you need to check for both a single press and a double press on the same Action. " +
        "Otherwise, use GetNegativeButton instead for instantaneous negative button press detection. " +
        "The double press speed is set in the Input Behavior assigned to the Action."
    )]
    public class RewiredPlayerGetNegativeButtonSinglePressHold : RewiredPlayerActionGetBoolFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetNegativeButtonSinglePressHold(actionName.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip(
        "Gets the negative button just single pressed and held state of an Action. " +
        "This will return TRUE for only the first frame after a negative button press and after the double press timeout has expired.. " +
        "This will never return TRUE if a double press occurs. " +
        "This method is delayed because it only returns TRUE after the double press timeout has expired. " +
        "Only use this method if you need to check for both a single press and a double press on the same Action. " +
        "Otherwise, use GetNegativeButtonDown instead for instantaneous negative button press detection. " +
        "The double press speed is set in the Input Behavior assigned to the Action."
    )]
    public class RewiredPlayerGetNegativeButtonSinglePressDown : RewiredPlayerActionGetBoolFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetNegativeButtonSinglePressDown(actionName.Value));
        }
    }
    
    [ActionCategory("Rewired")]
    [Tooltip(
        "Gets the negative button single pressed and just released state of an Action. " +
        "This will return TRUE for only the first frame after the release of a single press. " +
        "This will never return TRUE if a double press occurs. " +
        "This method is delayed because it only returns TRUE after the double press timeout has expired. " +
        "Only use this method if you need to check for both a single press and a double press on the same Action. " +
        "Otherwise, use GetNegativeButtonUp instead for instantaneous negative button press detection. " +
        "The double press speed is set in the Input Behavior assigned to the Action."
    )]
    public class RewiredPlayerGetNegativeButtonSinglePressUp : RewiredPlayerActionGetBoolFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetNegativeButtonSinglePressUp(actionName.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the negative button double pressed state of an Action. This will return TRUE only on the first frame of a double press. The double press speed is set in the Input Behavior assigned to the Action.")]
    public class RewiredPlayerGetNegativeButtonDoublePressDown : RewiredPlayerActionGetBoolFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetNegativeButtonDoublePressDown(actionName.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the negative button double pressed and held state of an Action. This will return TRUE after a double press and the negative button is then held. The double press speed is set in the Input Behavior assigned to the Action.")]
    public class RewiredPlayerGetNegativeButtonDoublePressHold : RewiredPlayerActionGetBoolFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetNegativeButtonDoublePressHold(actionName.Value));
        }
    }
    
    [ActionCategory("Rewired")]
    [Tooltip("Gets the negative button double pressed and just released state of an Action. This will return TRUE only on the first frame after double press is released. The double press speed is set in the Input Behavior assigned to the Action.")]
    public class RewiredPlayerGetNegativeButtonDoublePressUp : RewiredPlayerActionGetBoolFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetNegativeButtonDoublePressUp(actionName.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the negative button held state of an Action after being held for a period of time. This will return TRUE only after the negative button has been held for the specified time and will continue to return TRUE until the negative button is released. This also applies to axes being used as negative buttons.")]
    public class RewiredPlayerGetNegativeButtonTimedPress : RewiredPlayerActionGetBoolFsmStateAction {

        [UIHint(UIHint.Variable)]
        [Tooltip("Minimum time the negative button must be held before returning true.")]
        public FsmFloat time;

        [UIHint(UIHint.Variable)]
        [Tooltip("Time in seconds after activation that the press will expire. Once expired, it will no longer return true even if held. [0 = Never expire]")]
        public FsmFloat expireIn;

        public override void Reset() {
            base.Reset();
            time = null;
            expireIn = null;
        }

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetNegativeButtonTimedPress(actionName.Value, time.Value, expireIn.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the negative button state of an Action after being held for a period of time. This will return TRUE only on the frame in which the negative button had been held for the specified time. This also applies to axes being used as negative buttons.")]
    public class RewiredPlayerGetNegativeButtonTimedPressDown : RewiredPlayerActionGetBoolFsmStateAction {

        [UIHint(UIHint.Variable)]
        [Tooltip("Minimum time the negative button must be held before returning true.")]
        public FsmFloat time;

        public override void Reset() {
            base.Reset();
            time = null;
        }

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetNegativeButtonTimedPressDown(actionName.Value, time.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the negative button state of an Action after being held for a period of time and then released. This will return TRUE only on the frame in which the negative button had been held for at least the specified time and then released. This also applies to axes being used as negative buttons.")]
    public class RewiredPlayerGetNegativeButtonTimedPressUp : RewiredPlayerActionGetBoolFsmStateAction {

        [UIHint(UIHint.Variable)]
        [Tooltip("Minimum time the negative button must be held before returning true.")]
        public FsmFloat time;

        [UIHint(UIHint.Variable)]
        [Tooltip("Time in seconds after activation that the press will expire. Once expired, it will no longer return true even if released. [0 = Never expire]")]
        public FsmFloat expireIn;

        public override void Reset() {
            base.Reset();
            time = null;
            expireIn = null;
        }

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetNegativeButtonTimedPressUp(actionName.Value, time.Value, expireIn.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the negative button held state of an Action after being held for a period of time. This will return TRUE only after the negative button has been held for the specified time and will continue to return TRUE until the negative button is released. This also applies to axes being used as negative buttons. The negative button short press time is set in the Input Behavior assigned to the Action. For a custom duration, use GetNegativeButtonTimedPress instead.")]
    public class RewiredPlayerGetNegativeButtonShortPress : RewiredPlayerActionGetBoolFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetNegativeButtonShortPress(actionName.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the negative button state of an Action after being held for a period of time. This will return TRUE only on the frame in which the negative button had been held for the specified time. This also applies to axes being used as negative buttons. The negative button short press time is set in the Input Behavior assigned to the Action. For a custom duration, use GetNegativeButtonTimedPressDown instead.")]
    public class RewiredPlayerGetNegativeButtonShortPressDown : RewiredPlayerActionGetBoolFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetNegativeButtonShortPressDown(actionName.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the negative button state of an Action after being held for a period of time and then released. This will return TRUE only on the frame in which the negative button had been held for at least the specified time and then released. This also applies to axes being used as negative buttons. The negative button short press time is set in the Input Behavior assigned to the Action. For a custom duration, use GetNegativeButtonTimedPressUp instead.")]
    public class RewiredPlayerGetNegativeButtonShortPressUp : RewiredPlayerActionGetBoolFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetNegativeButtonShortPressUp(actionName.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the negative button held state of an Action after being held for a period of time. This will return TRUE only after the negative button has been held for the specified time and will continue to return TRUE until the negative button is released. This also applies to axes being used as negative buttons. The negative button short press time is set in the Input Behavior assigned to the Action. For a custom duration, use GetNegativeButtonTimedPress instead.")]
    public class RewiredPlayerGetNegativeButtonLongPress : RewiredPlayerActionGetBoolFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetNegativeButtonLongPress(actionName.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the negative button state of an Action after being held for a period of time. This will return TRUE only on the frame in which the negative button had been held for the specified time. This also applies to axes being used as negative buttons. The negative button short press time is set in the Input Behavior assigned to the Action. For a custom duration, use GetNegativeButtonTimedPressDown instead.")]
    public class RewiredPlayerGetNegativeButtonLongPressDown : RewiredPlayerActionGetBoolFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetNegativeButtonLongPressDown(actionName.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the negative button state of an Action after being held for a period of time and then released. This will return TRUE only on the frame in which the negative button had been held for at least the specified time and then released. This also applies to axes being used as negative buttons. The negative button short press time is set in the Input Behavior assigned to the Action. For a custom duration, use GetNegativeButtonTimedPressUp instead.")]
    public class RewiredPlayerGetNegativeButtonLongPressUp : RewiredPlayerActionGetBoolFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetNegativeButtonLongPressUp(actionName.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the repeating negative button state of an Action. " +
        "This will return TRUE when immediately pressed, then FALSE until the Input Behaviour button repeat delay has elapsed, " +
        "then TRUE for a 1-frame duration repeating at the interval specified in the Input Behavior assigned to the Action. " +
        "This also applies to axes being used as buttons.")]
    public class RewiredPlayerGetNegativeButtonRepeating : RewiredPlayerActionGetBoolFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetNegativeButtonRepeating(actionName.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the length of time in seconds that a negative button has been continuously held down. Returns 0 if the negative button is not currently pressed.")]
    public class RewiredPlayerGetNegativeButtonTimePressed : RewiredPlayerActionGetFloatFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue((float)Player.GetNegativeButtonTimePressed(actionName.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the length of time in seconds that a negative button has not been pressed. Returns 0 if the negative button is currently pressed.")]
    public class RewiredPlayerGetNegativeButtonTimeUnpressed : RewiredPlayerActionGetFloatFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue((float)Player.GetNegativeButtonTimeUnpressed(actionName.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the negative button held state of all Actions. This will return TRUE as long as any negative button is held. This also applies to axes being used as buttons.")]
    public class RewiredPlayerGetAnyNegativeButton : RewiredPlayerGetBoolFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetAnyNegativeButton());
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the negative button just pressed state of all Actions. This will only return TRUE only on the first frame any negative button is pressed or for the duration of the Button Down Buffer time limit if set in the Input Behavior assigned to the Action. This will return TRUE each time any negative button is pressed even if others are being held down. This also applies to axes being used as buttons.")]
    public class RewiredPlayerGetAnyNegativeButtonDown : RewiredPlayerGetBoolFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetAnyNegativeButtonDown());
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Get the negative button just released state for all Actions. This will only return TRUE for the first frame the negative button is released. This will return TRUE each time any negative button is released even if others are being held down. This also applies to axes being used as buttons.")]
    public class RewiredPlayerGetAnyNegativeButtonUp : RewiredPlayerGetBoolFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetAnyNegativeButtonUp());
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the negative button held state of an any Action during the previous frame. This also applies to axes being used as buttons.")]
    public class RewiredPlayerGetAnyNegativeButtonPrev : RewiredPlayerGetBoolFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetAnyNegativeButtonPrev());
        }
    }

    #endregion

    #region Get Axis

    [ActionCategory("Rewired")]
    [Tooltip("Gets the axis value of an Action.")]
    public class RewiredPlayerGetAxis : RewiredPlayerActionGetFloatFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetAxis(actionName.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the axis value of an Action during the previous frame.")]
    public class RewiredPlayerGetAxisPrev : RewiredPlayerActionGetFloatFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetAxisPrev(actionName.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the change in axis value of an Action since the previous frame.")]
    public class RewiredPlayerGetAxisDelta : RewiredPlayerActionGetFloatFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetAxisDelta(actionName.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the raw axis value of an Action. The raw value excludes any digital axis simulation modification by the Input Behavior assigned to this Action. This raw value is modified by deadzone and axis calibration settings in the controller. To get truly raw values, you must get the raw value directly from the Controller element.")]
    public class RewiredPlayerGetAxisRaw : RewiredPlayerActionGetFloatFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetAxisRaw(actionName.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the raw axis value of an Action during the previous frame. The raw value excludes any digital axis simulation modification by the Input Behavior assigned to this Action. This raw value is modified by deadzone and axis calibration settings in the controller. To get truly raw values, you must get the raw value directly from the Controller element.")]
    public class RewiredPlayerGetAxisRawPrev : RewiredPlayerActionGetFloatFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetAxisRawPrev(actionName.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the change in raw axis value of an Action since the previous frame. The raw value excludes any digital axis simulation modification by the Input Behavior assigned to this Action. This raw value is modified by dead zone and axis calibration settings in the controller. To get truly raw values, you must get the raw value directly from the Controller element.")]
    public class RewiredPlayerGetAxisRawDelta : RewiredPlayerActionGetFloatFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetAxisRawDelta(actionName.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the length of time in seconds that an axis has been continuously active as calculated from the raw value. Returns 0 if the axis is not currently active.")]
    public class RewiredPlayerGetAxisTimeActive : RewiredPlayerActionGetFloatFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue((float)Player.GetAxisTimeActive(actionName.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the length of time in seconds that an axis has been inactive as calculated from the raw value. Returns 0 if the axis is currently active.")]
    public class RewiredPlayerGetAxisTimeInactive : RewiredPlayerActionGetFloatFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue((float)Player.GetAxisTimeInactive(actionName.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the length of time in seconds that an axis has been continuously active as calculated from the raw value. Returns 0 if the axis is not currently active.")]
    public class RewiredPlayerGetAxisRawTimeActive : RewiredPlayerActionGetFloatFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue((float)Player.GetAxisRawTimeActive(actionName.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the length of time in seconds that an axis has been inactive as calculated from the raw value. Returns 0 if the axis is currently active.")]
    public class RewiredPlayerGetAxisRawTimeInactive : RewiredPlayerActionGetFloatFsmStateAction {
        
        protected override void DoUpdate() {
            UpdateStoreValue((float)Player.GetAxisRawTimeInactive(actionName.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the axis value of two Actions.")]
    public class RewiredPlayerGetAxis2d : RewiredPlayerActionGetAxis2DFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetAxis2D(actionNameX.Value, actionNameY.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the axis value of two Actions during the previous frame. ")]
    public class RewiredPlayerGetAxis2dPrev : RewiredPlayerActionGetAxis2DFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetAxis2DPrev(actionNameX.Value, actionNameY.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the raw axis value of two Actions. The raw value excludes any digital axis simulation modification by the Input Behavior assigned to this Action. This raw value is modified by deadzone and axis calibration settings in the controller. To get truly raw values, you must get the raw value directly from the Controller element.")]
    public class RewiredPlayerGetAxis2dRaw : RewiredPlayerActionGetAxis2DFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetAxis2DRaw(actionNameX.Value, actionNameY.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the raw axis value of two Actions during the previous frame. The raw value excludes any digital axis simulation modification by the Input Behavior assigned to this Action. This raw value is modified by deadzone and axis calibration settings in the controller. To get truly raw values, you must get the raw value directly from the Controller element.")]
    public class RewiredPlayerGetAxis2dRawPrev : RewiredPlayerActionGetAxis2DFsmStateAction {

        protected override void DoUpdate() {
            UpdateStoreValue(Player.GetAxis2DRawPrev(actionNameX.Value, actionNameY.Value));
        }
    }

    #endregion

    #region Vibration

    [ActionCategory("Rewired")]
    [Tooltip("Sets vibration level for a motor at a specified index on controllers assigned to this Player.")]
    public class RewiredPlayerSetAllControllerVibration : RewiredPlayerFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } } 

        [Tooltip("Sets the vibration motor level. [0 - 1]")]
        public FsmFloat motorLevel;

        [Tooltip("The index of the motor to vibrate.")]
        public FsmInt motorIndex;

        [Tooltip("Length of time in seconds to activate the motor before it stops. [0 = Infinite]")]
        public FsmFloat duration;

        [Tooltip("Stop all other motors except this one.")]
        public FsmBool stopOtherMotors;

        public override void Reset() {
            base.Reset();
            motorLevel = 0.0f;
            motorIndex = 0;
            duration = 0.0f;
            stopOtherMotors = false;
        }

        protected override void DoUpdate() {
            if(motorIndex.Value < 0) return;
            motorLevel.Value = Mathf.Clamp01(motorLevel.Value);

            int joystickCount = Player.controllers.joystickCount;
            IList<Joystick> joysticks = Player.controllers.Joysticks;
            for(int i = 0; i < joystickCount; i++) {
                Joystick joystick = joysticks[i];
                if(!joystick.supportsVibration) continue;
                if(motorIndex.Value >= joystick.vibrationMotorCount) continue;
                joystick.SetVibration(motorIndex.Value, motorLevel.Value, duration.Value, stopOtherMotors.Value);
            }
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Stops vibration on all controllers assigned to this Player.")]
    public class RewiredPlayerStopAllControllerVibration : RewiredPlayerFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } } 

        protected override void DoUpdate() {
            int joystickCount = Player.controllers.joystickCount;
            IList<Joystick> joysticks = Player.controllers.Joysticks;
            for(int i = 0; i < joystickCount; i++) {
                Joystick joystick = joysticks[i];
                if(!joystick.supportsVibration) continue;
                joystick.StopVibration();
            }
        }
    }

    #endregion

    #region Player Properties

    [ActionCategory("Rewired")]
    [Tooltip("The descriptive name of the Player.")]
    public class RewiredPlayerGetName : RewiredPlayerFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } } 

        [RequiredField, UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a string variable.")]
        public FsmString storeValue;

        public override void Reset() {
            base.Reset();
        }

        protected override void DoUpdate() {
            storeValue.Value = Player.name;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("The scripting name of the Player.")]
    public class RewiredPlayerGetDescriptiveName : RewiredPlayerFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } } 

        [RequiredField, UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a string variable.")]
        public FsmString storeValue;

        public override void Reset() {
            base.Reset();
        }

        protected override void DoUpdate() {
            storeValue.Value = Player.descriptiveName;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Is this Player currently playing?")]
    public class RewiredPlayerGetIsPlaying : RewiredPlayerFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } } 

        [RequiredField, UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a boolean variable.")]
        public FsmBool storeValue;

        public override void Reset() {
            base.Reset();
        }

        protected override void DoUpdate() {
            storeValue.Value = Player.isPlaying;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Sets whether this Player currently playing.")]
    public class RewiredPlayerSetIsPlaying : RewiredPlayerFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } } 

        [RequiredField]
        [Tooltip("Sets the boolean value.")]
        public FsmBool value;

        public override void Reset() {
            base.Reset();
        }

        protected override void DoUpdate() {
            Player.isPlaying = value.Value;
        }
    }

    #endregion

    #region ControllerHelper

    [ActionCategory("Rewired")]
    [Tooltip("Is the mouse assigned to this Player?")]
    public class RewiredPlayerGetHasMouse : RewiredPlayerFsmStateAction {

        [RequiredField, UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a boolean variable.")]
        public FsmBool storeValue;

        public override void Reset() {
            base.Reset();
        }

        protected override void DoUpdate() {
            storeValue.Value = Player.controllers.hasMouse;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Sets whether the mouse is assigned to this Player.")]
    public class RewiredPlayerSetHasMouse : RewiredPlayerFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } } 

        [RequiredField]
        [Tooltip("Sets the boolean value.")]
        public FsmBool value;

        public override void Reset() {
            base.Reset();
        }

        protected override void DoUpdate() {
            Player.controllers.hasMouse = value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the number of joysticks assigned to this Player.")]
    public class RewiredPlayerGetJoystickCount : RewiredPlayerFsmStateAction {

        [RequiredField, UIHint(UIHint.Variable)]
        [Tooltip("Store the result in an int variable.")]
        public FsmInt storeValue;

        public override void Reset() {
            base.Reset();
        }

        protected override void DoUpdate() {
            storeValue.Value = Player.controllers.joystickCount;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets a list of Joystick ids assigned to this Player.")]
    public class RewiredPlayerGetJoystickIds : RewiredPlayerGetIntArrayFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            Player player = Player;
            if(player == null) return;

            IList<Joystick> joysticks = player.controllers.Joysticks;
            int count = joysticks != null ? joysticks.Count : 0;

            for(int i = 0; i < count; i++) {
                workingList.Add(joysticks[i].id);
            }

            UpdateStoreValue();
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the number of Custom Controllers assigned to this Player.")]
    public class RewiredPlayerGetCustomControllerCount : RewiredPlayerFsmStateAction {

        [RequiredField, UIHint(UIHint.Variable)]
        [Tooltip("Store the result in an int variable.")]
        public FsmInt storeValue;

        public override void Reset() {
            base.Reset();
        }

        protected override void DoUpdate() {
            storeValue.Value = Player.controllers.customControllerCount;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets a list of CustomController ids assigned to this Player.")]
    public class RewiredPlayerGetCustomControllerIds : RewiredPlayerGetIntArrayFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            Player player = Player;
            if(player == null) return;

            IList<CustomController> customControllers = player.controllers.CustomControllers;
            int count = customControllers != null ? customControllers.Count : 0;

            for(int i = 0; i < count; i++) {
                workingList.Add(customControllers[i].id);
            }

            UpdateStoreValue();
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets whether controllers can be auto-assigned to this Player.")]
    public class RewiredPlayerGetExcludeFromControllerAutoAssignment : RewiredPlayerGetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            UpdateStoreValue(Player.controllers.excludeFromControllerAutoAssignment);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Sets whether controllers can be auto-assigned to this Player..")]
    public class RewiredPlayerSetExcludeFromControllerAutoAssignment : RewiredPlayerSetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            Player.controllers.excludeFromControllerAutoAssignment = value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Assign a controller to this Player.")]
    public class RewiredPlayerAddController : RewiredPlayerFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } } 

        [RequiredField, ObjectType(typeof(ControllerType))]
        [Tooltip("The type of the controller.")]
        public FsmEnum controllerType;

        [RequiredField]
        [Tooltip("Controller Id of the controller. This currently only applies to Joystick and Custom controller types.")]
        public FsmInt controllerId = 0;

        [Tooltip("Unassign this controller from other Players?")]
        public FsmBool removeFromOtherPlayers = true;

        public override void Reset() {
            base.Reset();
            controllerType = null;
            controllerId = 0;
            removeFromOtherPlayers = true;
        }

        protected override void DoUpdate() {
            Player.controllers.AddController((ControllerType)controllerType.Value, controllerId.Value, removeFromOtherPlayers.Value);
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
    [Tooltip("Unassign a controller from this Player.")]
    public class RewiredPlayerRemoveController : RewiredPlayerFsmStateAction {

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
            Player.controllers.RemoveController((ControllerType)controllerType.Value, controllerId.Value);
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
    [Tooltip("Unassign controllers from this Player.")]
    public class RewiredPlayerRemoveControllers : RewiredPlayerFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [Tooltip("Remove only controllers of a certain type. If false, all assignable controllers will be removed.")]
        public FsmBool byControllerType;

        [Tooltip("Controller type to remove from Player. Not used if Clear By Controller Type is false.")]
        [ObjectType(typeof(ControllerType))]
        public FsmEnum controllerType;

        public override void Reset() {
            base.Reset();
            byControllerType = false;
            controllerType = null;
        }

        protected override void DoUpdate() {
            if(byControllerType.Value) {
                Player.controllers.ClearControllersOfType((ControllerType)controllerType.Value);
            } else {
                Player.controllers.ClearAllControllers();
            }
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Checks if a controller is assigned to this Player.")]
    public class RewiredPlayerContainsController : RewiredPlayerFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } } 

        [RequiredField, ObjectType(typeof(ControllerType))]
        [Tooltip("The type of the controller.")]
        public FsmEnum controllerType;

        [RequiredField]
        [Tooltip("Controller Id of the controller. This currently only applies to Joystick and Custom controller types.")]
        public FsmInt controllerId = 0;

        [RequiredField, UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a boolean variable.")]
        public FsmBool storeValue;

        public override void Reset() {
            base.Reset();
            controllerType = null;
            controllerId = 0;
            storeValue = false;
        }

        protected override void DoUpdate() {
            storeValue.Value = Player.controllers.ContainsController((ControllerType)controllerType.Value, controllerId.Value);
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
    [Tooltip("Get the last controller type that contributed input through the Player.")]
    public class RewiredPlayerGetLastActiveControllerType : RewiredPlayerFsmStateAction {

        [RequiredField, UIHint(UIHint.Variable), ObjectType(typeof(ControllerType))]
        [Tooltip("Store the result in an enum variable.")]
        public FsmEnum storeValue;

        public override void Reset() {
            base.Reset();
            storeValue = null;
        }

        protected override void DoUpdate() {
            Controller controller = Player.controllers.GetLastActiveController();
            if(controller == null) {
                storeValue.Value = ControllerType.Keyboard;
                return;
            }
            storeValue.Value = controller.type;
        }
    }

    #endregion

    #region MapHelper

    [ActionCategory("Rewired")]
    [Tooltip("Removes all controller maps or maps of a specific type.")]
    public class RewiredPlayerClearControllerMaps : RewiredPlayerFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [Tooltip("If this is true, all maps for the controller type set in Controller Type will be cleared. If this is false, all maps will be cleared.")]
        public FsmBool byControllerType;

        [Tooltip("Clear maps of a particular controller type. Not used if Set By Controller Type is false.")]
        [ObjectType(typeof(ControllerType))]
        public FsmEnum controllerType;

        [Tooltip("If true, only maps that are flagged user-assignable will be cleared, otherwise all maps will be cleared.")]
        public FsmBool userAssignableOnly;

        public override void Reset() {
            base.Reset();
            byControllerType = false;
            controllerType = Tools.CreateFsmEnum(ControllerType.Keyboard);
        }

        protected override void DoUpdate() {
            if(byControllerType.Value) {
                Player.controllers.maps.ClearMaps((ControllerType)controllerType.Value, userAssignableOnly.Value);
            } else {
                Player.controllers.maps.ClearAllMaps(userAssignableOnly.Value);
            }
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Loads the maps defined in the Rewired Editor and assigned to this player for the specified controller type. All existing maps will be cleared and replaced with the default maps. The Enabled state of each map will attempt to be preserved, but if you have added or removed maps through scripting, the result may not be as expected and you should set the Enabled states manually.")]
    public class RewiredPlayerLoadDefaultControllerMaps : RewiredPlayerFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [Tooltip("Default maps will be loaded for all controllers of this controller type.")]
        [ObjectType(typeof(ControllerType))]
        public FsmEnum controllerType;

        public override void Reset() {
            base.Reset();
            controllerType = Tools.CreateFsmEnum(ControllerType.Keyboard);
        }

        protected override void DoUpdate() {
            Player.controllers.maps.LoadDefaultMaps((ControllerType)controllerType.Value);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Loads a controller map from the maps defined in the Rewired Editor. Replaces if a map already exists with the same category and layout.")]
    public class RewiredPlayerLoadControllerMap : RewiredPlayerFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [Tooltip("Controller type.")]
        [ObjectType(typeof(ControllerType))]
        public FsmEnum controllerType;

        [Tooltip("Controller id - Get this from the Controller.id property. For Keyboard and Mouse, just use 0.")]
        public FsmInt controllerId = 0;

        [Tooltip("Category name")]
        public FsmString categoryName;

        [Tooltip("Layout name")]
        public FsmString layoutName;

        [Tooltip("Start this map enabled?")]
        public FsmBool startEnabled = true;

        public override void Reset() {
            base.Reset();
            controllerType = Tools.CreateFsmEnum(ControllerType.Keyboard);
            controllerId = 0;
            categoryName = string.Empty;
            layoutName = string.Empty;
            startEnabled = true;
        }

        protected override void DoUpdate() {
            Player.controllers.maps.LoadMap((ControllerType)controllerType.Value, controllerId.Value, categoryName.Value, layoutName.Value, startEnabled.Value);
        }

        protected override bool ValidateVars() {
            if(!base.ValidateVars()) return false;

            if(ReInput.controllers.GetController((ControllerType)controllerType.Value, controllerId.Value) == null) {
                return false;
            }

            if(ReInput.mapping.GetActionCategory(categoryName.Name) == null) {
                Debug.Log(categoryName.Value + " is not a valid Map Category.");
                return false;
            }

            if(ReInput.mapping.GetLayout((ControllerType)controllerType.Value, layoutName.Name) == null) {
                Debug.Log(layoutName.Value + " is not a valid Layout for controller type " + ((ControllerType)controllerType.Value).ToString());
                return false;
            }

            return true;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Removes a controller map for a specific controller.")]
    public class RewiredPlayerRemoveControllerMap : RewiredPlayerFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [Tooltip("Controller type.")]
        [ObjectType(typeof(ControllerType))]
        public FsmEnum controllerType;

        [Tooltip("Controller id - Get this from the Controller.id property. For Keyboard and Mouse, just use 0.")]
        public FsmInt controllerId = 0;

        [Tooltip("Category name")]
        public FsmString categoryName;

        [Tooltip("Layout name")]
        public FsmString layoutName;

        public override void Reset() {
            base.Reset();
            controllerType = Tools.CreateFsmEnum(ControllerType.Keyboard);
            controllerId = 0;
            categoryName = string.Empty;
            layoutName = string.Empty;
        }

        protected override void DoUpdate() {
            Player.controllers.maps.RemoveMap((ControllerType)controllerType.Value, controllerId.Value, categoryName.Value, layoutName.Value);
        }

        protected override bool ValidateVars() {
            if(!base.ValidateVars()) return false;

            if(ReInput.controllers.GetController((ControllerType)controllerType.Value, controllerId.Value) == null) {
                return false;
            }

            if(ReInput.mapping.GetActionCategory(categoryName.Name) == null) {
                Debug.Log(categoryName.Value + " is not a valid Map Category.");
                return false;
            }

            if(ReInput.mapping.GetLayout((ControllerType)controllerType.Value, layoutName.Name) == null) {
                Debug.Log(layoutName.Value + " is not a valid Layout for controller type " + ((ControllerType)controllerType.Value).ToString());
                return false;
            }

            return true;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Set the enabled state in all maps in a particular category and/or layout.")]
    public class RewiredPlayerSetControllerMapsEnabled : RewiredPlayerFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } } 

        [RequiredField]
        [Tooltip("Set the enabled state.")]
        public FsmBool enabledState;

        [RequiredField]
        [Tooltip("The Controller Map category name.")]
        public FsmString categoryName;

        [Tooltip("The Controller Map layout name. [Optional]")]
        public FsmString layoutName;

        [Tooltip("Set the enabled state of maps for a particular controller type.")]
        public FsmBool byControllerType;

        [Tooltip("Set the enabled state of maps for a particular controller type. Not used if Set By Controller Type is false.")]
        public ControllerType controllerType = ControllerType.Joystick;

        public override void Reset() {
            base.Reset();
            categoryName = string.Empty;
            layoutName = string.Empty;
            byControllerType = false;
            controllerType = ControllerType.Joystick;
        }

        protected override void DoUpdate() {
            SetMapsEnabled();
        }

        private void SetMapsEnabled() {
            if(byControllerType.Value) {
                SetMapsEnabled(enabledState.Value, controllerType, categoryName.Value, layoutName.Value);
            } else {
                SetMapsEnabled(enabledState.Value, categoryName.Value, layoutName.Value);
            }
        }

        private void SetMapsEnabled(bool state, ControllerType controllerType, string categoryName, string layoutName) {
            if(string.IsNullOrEmpty(layoutName)) Player.controllers.maps.SetMapsEnabled(state, controllerType, categoryName);
            else Player.controllers.maps.SetMapsEnabled(state, controllerType, categoryName, layoutName);
        }

        private void SetMapsEnabled(bool state, string categoryName, string layoutName) {
            if(string.IsNullOrEmpty(layoutName)) Player.controllers.maps.SetMapsEnabled(state, categoryName);
            else Player.controllers.maps.SetMapsEnabled(state, categoryName, layoutName);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Set the enabled state in all controller maps.")]
    public class RewiredPlayerSetAllControllerMapsEnabled : RewiredPlayerFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } } 

        [RequiredField]
        [Tooltip("Set the enabled state.")]
        public FsmBool enabledState;

        [Tooltip("Set the enabled state of maps for a particular controller type.")]
        public FsmBool byControllerType;

        [Tooltip("Set the enabled state of maps for a particular controller type. Not used if Set By Controller Type is false.")]
        public ControllerType controllerType = ControllerType.Joystick;

        public override void Reset() {
            base.Reset();
            byControllerType = false;
            controllerType = ControllerType.Joystick;
        }

        protected override void DoUpdate() {
            SetMapsEnabled();
        }

        private void SetMapsEnabled() {
            if(byControllerType.Value) {
                Player.controllers.maps.SetAllMapsEnabled(enabledState.Value, controllerType);
            } else {
                Player.controllers.maps.SetAllMapsEnabled(enabledState.Value);
            }
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Get the first ActionElementMap id for that contains a specific Action.")]
    public class RewiredPlayerGetFirstElementMapIdWithAction : RewiredPlayerActionFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField()]
        [UIHint(UIHint.Variable)]
        [Tooltip("Store the Action Element Map id result in a variable. A value of -1 means no matching ActionElementMap was found.")]
        public FsmInt storeValue;

        [Tooltip("Get element map for only controllers of a certain type. If false, all controller types will be used.")]
        public FsmBool byControllerType;

        [Tooltip("Controller type. Ignored if By Controller Type is False.")]
        [ObjectType(typeof(ControllerType))]
        public FsmEnum controllerType;

        [Tooltip("Get the element map for a controller with a particular controller id. If false, only the Controller Type will be used. Ignored if By Controller Type is False.")]
        public FsmBool byControllerId;

        [Tooltip("Controller id - Get this from the Controller.id property. For Keyboard and Mouse, just use 0. Ignored if By Controller Type or By Controller Id is False.")]
        public FsmInt controllerId;

        [Tooltip("Get element map for only controller elements of a certain type. If false, all controller element types will be used.")]
        public FsmBool byElementType;

        [Tooltip("Get element map for a specific controller element type.")]
        [ObjectType(typeof(ControllerElementType))]
        public FsmEnum elementType;

        [Tooltip("Get element map only if it has a specific Axis Contribution to the Action value.")]
        public FsmBool byAxisContribution;

        [Tooltip("The Axis Contribution to match.")]
        [ObjectType(typeof(AxisRange))]
        public FsmEnum axisContribution;

        [Tooltip("Skip disabled Controller Maps?")]
        public FsmBool skipDisabledMaps;

        public override void Reset() {
            base.Reset();
            storeValue = -1;
            byElementType = false;
            elementType = Tools.CreateFsmEnum(ControllerElementType.Button);
            byControllerType = false;
            controllerType = Tools.CreateFsmEnum(ControllerType.Keyboard);
            byControllerId = false;
            controllerId = 0;
            byAxisContribution = false;
            axisContribution = Tools.CreateFsmEnum(AxisRange.Full);
            skipDisabledMaps = true;
        }

        protected override bool ValidateVars() {
            if(!base.ValidateVars()) return false;

            if(byControllerType.Value && byControllerId.Value) {
                if(ReInput.controllers.GetController((ControllerType)controllerType.Value, controllerId.Value) == null) {
                    return false;
                }
            }

            return true;
        }

        protected override void DoUpdate() {
            Go();
        }

        private void Go() {
            ActionElementMap aem = null;

            if(byControllerType.Value) {
                if(byControllerId.Value) {
                    aem = GetFirstElementMapWithAction((ControllerType)controllerType.Value, actionName.Value, skipDisabledMaps.Value);
                } else {
                    aem = GetFirstElementMapWithAction((ControllerType)controllerType.Value, controllerId.Value, actionName.Value, skipDisabledMaps.Value);
                }
            } else {
                aem = GetFirstElementMapWithAction(actionName.Value, skipDisabledMaps.Value);
            }

            int aemId = aem != null ? aem.id : -1;
            storeValue.Value = aemId;
        }

        private ActionElementMap GetFirstElementMapWithAction(ControllerType controllerType, string actionName, bool skipDisabledMaps) {
            if(byElementType.Value) {
                ControllerElementType type = (ControllerElementType)elementType.Value;
                switch(type) {
                    case ControllerElementType.Axis:
                        if(byAxisContribution.Value) {
                            foreach(var aem in Player.controllers.maps.AxisMapsWithAction(controllerType, actionName, skipDisabledMaps)) {
                                if(AxisContributionMatches(aem, (AxisRange)axisContribution.Value)) return aem;
                            }
                            return null;
                        } else {
                            return Player.controllers.maps.GetFirstAxisMapWithAction(controllerType, actionName, skipDisabledMaps);
                        }
                    case ControllerElementType.Button:
                        if(byAxisContribution.Value) {
                            foreach(var aem in Player.controllers.maps.ButtonMapsWithAction(controllerType, actionName, skipDisabledMaps)) {
                                if(AxisContributionMatches(aem, (AxisRange)axisContribution.Value)) return aem;
                            }
                            return null;
                        } else {
                            return Player.controllers.maps.GetFirstButtonMapWithAction(controllerType, actionName, skipDisabledMaps);
                        }
                    case ControllerElementType.CompoundElement:
                    default:
                        Debug.LogWarning(type.ToString() + " is not a supported Controller Element Type.");
                        return null;
                }
            } else {
                if(byAxisContribution.Value) {
                    foreach(var aem in Player.controllers.maps.ElementMapsWithAction(controllerType, actionName, skipDisabledMaps)) {
                        if(AxisContributionMatches(aem, (AxisRange)axisContribution.Value)) return aem;
                    }
                    return null;
                } else {
                    return Player.controllers.maps.GetFirstElementMapWithAction(controllerType, actionName, skipDisabledMaps);
                }
            }
        }

        private ActionElementMap GetFirstElementMapWithAction(ControllerType controllerType, int controllerId, string actionName, bool skipDisabledMaps) {
            var controller = ReInput.controllers.GetController(controllerType, controllerId);
            if(controller == null) return null;
            if(byElementType.Value) {
                ControllerElementType type = (ControllerElementType)elementType.Value;
                switch(type) {
                    case ControllerElementType.Axis:
                        if(byAxisContribution.Value) {
                            foreach(var aem in Player.controllers.maps.AxisMapsWithAction(controller, actionName, skipDisabledMaps)) {
                                if(AxisContributionMatches(aem, (AxisRange)axisContribution.Value)) return aem;
                            }
                            return null;
                        } else {
                            return Player.controllers.maps.GetFirstAxisMapWithAction(controller, actionName, skipDisabledMaps);
                        }
                    case ControllerElementType.Button:
                        if(byAxisContribution.Value) {
                            foreach(var aem in Player.controllers.maps.ButtonMapsWithAction(controller, actionName, skipDisabledMaps)) {
                                if(AxisContributionMatches(aem, (AxisRange)axisContribution.Value)) return aem;
                            }
                            return null;
                        } else {
                            return Player.controllers.maps.GetFirstButtonMapWithAction(controller, actionName, skipDisabledMaps);
                        }
                    case ControllerElementType.CompoundElement:
                    default:
                        Debug.LogWarning(type.ToString() + " is not a supported Controller Element Type.");
                        return null;
                }
            } else {
                if(byAxisContribution.Value) {
                    foreach(var aem in Player.controllers.maps.ElementMapsWithAction(controller, actionName, skipDisabledMaps)) {
                        if(AxisContributionMatches(aem, (AxisRange)axisContribution.Value)) return aem;
                    }
                    return null;
                } else {
                    return Player.controllers.maps.GetFirstElementMapWithAction(controller, actionName, skipDisabledMaps);
                }
            }
        }

        private ActionElementMap GetFirstElementMapWithAction(string actionName, bool skipDisabledMaps) {
            if(byElementType.Value) {
                ControllerElementType type = (ControllerElementType)elementType.Value;
                switch(type) {
                    case ControllerElementType.Axis:
                        if(byAxisContribution.Value) {
                            foreach(var aem in Player.controllers.maps.AxisMapsWithAction(actionName, skipDisabledMaps)) {
                                if(AxisContributionMatches(aem, (AxisRange)axisContribution.Value)) return aem;
                            }
                            return null;
                        } else {
                            return Player.controllers.maps.GetFirstAxisMapWithAction(actionName, skipDisabledMaps);
                        }
                    case ControllerElementType.Button:
                        if(byAxisContribution.Value) {
                            foreach(var aem in Player.controllers.maps.ButtonMapsWithAction(actionName, skipDisabledMaps)) {
                                if(AxisContributionMatches(aem, (AxisRange)axisContribution.Value)) return aem;
                            }
                            return null;
                        } else {
                            return Player.controllers.maps.GetFirstButtonMapWithAction(actionName, skipDisabledMaps);
                        }
                    case ControllerElementType.CompoundElement:
                    default:
                        Debug.LogWarning(type.ToString() + " is not a supported Controller Element Type.");
                        return null;
                }
            } else {
                if(byAxisContribution.Value) {
                    foreach(var aem in Player.controllers.maps.ElementMapsWithAction(actionName, skipDisabledMaps)) {
                        if(AxisContributionMatches(aem, (AxisRange)axisContribution.Value)) return aem;
                    }
                    return null;
                } else {
                    return Player.controllers.maps.GetFirstElementMapWithAction(actionName, skipDisabledMaps);
                }
            }
        }

        private static bool AxisContributionMatches(ActionElementMap aem, AxisRange axisContribution) {
            switch(aem.elementType) {
                case ControllerElementType.Axis:
                    if(aem.axisRange == AxisRange.Full) { // full axis
                        return axisContribution == AxisRange.Full;
                    } else { // split axis
                        if(axisContribution == AxisRange.Positive) {
                            return aem.axisContribution == Pole.Positive;
                        } else if(axisContribution == AxisRange.Negative) {
                            return aem.axisContribution == Pole.Negative;
                        }
                        return false;
                    }
                case ControllerElementType.Button: {
                        if(axisContribution == AxisRange.Positive) {
                            return aem.axisContribution == Pole.Positive;
                        } else if(axisContribution == AxisRange.Negative) {
                            return aem.axisContribution == Pole.Negative;
                        }
                        return false;
                    }
                case ControllerElementType.CompoundElement:
                default:
                    Debug.LogWarning(aem.elementType.ToString() + " is not a supported Controller Element Type.");
                    return false;
            }
        }
    }

    #endregion

    #region Input Behaviors

    [ActionCategory("Rewired")]
    [Tooltip("Get and store the value of InputBehavior.digitalAxisSimulation for a Player.")]
    public class RewiredPlayerInputBehaviorGetDigitalAxisSimulation : RewiredPlayerInputBehaviorFsmStateAction {

        [RequiredField, UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a boolean variable.")]
        public FsmBool storeValue;

        public override void Reset() {
            base.Reset();
            storeValue = false;
        }

        protected override void DoUpdate() {
            if(Behavior == null) return;
            storeValue.Value = Behavior.digitalAxisSimulation;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Get and store the value of InputBehavior.digitalAxisGravity for a Player.")]
    public class RewiredPlayerInputBehaviorGetDigitalAxisGravity : RewiredPlayerInputBehaviorFsmStateAction {

        [RequiredField, UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a float variable.")]
        public FsmFloat storeValue;

        public override void Reset() {
            base.Reset();
            storeValue = 0.0f;
        }

        protected override void DoUpdate() {
            if(Behavior == null) return;
            storeValue.Value = Behavior.digitalAxisGravity;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Get and store the value of InputBehavior.digitalAxisSensitivity for a Player.")]
    public class RewiredPlayerInputBehaviorGetDigitalAxisSensitivity : RewiredPlayerInputBehaviorFsmStateAction {

        [RequiredField, UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a float variable.")]
        public FsmFloat storeValue;

        public override void Reset() {
            base.Reset();
            storeValue = 0.0f;
        }

        protected override void DoUpdate() {
            if(Behavior == null) return;
            storeValue.Value = Behavior.digitalAxisSensitivity;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Get and store the value of InputBehavior.digitalAxisSnap for a Player.")]
    public class RewiredPlayerInputBehaviorGetDigitalAxisSnap : RewiredPlayerInputBehaviorFsmStateAction {

        [RequiredField, UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a boolean variable.")]
        public FsmBool storeValue;

        public override void Reset() {
            base.Reset();
            storeValue = false;
        }

        protected override void DoUpdate() {
            if(Behavior == null) return;
            storeValue.Value = Behavior.digitalAxisSnap;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Get and store the value of InputBehavior.digitalAxisInstantReverse for a Player.")]
    public class RewiredPlayerInputBehaviorGetDigitalAxisInstantReverse : RewiredPlayerInputBehaviorFsmStateAction {

        [RequiredField, UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a boolean variable.")]
        public FsmBool storeValue;

        public override void Reset() {
            base.Reset();
            storeValue = false;
        }

        protected override void DoUpdate() {
            if(Behavior == null) return;
            storeValue.Value = Behavior.digitalAxisInstantReverse;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Get and store the value of InputBehavior.joystickAxisSensitivity for a Player.")]
    public class RewiredPlayerInputBehaviorGetJoystickAxisSensitivity : RewiredPlayerInputBehaviorFsmStateAction {

        [RequiredField, UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a float variable.")]
        public FsmFloat storeValue;

        public override void Reset() {
            base.Reset();
            storeValue = 0.0f;
        }

        protected override void DoUpdate() {
            if(Behavior == null) return;
            storeValue.Value = Behavior.joystickAxisSensitivity;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Get and store the value of InputBehavior.customControllerAxisGravity for a Player.")]
    public class RewiredPlayerInputBehaviorGetCustomControllerAxisSensitivity : RewiredPlayerInputBehaviorFsmStateAction {

        [RequiredField, UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a float variable.")]
        public FsmFloat storeValue;

        public override void Reset() {
            base.Reset();
            storeValue = 0.0f;
        }

        protected override void DoUpdate() {
            if(Behavior == null) return;
            storeValue.Value = Behavior.customControllerAxisSensitivity;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Get and store the value of InputBehavior.mouseXYAxisMode for a Player.")]
    public class RewiredPlayerInputBehaviorGetMouseXYAxisMode : RewiredPlayerInputBehaviorFsmStateAction {

        [RequiredField, UIHint(UIHint.Variable)]
        [Tooltip("Store the result in an int variable.")]
        public FsmInt storeValue;

        public override void Reset() {
            base.Reset();
            storeValue = 0;
        }

        protected override void DoUpdate() {
            if(Behavior == null) return;
            storeValue.Value = (int)Behavior.mouseXYAxisMode;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Get and store the value of InputBehavior.mouseXYAxisSensitivity for a Player.")]
    public class RewiredPlayerInputBehaviorGetMouseXYAxisSensitivity : RewiredPlayerInputBehaviorFsmStateAction {

        [RequiredField, UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a float variable.")]
        public FsmFloat storeValue;

        public override void Reset() {
            base.Reset();
            storeValue = 0.0f;
        }

        protected override void DoUpdate() {
            if(Behavior == null) return;
            storeValue.Value = Behavior.mouseXYAxisSensitivity;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Get and store the value of InputBehavior.mouseXYAxisDeltaCalc for a Player.")]
    public class RewiredPlayerInputBehaviorGetMouseXYAxisDeltaCalc : RewiredPlayerInputBehaviorFsmStateAction {

        [RequiredField, UIHint(UIHint.Variable)]
        [Tooltip("Store the result in an int variable.")]
        public FsmInt storeValue;

        public override void Reset() {
            base.Reset();
            storeValue = 0;
        }

        protected override void DoUpdate() {
            if(Behavior == null) return;
            storeValue.Value = (int)Behavior.mouseXYAxisDeltaCalc;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Get and store the value of InputBehavior.mouseOtherAxisMode for a Player.")]
    public class RewiredPlayerInputBehaviorGetMouseOtherAxisMode : RewiredPlayerInputBehaviorFsmStateAction {

        [RequiredField, UIHint(UIHint.Variable)]
        [Tooltip("Store the result in an int variable.")]
        public FsmInt storeValue;

        public override void Reset() {
            base.Reset();
            storeValue = 0;
        }

        protected override void DoUpdate() {
            if(Behavior == null) return;
            storeValue.Value = (int)Behavior.mouseOtherAxisMode;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Get and store the value of InputBehavior.mouseOtherAxisSensitivity for a Player.")]
    public class RewiredPlayerInputBehaviorGetMouseOtherAxisSensitivity : RewiredPlayerInputBehaviorFsmStateAction {

        [RequiredField, UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a float variable.")]
        public FsmFloat storeValue;

        public override void Reset() {
            base.Reset();
            storeValue = 0.0f;
        }

        protected override void DoUpdate() {
            if(Behavior == null) return;
            storeValue.Value = Behavior.mouseOtherAxisSensitivity;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Get and store the value of InputBehavior.buttonDeadZone for a Player.")]
    public class RewiredPlayerInputBehaviorGetButtonDeadZone : RewiredPlayerInputBehaviorFsmStateAction {

        [RequiredField, UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a float variable.")]
        public FsmFloat storeValue;

        public override void Reset() {
            base.Reset();
            storeValue = 0.0f;
        }

        protected override void DoUpdate() {
            if(Behavior == null) return;
            storeValue.Value = Behavior.buttonDeadZone;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Get and store the value of InputBehavior.buttonDoublePressSpeed for a Player.")]
    public class RewiredPlayerInputBehaviorGetButtonDoublePressSpeed : RewiredPlayerInputBehaviorFsmStateAction {

        [RequiredField, UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a float variable.")]
        public FsmFloat storeValue;

        public override void Reset() {
            base.Reset();
            storeValue = 0.0f;
        }

        protected override void DoUpdate() {
            if(Behavior == null) return;
            storeValue.Value = Behavior.buttonDoublePressSpeed;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Get and store the value of InputBehavior.buttonShortPressTime for a Player.")]
    public class RewiredPlayerInputBehaviorGetButtonShortPressTime : RewiredPlayerInputBehaviorFsmStateAction {

        [RequiredField, UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a float variable.")]
        public FsmFloat storeValue;

        public override void Reset() {
            base.Reset();
            storeValue = 0.0f;
        }

        protected override void DoUpdate() {
            if(Behavior == null) return;
            storeValue.Value = Behavior.buttonShortPressTime;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Get and store the value of InputBehavior.buttonShortPressExpiresIn for a Player.")]
    public class RewiredPlayerInputBehaviorGetButtonShortPressExpiresIn : RewiredPlayerInputBehaviorFsmStateAction {

        [RequiredField, UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a float variable.")]
        public FsmFloat storeValue;

        public override void Reset() {
            base.Reset();
            storeValue = 0.0f;
        }

        protected override void DoUpdate() {
            if(Behavior == null) return;
            storeValue.Value = Behavior.buttonShortPressExpiresIn;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Get and store the value of InputBehavior.buttonLongPressTime for a Player.")]
    public class RewiredPlayerInputBehaviorGetButtonLongPressTime : RewiredPlayerInputBehaviorFsmStateAction {

        [RequiredField, UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a float variable.")]
        public FsmFloat storeValue;

        public override void Reset() {
            base.Reset();
            storeValue = 0.0f;
        }

        protected override void DoUpdate() {
            if(Behavior == null) return;
            storeValue.Value = Behavior.buttonLongPressTime;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Get and store the value of InputBehavior.buttonLongPressExpiresIn for a Player.")]
    public class RewiredPlayerInputBehaviorGetButtonLongPressExpiresIn : RewiredPlayerInputBehaviorFsmStateAction {

        [RequiredField, UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a float variable.")]
        public FsmFloat storeValue;

        public override void Reset() {
            base.Reset();
            storeValue = 0.0f;
        }

        protected override void DoUpdate() {
            if(Behavior == null) return;
            storeValue.Value = Behavior.buttonLongPressExpiresIn;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Get and store the value of InputBehavior.buttonDownBuffer for a Player.")]
    public class RewiredPlayerInputBehaviorGetButtonDownBuffer : RewiredPlayerInputBehaviorFsmStateAction {

        [RequiredField, UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a float variable.")]
        public FsmFloat storeValue;

        public override void Reset() {
            base.Reset();
            storeValue = 0.0f;
        }

        protected override void DoUpdate() {
            if(Behavior == null) return;
            storeValue.Value = Behavior.buttonDownBuffer;
        }
    }

    // Set

    [ActionCategory("Rewired")]
    [Tooltip("Set the value of InputBehavior.digitalAxisSimulation for a Player.")]
    public class RewiredPlayerInputBehaviorSetDigitalAxisSimulation : RewiredPlayerInputBehaviorFsmStateAction {

        [RequiredField]
        [Tooltip("Set the value.")]
        public FsmBool value;

        public override void Reset() {
            base.Reset();
            value = false;
        }

        protected override void DoUpdate() {
            if(Behavior == null) return;
            Behavior.digitalAxisSimulation = value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Set the value of InputBehavior.digitalAxisGravity for a Player.")]
    public class RewiredPlayerInputBehaviorSetDigitalAxisGravity : RewiredPlayerInputBehaviorFsmStateAction {

        [RequiredField]
        [Tooltip("Set the value.")]
        public FsmFloat value;

        public override void Reset() {
            base.Reset();
            value = 0.0f;
        }

        protected override void DoUpdate() {
            if(Behavior == null) return;
            Behavior.digitalAxisGravity = value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Set the value of InputBehavior.digitalAxisSensitivity for a Player.")]
    public class RewiredPlayerInputBehaviorSetDigitalAxisSensitivity : RewiredPlayerInputBehaviorFsmStateAction {

        [RequiredField]
        [Tooltip("Set the value.")]
        public FsmFloat value;

        public override void Reset() {
            base.Reset();
            value = 0.0f;
        }

        protected override void DoUpdate() {
            if(Behavior == null) return;
            Behavior.digitalAxisSensitivity = value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Set the value of InputBehavior.digitalAxisSnap for a Player.")]
    public class RewiredPlayerInputBehaviorSetDigitalAxisSnap : RewiredPlayerInputBehaviorFsmStateAction {

        [RequiredField]
        [Tooltip("Set the value.")]
        public FsmBool value;

        public override void Reset() {
            base.Reset();
            value = false;
        }

        protected override void DoUpdate() {
            if(Behavior == null) return;
            Behavior.digitalAxisSnap = value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Set the value of InputBehavior.digitalAxisInstantReverse for a Player.")]
    public class RewiredPlayerInputBehaviorSetDigitalAxisInstantReverse : RewiredPlayerInputBehaviorFsmStateAction {

        [RequiredField]
        [Tooltip("Set the value.")]
        public FsmBool value;

        public override void Reset() {
            base.Reset();
            value = false;
        }

        protected override void DoUpdate() {
            if(Behavior == null) return;
            Behavior.digitalAxisInstantReverse = value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Set the value of InputBehavior.joystickAxisSensitivity for a Player.")]
    public class RewiredPlayerInputBehaviorSetJoystickAxisSensitivity : RewiredPlayerInputBehaviorFsmStateAction {

        [RequiredField]
        [Tooltip("Set the value.")]
        public FsmFloat value;

        public override void Reset() {
            base.Reset();
            value = 0.0f;
        }

        protected override void DoUpdate() {
            if(Behavior == null) return;
            Behavior.joystickAxisSensitivity = value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Set the value of InputBehavior.customControllerAxisSensitivity for a Player.")]
    public class RewiredPlayerInputBehaviorSetCustomControllerAxisSensitivity : RewiredPlayerInputBehaviorFsmStateAction {

        [RequiredField]
        [Tooltip("Set the value.")]
        public FsmFloat value;

        public override void Reset() {
            base.Reset();
            value = 0.0f;
        }

        protected override void DoUpdate() {
            if(Behavior == null) return;
            Behavior.customControllerAxisSensitivity = value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Set the value of InputBehavior.mouseXYAxisMode for a Player.")]
    public class RewiredPlayerInputBehaviorSetMouseXYAxisMode : RewiredPlayerInputBehaviorFsmStateAction {

        [RequiredField]
        [Tooltip("Store the result in an int variable.")]
        public FsmInt value;

        public override void Reset() {
            base.Reset();
            value = 0;
        }

        protected override void DoUpdate() {
            if(Behavior == null) return;
            Behavior.mouseXYAxisMode = (MouseXYAxisMode)value.Value;
        }
    }


    [ActionCategory("Rewired")]
    [Tooltip("Set the value of InputBehavior.mouseXYAxisSensitivity for a Player.")]
    public class RewiredPlayerInputBehaviorSetMouseXYAxisSensitivity : RewiredPlayerInputBehaviorFsmStateAction {

        [RequiredField]
        [Tooltip("Set the value.")]
        public FsmFloat value;

        public override void Reset() {
            base.Reset();
            value = 0.0f;
        }

        protected override void DoUpdate() {
            if(Behavior == null) return;
            Behavior.mouseXYAxisSensitivity = value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Set the value of InputBehavior.mouseXYAxisDeltaCalc for a Player.")]
    public class RewiredPlayerInputBehaviorSetMouseXYAxisDeltaCalc : RewiredPlayerInputBehaviorFsmStateAction {

        [RequiredField]
        [Tooltip("Store the result in an int variable.")]
        public FsmInt value;

        public override void Reset() {
            base.Reset();
            value = 0;
        }

        protected override void DoUpdate() {
            if(Behavior == null) return;
            Behavior.mouseXYAxisDeltaCalc = (MouseXYAxisDeltaCalc)value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Set the value of InputBehavior.mouseOtherAxisMode for a Player.")]
    public class RewiredPlayerInputBehaviorSetMouseOtherAxisMode : RewiredPlayerInputBehaviorFsmStateAction {

        [RequiredField]
        [Tooltip("Store the result in an int variable.")]
        public FsmInt value;

        public override void Reset() {
            base.Reset();
            value = 0;
        }

        protected override void DoUpdate() {
            if(Behavior == null) return;
            Behavior.mouseOtherAxisMode = (MouseOtherAxisMode)value.Value;
        }
    }


    [ActionCategory("Rewired")]
    [Tooltip("Set the value of InputBehavior.mouseOtherAxisSensitivity for a Player.")]
    public class RewiredPlayerInputBehaviorSetMouseOtherAxisSensitivity : RewiredPlayerInputBehaviorFsmStateAction {

        [RequiredField]
        [Tooltip("Set the value.")]
        public FsmFloat value;

        public override void Reset() {
            base.Reset();
            value = 0.0f;
        }

        protected override void DoUpdate() {
            if(Behavior == null) return;
            Behavior.mouseOtherAxisSensitivity = value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Set the value of InputBehavior.buttonDeadZone for a Player.")]
    public class RewiredPlayerInputBehaviorSetButtonDeadZone : RewiredPlayerInputBehaviorFsmStateAction {

        [RequiredField]
        [Tooltip("Set the value.")]
        public FsmFloat value;

        public override void Reset() {
            base.Reset();
            value = 0.0f;
        }

        protected override void DoUpdate() {
            if(Behavior == null) return;
            Behavior.buttonDeadZone = value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Set the value of InputBehavior.buttonDoublePressSpeed for a Player.")]
    public class RewiredPlayerInputBehaviorSetButtonDoublePressSpeed : RewiredPlayerInputBehaviorFsmStateAction {

        [RequiredField]
        [Tooltip("Set the value.")]
        public FsmFloat value;

        public override void Reset() {
            base.Reset();
            value = 0.0f;
        }

        protected override void DoUpdate() {
            if(Behavior == null) return;
            Behavior.buttonDoublePressSpeed = value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Set the value of InputBehavior.buttonShortPressTime for a Player.")]
    public class RewiredPlayerInputBehaviorSetButtonShortPressTime : RewiredPlayerInputBehaviorFsmStateAction {

        [RequiredField]
        [Tooltip("Set the value.")]
        public FsmFloat value;

        public override void Reset() {
            base.Reset();
            value = 0.0f;
        }

        protected override void DoUpdate() {
            if(Behavior == null) return;
            Behavior.buttonShortPressTime = value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Set the value of InputBehavior.buttonShortPressExpiresIn for a Player.")]
    public class RewiredPlayerInputBehaviorSetButtonShortPressExpiresIn : RewiredPlayerInputBehaviorFsmStateAction {

        [RequiredField]
        [Tooltip("Set the value.")]
        public FsmFloat value;

        public override void Reset() {
            base.Reset();
            value = 0.0f;
        }

        protected override void DoUpdate() {
            if(Behavior == null) return;
            Behavior.buttonShortPressExpiresIn = value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Set the value of InputBehavior.buttonLongPressTime for a Player.")]
    public class RewiredPlayerInputBehaviorSetButtonLongPressTime : RewiredPlayerInputBehaviorFsmStateAction {

        [RequiredField]
        [Tooltip("Set the value.")]
        public FsmFloat value;

        public override void Reset() {
            base.Reset();
            value = 0.0f;
        }

        protected override void DoUpdate() {
            if(Behavior == null) return;
            Behavior.buttonLongPressTime = value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Set the value of InputBehavior.buttonLongPressExpiresIn for a Player.")]
    public class RewiredPlayerInputBehaviorSetButtonLongPressExpiresIn : RewiredPlayerInputBehaviorFsmStateAction {

        [RequiredField]
        [Tooltip("Set the value.")]
        public FsmFloat value;

        public override void Reset() {
            base.Reset();
            value = 0.0f;
        }

        protected override void DoUpdate() {
            if(Behavior == null) return;
            Behavior.buttonLongPressExpiresIn = value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Set the value of InputBehavior.buttonDownBuffer for a Player.")]
    public class RewiredPlayerInputBehaviorSetButtonDownBuffer : RewiredPlayerInputBehaviorFsmStateAction {

        [RequiredField]
        [Tooltip("Set the value.")]
        public FsmFloat value;

        public override void Reset() {
            base.Reset();
            value = 0.0f;
        }

        protected override void DoUpdate() {
            if(Behavior == null) return;
            Behavior.buttonDownBuffer = value.Value;
        }
    }

    #endregion

    #region Layout Manager

    #region Layout Manager

    [ActionCategory("Rewired")]
    [Tooltip(
        "If enabled, loaded Controller Maps will be evaluated when Controllers are assigned, after saved data is loaded, etc. " +
        "Changes to Controller Maps will be applied immediately in the Player when enabled."
    )]
    public class RewiredPlayerLayoutManagerGetEnabled : RewiredPlayerLayoutManagerGetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            storeValue.Value = LayoutManager.enabled;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip(
        "If enabled, loaded Controller Maps will be evaluated when Controllers are assigned, after saved data is loaded, etc. " +
        "Changes to Controller Maps will be applied immediately in the Player when enabled."
    )]
    public class RewiredPlayerLayoutManagerSetEnabled : RewiredPlayerLayoutManagerSetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            LayoutManager.enabled = value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip(
        "If enabled, Controller Maps will be loaded from UserDataStore (if available) instead of from the Rewired Input Manager " +
        "defaults. If no matching Controller Map is found in UserDataStore, the Rewired Input Manager default will be loaded. " +
        "Note: The UserDataStore implementation must implement IControllerMapStore to be used."
    )]
    public class RewiredPlayerLayoutManagerGetLoadFromUserDataStore : RewiredPlayerLayoutManagerGetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            storeValue.Value = LayoutManager.loadFromUserDataStore;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip(
        "If enabled, Controller Maps will be loaded from UserDataStore (if available) instead of from the Rewired Input Manager " +
        "defaults. If no matching Controller Map is found in UserDataStore, the Rewired Input Manager default will be loaded. " +
        "Note: The UserDataStore implementation must implement IControllerMapStore to be used."
    )]
    public class RewiredPlayerLayoutManagerSetLoadFromUserDataStore : RewiredPlayerLayoutManagerSetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            LayoutManager.loadFromUserDataStore = value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip(
        "Applies settings to Controller Maps in the Player. " +
        "This must be called if you make changes to anything in Rule Sets in " +
        "order for those changes to be applied to the Player's Controller Maps."
    )]
    public class RewiredPlayerLayoutManagerApply : RewiredPlayerLayoutManagerFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            LayoutManager.Apply();
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Loads the default settings from the Rewired Input Manager.")]
    public class RewiredPlayerLayoutManagerLoadDefaults : RewiredPlayerLayoutManagerFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            LayoutManager.LoadDefaults();
        }
    }

    #endregion

    #region LayoutManager.RuleSet

    [ActionCategory("Rewired")]
    [Tooltip("If enabled, the rule set will be evaluated. Otherwise, it will be ignored.")]
    public class RewiredPlayerLayoutManagerRuleSetGetEnabled : RewiredPlayerLayoutManagerRuleSetGetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            storeValue.Value = RuleSet.enabled;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("If enabled, the rule set will be evaluated. Otherwise, it will be ignored.")]
    public class RewiredPlayerLayoutManagerRuleSetSetEnabled : RewiredPlayerLayoutManagerRuleSetSetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [Tooltip("If true, the change is applied to the Player's Controller Maps immediately. Otherwise, you must call Apply on the Layout Manager first.")]
        public FsmBool apply;

        public override void Reset() {
            base.Reset();
            apply = true;
        }

        protected override void DoUpdate() {
            var ruleSet = RuleSet;
            bool enabled = ruleSet.enabled;
            bool changed = value.Value != enabled;
            if (changed) {
                ruleSet.enabled = value.Value;
                if (apply.Value) {
                    LayoutManager.Apply();
                }
            }
        }
    }

    #endregion

    #endregion

    #region Map Enabler

    #region Map Enabler

    [ActionCategory("Rewired")]
    [Tooltip(
        "If enabled, Controller Maps enabled states will be sync'd when Controllers are assigned, new maps are loaded, etc. " +
        "Changes to Controller Maps will be applied immediately in the Player when enabled."
    )]
    public class RewiredPlayerMapEnablerGetEnabled : RewiredPlayerMapEnablerGetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            storeValue.Value = MapEnabler.enabled;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip(
        "If enabled, Controller Maps enabled states will be sync'd when Controllers are assigned, new maps are loaded, etc. " +
        "Changes to Controller Maps will be applied immediately in the Player when enabled."
    )]
    public class RewiredPlayerMapEnablerSetEnabled : RewiredPlayerMapEnablerSetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            MapEnabler.enabled = value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip(
        "Applies settings to Controller Maps in the Player. " +
        "This must be called if you make changes to anything in Rule Sets in " +
        "order for those changes to be applied to the Player's Controller Maps."
    )]
    public class RewiredPlayerMapEnablerApply : RewiredPlayerMapEnablerFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            MapEnabler.Apply();
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Loads the default settings from the Rewired Input Manager.")]
    public class RewiredPlayerMapEnablerLoadDefaults : RewiredPlayerMapEnablerFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            MapEnabler.LoadDefaults();
        }
    }

    #endregion

    #region MapEnabler.RuleSet

    [ActionCategory("Rewired")]
    [Tooltip("If enabled, the rule set will be evaluated. Otherwise, it will be ignored.")]
    public class RewiredPlayerMapEnablerRuleSetGetEnabled : RewiredPlayerMapEnablerRuleSetGetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            storeValue.Value = RuleSet.enabled;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("If enabled, the rule set will be evaluated. Otherwise, it will be ignored.")]
    public class RewiredPlayerMapEnablerRuleSetSetEnabled : RewiredPlayerMapEnablerRuleSetSetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [Tooltip("If true, the change is applied to the Player's Controller Maps immediately. Otherwise, you must call Apply on the Map Enabler first.")]
        public FsmBool apply;

        public override void Reset() {
            base.Reset();
            apply = true;
        }

        protected override void DoUpdate() {
            var ruleSet = RuleSet;
            bool enabled = ruleSet.enabled;
            bool changed = value.Value != enabled;
            if (changed) {
                ruleSet.enabled = value.Value;
                if (apply.Value) {
                    MapEnabler.Apply();
                }
            }
        }
    }

    #endregion

    #endregion

    #region Events

    [ActionCategory("Rewired")]
    [Tooltip("Event triggered when a controller is assigned to this Player.")]
    public class RewiredPlayerControllerAddedEvent : RewiredPlayerFsmStateAction {

        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in an int variable.")]
        public FsmInt storeControllerId = -1;

        [ObjectType(typeof(ControllerType))]
        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in an enum variable.")]
        public FsmEnum storeControllerType;

        [Tooltip("Send event when a controller is assigned to this Player")]
        public FsmEvent sendEvent;

        private bool hasEvent = false;

        public override void Awake() {
            base.Awake();
            if (Player != null) {
                Player.controllers.ControllerAddedEvent += OnControllerAdded;
            }
        }

        public override void Reset() {
            base.Reset();
            storeControllerId = -1;
            storeControllerType = null;
            hasEvent = false;
        }

        protected override void DoUpdate() {
            if (hasEvent) {
                if (!FsmEvent.IsNullOrEmpty(sendEvent)) Fsm.Event(sendEvent);
                hasEvent = false;
            }
        }

        private void OnControllerAdded(ControllerAssignmentChangedEventArgs args) {
            hasEvent = true;
            storeControllerId.Value = args.controller.id;
            storeControllerType.Value = args.controller.type;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Event triggered when a controller is removed from this Player.")]
    public class RewiredPlayerControllerRemovedEvent : RewiredPlayerFsmStateAction {

        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in an int variable.")]
        public FsmInt storeControllerId = -1;

        [ObjectType(typeof(ControllerType))]
        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in an enum variable.")]
        public FsmEnum storeControllerType;

        [Tooltip("Send event when a controller is removed from this Player")]
        public FsmEvent sendEvent;

        private bool hasEvent = false;

        public override void Awake() {
            base.Awake();
            if (Player != null) {
                Player.controllers.ControllerAddedEvent += OnControllerRemoved;
            }
        }

        public override void Reset() {
            base.Reset();
            storeControllerId = -1;
            storeControllerType = null;
            hasEvent = false;
        }

        protected override void DoUpdate() {
            if (hasEvent) {
                if (!FsmEvent.IsNullOrEmpty(sendEvent)) Fsm.Event(sendEvent);
                hasEvent = false;
            }
        }

        private void OnControllerRemoved(ControllerAssignmentChangedEventArgs args) {
            hasEvent = true;
            storeControllerId.Value = args.controller.id;
            storeControllerType.Value = args.controller.type;
        }
    }

    #endregion
}