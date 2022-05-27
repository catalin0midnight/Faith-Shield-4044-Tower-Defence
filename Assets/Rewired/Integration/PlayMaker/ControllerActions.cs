using UnityEngine;
using System.Collections.Generic;

namespace Rewired.Integration.PlayMaker {

    using HutongGames.PlayMaker;
    using HutongGames.PlayMaker.Actions;
    using HutongGames.Extensions;
    using HutongGames.Utility;
    using System;

    [ActionCategory("Rewired")]
    [Tooltip("Gets whether the controller is enabled. Disabled controllers return no input.")]
    public class RewiredControllerGetEnabled : RewiredControllerGetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            UpdateStoreValue(Controller.enabled);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Sets whether the controller is enabled. Disabled controllers return no input.")]
    public class RewiredControllerSetEnabled : RewiredControllerSetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            Controller.enabled = value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the Rewired unique id of this controller. This is not an index. The id is unique among controllers of a specific controller type.")]
    public class RewiredControllerGetId : RewiredControllerGetIntFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            UpdateStoreValue(Controller.id);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the name of the Controller. For Joysticks, this is drawn from the controller definition for recognized Joysticks. For unrecognized Joysticks, the name returned by the hardware is used instead.")]
    public class RewiredControllerGetName : RewiredControllerGetStringFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            UpdateStoreValue(Controller.name);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the tag assigned to the controller. Can be used for find a controller by tag.")]
    public class RewiredControllerGetTag : RewiredControllerGetStringFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            UpdateStoreValue(Controller.tag);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Sets the tag assigned to the controller. Can be used for find a controller by tag.")]
    public class RewiredControllerSetTag : RewiredControllerFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField]
        [Tooltip("The tag to set.")]
        public FsmString tag;

        public override void Reset() {
            base.Reset();
            tag = string.Empty;
        }

        protected override void DoUpdate() {
            Controller.tag = tag.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the name the controller hardware returns.")]
    public class RewiredControllerGetHardwareName : RewiredControllerGetStringFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            UpdateStoreValue(Controller.hardwareName);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the type of this controller.")]
    public class RewiredControllerGetType : RewiredControllerFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField, UIHint(UIHint.Variable), ObjectType(typeof(ControllerType))]
        [Tooltip("Store the result in an enum variable.")]
        public FsmEnum storeValue;

        public override void Reset() {
            base.Reset();
            storeValue = null;
        }

        protected override void DoUpdate() {
            UpdateStoreValue(Controller.type);
        }

        protected void UpdateStoreValue(ControllerType newValue) {
            if(!newValue.Equals(storeValue.Value)) { // value changed
                // Store new value
                storeValue.Value = newValue;
            }
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Is the controller connected?")]
    public class RewiredControllerGetIsConnected : RewiredControllerGetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            UpdateStoreValue(Controller.isConnected);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the button count in the controller.")]
    public class RewiredControllerGetButtonCount : RewiredControllerGetIntFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            UpdateStoreValue(Controller.buttonCount);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the string of information from the controller used for identifying unknown controller maps for saving/loading.")]
    public class RewiredControllerGetHardwareIdentifier : RewiredControllerGetStringFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            UpdateStoreValue(Controller.hardwareIdentifier);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the string representation of the controller map type. Can be used for saving/loading.")]
    public class RewiredControllerGetMapTypeString : RewiredControllerGetStringFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            UpdateStoreValue(Controller.mapTypeString);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the last timestamp any axis or button was active. NOTE: If comparing time against current time, always compare to ReInput.time.unscaledTime.")]
    public class RewiredControllerGetLastTimeActive : RewiredControllerGetFloatFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [Tooltip("Use raw axis values.")]
        public FsmBool useRawValues;

        public override void Reset() {
            base.Reset();
            useRawValues = false;
        }

        protected override void DoUpdate() {
            UpdateStoreValue((float)Controller.GetLastTimeActive(useRawValues.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the last timestamp any button was active. NOTE: If comparing time against current time, always compare to ReInput.time.unscaledTime.")]
    public class RewiredControllerGetLastTimeAnyButtonPressed : RewiredControllerGetFloatFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        public override void Reset() {
            base.Reset();
        }

        protected override void DoUpdate() {
            UpdateStoreValue((float)Controller.GetLastTimeAnyButtonPressed());
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the last timestamp any button's state changed. NOTE: If comparing time against current time, always compare to ReInput.time.unscaledTime.")]
    public class RewiredControllerGetLastTimeAnyButtonChanged : RewiredControllerGetFloatFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        public override void Reset() {
            base.Reset();
        }

        protected override void DoUpdate() {
            UpdateStoreValue((float)Controller.GetLastTimeAnyButtonChanged());
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the last timestamp any element changed state. NOTE: If comparing time against current time, always compare to ReInput.time.unscaledTime.")]
    public class RewiredControllerGetLastTimeAnyElementChanged : RewiredControllerGetFloatFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [Tooltip("Use raw axis values.")]
        public FsmBool useRawValues;

        public override void Reset() {
            base.Reset();
            useRawValues = false;
        }

        protected override void DoUpdate() {
            UpdateStoreValue((float)Controller.GetLastTimeAnyElementChanged(useRawValues.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the button held state of any hardware button. This will return TRUE as long as any button is held. This does not take into acount any controller mapping or Actions -- this is the unmapped physical button value only. Use the Player class to get button values mapped to Actions.")]
    public class RewiredControllerGetAnyButton : RewiredControllerGetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        protected override void DoUpdate() {
            UpdateStoreValue(Controller.GetAnyButton());
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the button just pressed state of any hardware button. This will only return TRUE only on the first frame the button is pressed This does not take into acount any controller mapping or Actions -- this is the unmapped physical button value only. Use the Player class to get button values mapped to Actions.")]
    public class RewiredControllerGetAnyButtonDown : RewiredControllerGetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        protected override void DoUpdate() {
            UpdateStoreValue(Controller.GetAnyButtonDown());
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the button just released state of any hardware button. This will only return TRUE only on the first frame the button is released This does not take into acount any controller mapping or Actions -- this is the unmapped physical button value only. Use the Player class to get button values mapped to Actions.")]
    public class RewiredControllerGetAnyButtonUp : RewiredControllerGetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        protected override void DoUpdate() {
            UpdateStoreValue(Controller.GetAnyButtonUp());
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the previous button held state of any hardware button. This will return TRUE if any button was held in the previous frame. This does not take into acount any controller mapping or Actions -- this is the unmapped physical button value only. Use the Player class to get button values mapped to Actions.")]
    public class RewiredControllerGetAnyButtonPrev : RewiredControllerGetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        protected override void DoUpdate() {
            UpdateStoreValue(Controller.GetAnyButtonPrev());
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Returns true if any button has changed state from the previous frame to the current. This does not take into acount any controller mapping or Actions -- this is the unmapped physical button value only. Use the Player class to get button values mapped to Actions.")]
    public class RewiredControllerGetAnyButtonChanged : RewiredControllerGetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        protected override void DoUpdate() {
            UpdateStoreValue(Controller.GetAnyButtonChanged());
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the button held state of the hardware button at the specified index. This will return TRUE as long as the button is held. This does not take into acount any controller mapping or Actions -- this is the unmapped physical button value only. Use the Player class to get button values mapped to Actions.")]
    public class RewiredControllerGetButton : RewiredControllerGetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        [RequiredField]
        [Tooltip("Button index.")]
        public FsmInt buttonIndex;

        public override void Reset() {
            base.Reset();
            buttonIndex = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue(Controller.GetButton(buttonIndex.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the button just pressed state of the hardware button at the specified index. This will only return TRUE only on the first frame the button is pressed This does not take into acount any controller mapping or Actions -- this is the unmapped physical button value only. Use the Player class to get button values mapped to Actions.")]
    public class RewiredControllerGetButtonDown : RewiredControllerGetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        [RequiredField]
        [Tooltip("Button index.")]
        public FsmInt buttonIndex;

        public override void Reset() {
            base.Reset();
            buttonIndex = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue(Controller.GetButtonDown(buttonIndex.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the button just released state of the hardware button at the specified index. This will only return TRUE only on the first frame the button is released This does not take into acount any controller mapping or Actions -- this is the unmapped physical button value only. Use the Player class to get button values mapped to Actions.")]
    public class RewiredControllerGetButtonUp : RewiredControllerGetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        [RequiredField]
        [Tooltip("Button index.")]
        public FsmInt buttonIndex;

        public override void Reset() {
            base.Reset();
            buttonIndex = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue(Controller.GetButtonUp(buttonIndex.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the previous button held state of the hardware button at the specified index. This will return TRUE if the button was held in the previous frame. This does not take into acount any controller mapping or Actions -- this is the unmapped physical button value only. Use the Player class to get button values mapped to Actions.")]
    public class RewiredControllerGetButtonPrev : RewiredControllerGetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        [RequiredField]
        [Tooltip("Button index.")]
        public FsmInt buttonIndex;

        public override void Reset() {
            base.Reset();
            buttonIndex = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue(Controller.GetButtonPrev(buttonIndex.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Returns true if the button has changed state from the previous frame to the current. This does not take into acount any controller mapping or Actions -- this is the unmapped physical button value only. Use the Player class to get button values mapped to Actions.")]
    public class RewiredControllerGetButtonChanged : RewiredControllerGetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        [RequiredField]
        [Tooltip("Button index.")]
        public FsmInt buttonIndex;

        public override void Reset() {
            base.Reset();
            buttonIndex = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue(Controller.GetButtonChanged(buttonIndex.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the button held state of the hardware button at the specified element identifier id. This will return TRUE as long as the button is held. This does not take into acount any controller mapping or Actions -- this is the unmapped physical button value only. Use the Player class to get button values mapped to Actions.")]
    public class RewiredControllerGetButtonById : RewiredControllerGetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        [RequiredField]
        [Tooltip("Element identifier id.")]
        public FsmInt elementIdentifierId;

        public override void Reset() {
            base.Reset();
            elementIdentifierId = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue(Controller.GetButtonById(elementIdentifierId.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the button just pressed state of the hardware button at the specified element identifier id. This will only return TRUE only on the first frame the button is pressed This does not take into acount any controller mapping or Actions -- this is the unmapped physical button value only. Use the Player class to get button values mapped to Actions.")]
    public class RewiredControllerGetButtonDownById : RewiredControllerGetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        [RequiredField]
        [Tooltip("Element identifier id.")]
        public FsmInt elementIdentifierId;

        public override void Reset() {
            base.Reset();
            elementIdentifierId = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue(Controller.GetButtonDownById(elementIdentifierId.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the button just released state of the hardware button at the specified element identifier id. This will only return TRUE only on the first frame the button is released This does not take into acount any controller mapping or Actions -- this is the unmapped physical button value only. Use the Player class to get button values mapped to Actions.")]
    public class RewiredControllerGetButtonUpById : RewiredControllerGetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        [RequiredField]
        [Tooltip("Element identifier id.")]
        public FsmInt elementIdentifierId;

        public override void Reset() {
            base.Reset();
            elementIdentifierId = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue(Controller.GetButtonUpById(elementIdentifierId.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the previous button held state of the hardware button at the specified index. This will return TRUE if the button was held in the previous frame. This does not take into acount any controller mapping or Actions -- this is the unmapped physical button value only. Use the Player class to get button values mapped to Actions.")]
    public class RewiredControllerGetButtonPrevById : RewiredControllerGetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        [RequiredField]
        [Tooltip("Element identifier id.")]
        public FsmInt elementIdentifierId;

        public override void Reset() {
            base.Reset();
            elementIdentifierId = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue(Controller.GetButtonPrevById(elementIdentifierId.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the double press and hold state of the button at the specified index. This will return TRUE after the double press is detected and for as long as the button is held thereafter.")]
    public class RewiredControllerGetButtonDoublePressHold : RewiredControllerGetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        [RequiredField]
        [Tooltip("Button index.")]
        public FsmInt buttonIndex;

        [Tooltip("The speed at which the button must be pressed twice in seconds in order to be considered a double press. If 0 or less, the default speed will be used.")]
        public FsmFloat speed;

        public override void Reset() {
            base.Reset();
            buttonIndex = 0;
            speed = 0;
        }

        protected override void DoUpdate() {
            bool value = speed.Value > 0f ? Controller.GetButtonDoublePressHold(buttonIndex.Value, speed.Value) : Controller.GetButtonDoublePressHold(buttonIndex.Value);
            UpdateStoreValue(value);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the double press down state of the button at the specified index. This will return TRUE only on the first frame the double press is detected.")]
    public class RewiredControllerGetButtonDoublePressDown : RewiredControllerGetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        [RequiredField]
        [Tooltip("Button index.")]
        public FsmInt buttonIndex;

        [Tooltip("The speed at which the button must be pressed twice in seconds in order to be considered a double press. If 0 or less, the default speed will be used.")]
        public FsmFloat speed;

        public override void Reset() {
            base.Reset();
            buttonIndex = 0;
            speed = 0;
        }

        protected override void DoUpdate() {
            bool value = speed.Value > 0f ? Controller.GetButtonDoublePressDown(buttonIndex.Value, speed.Value) : Controller.GetButtonDoublePressDown(buttonIndex.Value);
            UpdateStoreValue(value);
        }
    }
    
    [ActionCategory("Rewired")]
    [Tooltip("Gets the double press and hold state of the button at the specified element identifier id. This will return TRUE after the double press is detected and for as long as the button is held thereafter.")]
    public class RewiredControllerGetButtonDoublePressHoldById : RewiredControllerGetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        [RequiredField]
        [Tooltip("Element identifier id.")]
        public FsmInt elementIdentifierId;

        [Tooltip("The speed at which the button must be pressed twice in seconds in order to be considered a double press. If 0 or less, the default speed will be used.")]
        public FsmFloat speed;

        public override void Reset() {
            base.Reset();
            elementIdentifierId = 0;
            speed = 0;
        }

        protected override void DoUpdate() {
            bool value = speed.Value > 0f ? Controller.GetButtonDoublePressHoldById(elementIdentifierId.Value, speed.Value) : Controller.GetButtonDoublePressHoldById(elementIdentifierId.Value);
            UpdateStoreValue(value);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the double press down state of the button at the specified element identifier id. This will return TRUE only on the first frame the double press is detected. ")]
    public class RewiredControllerGetButtonDoublePressDownById : RewiredControllerGetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        [RequiredField]
        [Tooltip("Element identifier id.")]
        public FsmInt elementIdentifierId;

        [Tooltip("The speed at which the button must be pressed twice in seconds in order to be considered a double press. If 0 or less, the default speed will be used.")]
        public FsmFloat speed;

        public override void Reset() {
            base.Reset();
            elementIdentifierId = 0;
            speed = 0;
        }

        protected override void DoUpdate() {
            bool value = speed.Value > 0f ? Controller.GetButtonDoublePressDownById(elementIdentifierId.Value, speed.Value) : Controller.GetButtonDoublePressDownById(elementIdentifierId.Value);
            UpdateStoreValue(value);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the length of time the button at index has been active.")]
    public class RewiredControllerGetButtonTimePressed : RewiredControllerGetFloatFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        [RequiredField]
        [Tooltip("Button index.")]
        public FsmInt buttonIndex;

        public override void Reset() {
            base.Reset();
            buttonIndex = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue((float)Controller.GetButtonTimePressed(buttonIndex.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the length of time the button at index has been inactive.")]
    public class RewiredControllerGetButtonTimeUnpressed : RewiredControllerGetFloatFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        [RequiredField]
        [Tooltip("Button index.")]
        public FsmInt buttonIndex;

        public override void Reset() {
            base.Reset();
            buttonIndex = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue((float)Controller.GetButtonTimeUnpressed(buttonIndex.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the last timestamp the button at index was active.")]
    public class RewiredControllerGetButtonLastTimePressed : RewiredControllerGetFloatFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        [RequiredField]
        [Tooltip("Button index.")]
        public FsmInt buttonIndex;

        public override void Reset() {
            base.Reset();
            buttonIndex = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue((float)Controller.GetButtonLastTimePressed(buttonIndex.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the last timestamp the button at index was inactive.")]
    public class RewiredControllerGetButtonLastTimeUnpressed : RewiredControllerGetFloatFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        [RequiredField]
        [Tooltip("Button index.")]
        public FsmInt buttonIndex;

        public override void Reset() {
            base.Reset();
            buttonIndex = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue((float)Controller.GetButtonLastTimeUnpressed(buttonIndex.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the length of time the button with the element identifier id has been active.")]
    public class RewiredControllerGetButtonTimePressedById : RewiredControllerGetFloatFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        [RequiredField]
        [Tooltip("Element identifier id.")]
        public FsmInt elementIdentifierId;

        public override void Reset() {
            base.Reset();
            elementIdentifierId = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue((float)Controller.GetButtonTimePressedById(elementIdentifierId.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the length of time the button with the element identifier id has been inactive.")]
    public class RewiredControllerGetButtonTimeUnpressedById : RewiredControllerGetFloatFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        [RequiredField]
        [Tooltip("Element identifier id.")]
        public FsmInt elementIdentifierId;

        public override void Reset() {
            base.Reset();
            elementIdentifierId = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue((float)Controller.GetButtonTimeUnpressedById(elementIdentifierId.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the last timestamp the button with the element identifier id was active.")]
    public class RewiredControllerGetButtonLastTimePressedById : RewiredControllerGetFloatFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        [RequiredField]
        [Tooltip("Element identifier id.")]
        public FsmInt elementIdentifierId;

        public override void Reset() {
            base.Reset();
            elementIdentifierId = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue((float)Controller.GetButtonLastTimePressedById(elementIdentifierId.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the last timestamp the button with the element identifier id was inactive.")]
    public class RewiredControllerGetButtonLastTimeUnpressedById : RewiredControllerGetFloatFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        [RequiredField]
        [Tooltip("Element identifier id.")]
        public FsmInt elementIdentifierId;

        public override void Reset() {
            base.Reset();
            elementIdentifierId = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue((float)Controller.GetButtonLastTimeUnpressedById(elementIdentifierId.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the index of the Button with the specified element idenfitier id.")]
    public class RewiredControllerGetButtonIndexById : RewiredControllerGetIntFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        [RequiredField]
        [Tooltip("Element identifier id.")]
        public FsmInt elementIdentifierId;

        public override void Reset() {
            base.Reset();
            elementIdentifierId = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue(Controller.GetButtonIndexById(elementIdentifierId.Value));
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Determines if the Controller implements a Controller Template.")]
    public class RewiredControllerImpelementsTemplate : RewiredControllerGetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        [Tooltip("Controller template type.")]
        [ObjectType(typeof(Rewired.Integration.PlayMaker.ControllerTemplateType))]
        public FsmEnum templateType;

        [Tooltip("Finds the template by Guid. If enabled, the Guid is used to find the Controller Template and the Template Type field is ignored. Use this if using a custom Controller Template.")]
        public FsmBool findTemplateByGuid;

        [Tooltip("The Controller Template Guid. This is used to find the Controller Template if Find Template by Guid is enabled.")]
        public FsmString templateGuid;

        public override void Reset() {
            base.Reset();
            templateType = Rewired.Integration.PlayMaker.ControllerTemplateType.Gamepad;
            findTemplateByGuid = false;
            templateGuid = string.Empty;
        }

        protected override void DoUpdate() {
            if (findTemplateByGuid.Value) {
                try {
                    UpdateStoreValue(Controller.ImplementsTemplate(new Guid(templateGuid.Value)));
                } catch {
                    Debug.LogError("Invalid Guid string format.");
                }
            } else {
                UpdateStoreValue(Controller.ImplementsTemplate(Rewired.Integration.PlayMaker.Tools.GetControllerTemplateTypeGuid((Rewired.Integration.PlayMaker.ControllerTemplateType)templateType.Value)));
            }
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the Rewired GUID associated with this device.")]
    public class RewiredControllerGetHardwareTypeGuidString : RewiredControllerGetStringFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            UpdateStoreValue(Controller.hardwareTypeGuid.ToString());
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip(
        "The unique persistent instance GUID of this device. " +
        "This is an id generated for the device that may stay constant between application sessions and system restarts. " +
        "This can be used for device assignment persistence between runs. The specific platform and input sources in use " +
        "affects the reliability of this value for device assignment persistence. " +
        "A value of Guid.Empty means the device or input source has no reliable unique identifier so persistant assignment " +
        "isn't possible using this value. Even if a Guid is provided, reliability when multiple identical controllers are " +
        "attached depends greatly on the platform and input source(s) currently in use."
    )]
    public class RewiredControllerGetDeviceInstanceGuidString : RewiredControllerGetStringFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            UpdateStoreValue(Controller.deviceInstanceGuid.ToString());
        }
    }

    // ControllerWithAxes

    [ActionCategory("Rewired")]
    [Tooltip("Gets the axis count in the controller.")]
    public class RewiredControllerGetAxisCount : RewiredControllerGetIntFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            UpdateStoreValue((Controller as ControllerWithAxes).axis2DCount);
        }

        protected override bool ValidateVars() {
            if(!base.ValidateVars()) return false;
            if(Controller as ControllerWithAxes == null) {
                LogError("Controller is an incompatible type.");
                return false;
            }
            return true;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the Axis2D count in the controller.")]
    public class RewiredControllerGetAxis2DCount : RewiredControllerGetIntFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            UpdateStoreValue((Controller as ControllerWithAxes).axis2DCount);
        }

        protected override bool ValidateVars() {
            if(!base.ValidateVars()) return false;
            if(Controller as ControllerWithAxes == null) {
                LogError("Controller is an incompatible type.");
                return false;
            }
            return true;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the last timestamp any axis was active. NOTE: If comparing time against current time, always compare to ReInput.time.unscaledTime.")]
    public class RewiredControllerGetLastTimeAnyAxisActive : RewiredControllerGetFloatFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [Tooltip("Use raw axis values.")]
        public FsmBool useRawValues;

        public override void Reset() {
            base.Reset();
            useRawValues = false;
        }

        protected override void DoUpdate() {
            UpdateStoreValue((float)(Controller as ControllerWithAxes).GetLastTimeAnyAxisActive(useRawValues.Value));
        }

        protected override bool ValidateVars() {
            if(!base.ValidateVars()) return false;
            if(Controller as ControllerWithAxes == null) {
                LogError("Controller is an incompatible type.");
                return false;
            }
            return true;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the last timestamp any axis changed state. NOTE: If comparing time against current time, always compare to ReInput.time.unscaledTime.")]
    public class RewiredControllerGetLastTimeAnyAxisChanged : RewiredControllerGetFloatFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [Tooltip("Use raw axis values.")]
        public FsmBool useRawValues;

        public override void Reset() {
            base.Reset();
            useRawValues = false;
        }

        protected override void DoUpdate() {
            UpdateStoreValue((float)(Controller as ControllerWithAxes).GetLastTimeAnyAxisChanged(useRawValues.Value));
        }

        protected override bool ValidateVars() {
            if(!base.ValidateVars()) return false;
            if(Controller as ControllerWithAxes == null) {
                LogError("Controller is an incompatible type.");
                return false;
            }
            return true;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the current axis value.")]
    public class RewiredControllerGetAxis : RewiredControllerGetFloatFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        [RequiredField]
        [Tooltip("Axis index.")]
        public FsmInt axisIndex;

        public override void Reset() {
            base.Reset();
            axisIndex = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue((Controller as ControllerWithAxes).GetAxis(axisIndex.Value));
        }

        protected override bool ValidateVars() {
            if(!base.ValidateVars()) return false;
            if(Controller as ControllerWithAxes == null) {
                LogError("Controller is an incompatible type.");
                return false;
            }
            return true;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the axis value from the previous frame.")]
    public class RewiredControllerGetAxisPrev : RewiredControllerGetFloatFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        [RequiredField]
        [Tooltip("Axis index.")]
        public FsmInt axisIndex;

        public override void Reset() {
            base.Reset();
            axisIndex = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue((Controller as ControllerWithAxes).GetAxisPrev(axisIndex.Value));
        }

        protected override bool ValidateVars() {
            if(!base.ValidateVars()) return false;
            if(Controller as ControllerWithAxes == null) {
                LogError("Controller is an incompatible type.");
                return false;
            }
            return true;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the current raw axis value. Excludes calibration.")]
    public class RewiredControllerGetAxisRaw : RewiredControllerGetFloatFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        [RequiredField]
        [Tooltip("Axis index.")]
        public FsmInt axisIndex;

        public override void Reset() {
            base.Reset();
            axisIndex = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue((Controller as ControllerWithAxes).GetAxisRaw(axisIndex.Value));
        }

        protected override bool ValidateVars() {
            if(!base.ValidateVars()) return false;
            if(Controller as ControllerWithAxes == null) {
                LogError("Controller is an incompatible type.");
                return false;
            }
            return true;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the raw axis value from the previous frame. Excludes calibration.")]
    public class RewiredControllerGetAxisRawPrev : RewiredControllerGetFloatFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        [RequiredField]
        [Tooltip("Axis index.")]
        public FsmInt axisIndex;

        public override void Reset() {
            base.Reset();
            axisIndex = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue((Controller as ControllerWithAxes).GetAxisRawPrev(axisIndex.Value));
        }

        protected override bool ValidateVars() {
            if(!base.ValidateVars()) return false;
            if(Controller as ControllerWithAxes == null) {
                LogError("Controller is an incompatible type.");
                return false;
            }
            return true;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the current axis value.")]
    public class RewiredControllerGetAxisById : RewiredControllerGetFloatFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        [RequiredField]
        [Tooltip("Element identifier id.")]
        public FsmInt elementIdentifierId;

        public override void Reset() {
            base.Reset();
            elementIdentifierId = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue((Controller as ControllerWithAxes).GetAxisById(elementIdentifierId.Value));
        }

        protected override bool ValidateVars() {
            if(!base.ValidateVars()) return false;
            if(Controller as ControllerWithAxes == null) {
                LogError("Controller is an incompatible type.");
                return false;
            }
            return true;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the axis value from the previous frame.")]
    public class RewiredControllerGetAxisPrevById : RewiredControllerGetFloatFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        [RequiredField]
        [Tooltip("Element identifier id.")]
        public FsmInt elementIdentifierId;

        public override void Reset() {
            base.Reset();
            elementIdentifierId = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue((Controller as ControllerWithAxes).GetAxisPrevById(elementIdentifierId.Value));
        }

        protected override bool ValidateVars() {
            if(!base.ValidateVars()) return false;
            if(Controller as ControllerWithAxes == null) {
                LogError("Controller is an incompatible type.");
                return false;
            }
            return true;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the current raw axis value. Excludes calibration.")]
    public class RewiredControllerGetAxisRawById : RewiredControllerGetFloatFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        [RequiredField]
        [Tooltip("Element identifier id.")]
        public FsmInt elementIdentifierId;

        public override void Reset() {
            base.Reset();
            elementIdentifierId = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue((Controller as ControllerWithAxes).GetAxisRawById(elementIdentifierId.Value));
        }

        protected override bool ValidateVars() {
            if(!base.ValidateVars()) return false;
            if(Controller as ControllerWithAxes == null) {
                LogError("Controller is an incompatible type.");
                return false;
            }
            return true;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the raw axis value from the previous frame. Excludes calibration.")]
    public class RewiredControllerGetAxisRawPrevById : RewiredControllerGetFloatFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        [RequiredField]
        [Tooltip("Element identifier id.")]
        public FsmInt elementIdentifierId;

        public override void Reset() {
            base.Reset();
            elementIdentifierId = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue((Controller as ControllerWithAxes).GetAxisRawPrevById(elementIdentifierId.Value));
        }

        protected override bool ValidateVars() {
            if(!base.ValidateVars()) return false;
            if(Controller as ControllerWithAxes == null) {
                LogError("Controller is an incompatible type.");
                return false;
            }
            return true;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the current 2D axis value.")]
    public class RewiredControllerGetAxis2D : RewiredControllerGetVector2FsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        [RequiredField]
        [Tooltip("Axis2D index.")]
        public FsmInt axis2DIndex;

        public override void Reset() {
            base.Reset();
            axis2DIndex = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue((Controller as ControllerWithAxes).GetAxis2D(axis2DIndex.Value));
        }

        protected override bool ValidateVars() {
            if(!base.ValidateVars()) return false;
            if(Controller as ControllerWithAxes == null) {
                LogError("Controller is an incompatible type.");
                return false;
            }
            return true;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the 2D axis value from the previous frame.")]
    public class RewiredControllerGetAxis2DPrev : RewiredControllerGetVector2FsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        [RequiredField]
        [Tooltip("Axis2D index.")]
        public FsmInt axis2DIndex;

        public override void Reset() {
            base.Reset();
            axis2DIndex = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue((Controller as ControllerWithAxes).GetAxis2DPrev(axis2DIndex.Value));
        }

        protected override bool ValidateVars() {
            if(!base.ValidateVars()) return false;
            if(Controller as ControllerWithAxes == null) {
                LogError("Controller is an incompatible type.");
                return false;
            }
            return true;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the current raw 2D axis value. Excludes calibration.")]
    public class RewiredControllerGetAxis2DRaw : RewiredControllerGetVector2FsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        [RequiredField]
        [Tooltip("Axis2D index.")]
        public FsmInt axis2DIndex;

        public override void Reset() {
            base.Reset();
            axis2DIndex = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue((Controller as ControllerWithAxes).GetAxis2DRaw(axis2DIndex.Value));
        }

        protected override bool ValidateVars() {
            if(!base.ValidateVars()) return false;
            if(Controller as ControllerWithAxes == null) {
                LogError("Controller is an incompatible type.");
                return false;
            }
            return true;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the raw 2D axis value from the previous frame. Excludes calibration.")]
    public class RewiredControllerGetAxis2DRawPrev : RewiredControllerGetVector2FsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        [RequiredField]
        [Tooltip("Axis2D index.")]
        public FsmInt axis2DIndex;

        public override void Reset() {
            base.Reset();
            axis2DIndex = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue((Controller as ControllerWithAxes).GetAxis2DRawPrev(axis2DIndex.Value));
        }

        protected override bool ValidateVars() {
            if(!base.ValidateVars()) return false;
            if(Controller as ControllerWithAxes == null) {
                LogError("Controller is an incompatible type.");
                return false;
            }
            return true;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("")]
    public class RewiredControllerGetAxisLastTimeActive : RewiredControllerGetFloatFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField]
        [Tooltip("Axis index.")]
        public FsmInt axisIndex;

        public override void Reset() {
            base.Reset();
            axisIndex = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue((float)(Controller as ControllerWithAxes).GetAxisLastTimeActive(axisIndex.Value));
        }

        protected override bool ValidateVars() {
            if(!base.ValidateVars()) return false;
            if(Controller as ControllerWithAxes == null) {
                LogError("Controller is an incompatible type.");
                return false;
            }
            return true;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("")]
    public class RewiredControllerGetAxisLastTimeInactive : RewiredControllerGetFloatFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField]
        [Tooltip("Axis index.")]
        public FsmInt axisIndex;

        public override void Reset() {
            base.Reset();
            axisIndex = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue((float)(Controller as ControllerWithAxes).GetAxisLastTimeInactive(axisIndex.Value));
        }

        protected override bool ValidateVars() {
            if(!base.ValidateVars()) return false;
            if(Controller as ControllerWithAxes == null) {
                LogError("Controller is an incompatible type.");
                return false;
            }
            return true;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("")]
    public class RewiredControllerGetAxisRawLastTimeActive : RewiredControllerGetFloatFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField]
        [Tooltip("Axis index.")]
        public FsmInt axisIndex;

        public override void Reset() {
            base.Reset();
            axisIndex = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue((float)(Controller as ControllerWithAxes).GetAxisRawLastTimeActive(axisIndex.Value));
        }

        protected override bool ValidateVars() {
            if(!base.ValidateVars()) return false;
            if(Controller as ControllerWithAxes == null) {
                LogError("Controller is an incompatible type.");
                return false;
            }
            return true;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("")]
    public class RewiredControllerGetAxisRawLastTimeInactive : RewiredControllerGetFloatFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField]
        [Tooltip("Axis index.")]
        public FsmInt axisIndex;

        public override void Reset() {
            base.Reset();
            axisIndex = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue((float)(Controller as ControllerWithAxes).GetAxisRawLastTimeInactive(axisIndex.Value));
        }

        protected override bool ValidateVars() {
            if(!base.ValidateVars()) return false;
            if(Controller as ControllerWithAxes == null) {
                LogError("Controller is an incompatible type.");
                return false;
            }
            return true;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("")]
    public class RewiredControllerGetAxisTimeActive : RewiredControllerGetFloatFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField]
        [Tooltip("Axis index.")]
        public FsmInt axisIndex;

        public override void Reset() {
            base.Reset();
            axisIndex = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue((float)(Controller as ControllerWithAxes).GetAxisTimeActive(axisIndex.Value));
        }

        protected override bool ValidateVars() {
            if(!base.ValidateVars()) return false;
            if(Controller as ControllerWithAxes == null) {
                LogError("Controller is an incompatible type.");
                return false;
            }
            return true;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("")]
    public class RewiredControllerGetAxisTimeInactive : RewiredControllerGetFloatFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField]
        [Tooltip("Axis index.")]
        public FsmInt axisIndex;

        public override void Reset() {
            base.Reset();
            axisIndex = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue((float)(Controller as ControllerWithAxes).GetAxisTimeInactive(axisIndex.Value));
        }

        protected override bool ValidateVars() {
            if(!base.ValidateVars()) return false;
            if(Controller as ControllerWithAxes == null) {
                LogError("Controller is an incompatible type.");
                return false;
            }
            return true;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("")]
    public class RewiredControllerGetAxisRawTimeActive : RewiredControllerGetFloatFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField]
        [Tooltip("Axis index.")]
        public FsmInt axisIndex;

        public override void Reset() {
            base.Reset();
            axisIndex = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue((float)(Controller as ControllerWithAxes).GetAxisRawTimeActive(axisIndex.Value));
        }

        protected override bool ValidateVars() {
            if(!base.ValidateVars()) return false;
            if(Controller as ControllerWithAxes == null) {
                LogError("Controller is an incompatible type.");
                return false;
            }
            return true;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("")]
    public class RewiredControllerGetAxisRawTimeInactive : RewiredControllerGetFloatFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField]
        [Tooltip("Axis index.")]
        public FsmInt axisIndex;

        public override void Reset() {
            base.Reset();
            axisIndex = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue((float)(Controller as ControllerWithAxes).GetAxisRawTimeInactive(axisIndex.Value));
        }

        protected override bool ValidateVars() {
            if(!base.ValidateVars()) return false;
            if(Controller as ControllerWithAxes == null) {
                LogError("Controller is an incompatible type.");
                return false;
            }
            return true;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("")]
    public class RewiredControllerGetAxisLastTimeActiveById : RewiredControllerGetFloatFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField]
        [Tooltip("Element identifier id.")]
        public FsmInt elementIdentifierId;

        public override void Reset() {
            base.Reset();
            elementIdentifierId = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue((float)(Controller as ControllerWithAxes).GetAxisLastTimeActiveById(elementIdentifierId.Value));
        }

        protected override bool ValidateVars() {
            if(!base.ValidateVars()) return false;
            if(Controller as ControllerWithAxes == null) {
                LogError("Controller is an incompatible type.");
                return false;
            }
            return true;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("")]
    public class RewiredControllerGetAxisLastTimeInactiveById : RewiredControllerGetFloatFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField]
        [Tooltip("Element identifier id.")]
        public FsmInt elementIdentifierId;

        public override void Reset() {
            base.Reset();
            elementIdentifierId = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue((float)(Controller as ControllerWithAxes).GetAxisLastTimeInactiveById(elementIdentifierId.Value));
        }

        protected override bool ValidateVars() {
            if(!base.ValidateVars()) return false;
            if(Controller as ControllerWithAxes == null) {
                LogError("Controller is an incompatible type.");
                return false;
            }
            return true;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("")]
    public class RewiredControllerGetAxisRawLastTimeActiveById : RewiredControllerGetFloatFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField]
        [Tooltip("Element identifier id.")]
        public FsmInt elementIdentifierId;

        public override void Reset() {
            base.Reset();
            elementIdentifierId = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue((float)(Controller as ControllerWithAxes).GetAxisRawLastTimeActiveById(elementIdentifierId.Value));
        }

        protected override bool ValidateVars() {
            if(!base.ValidateVars()) return false;
            if(Controller as ControllerWithAxes == null) {
                LogError("Controller is an incompatible type.");
                return false;
            }
            return true;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("")]
    public class RewiredControllerGetAxisRawLastTimeInactiveById : RewiredControllerGetFloatFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField]
        [Tooltip("Element identifier id.")]
        public FsmInt elementIdentifierId;

        public override void Reset() {
            base.Reset();
            elementIdentifierId = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue((float)(Controller as ControllerWithAxes).GetAxisRawLastTimeInactiveById(elementIdentifierId.Value));
        }

        protected override bool ValidateVars() {
            if(!base.ValidateVars()) return false;
            if(Controller as ControllerWithAxes == null) {
                LogError("Controller is an incompatible type.");
                return false;
            }
            return true;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("")]
    public class RewiredControllerGetAxisTimeActiveById : RewiredControllerGetFloatFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField]
        [Tooltip("Element identifier id.")]
        public FsmInt elementIdentifierId;

        public override void Reset() {
            base.Reset();
            elementIdentifierId = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue((float)(Controller as ControllerWithAxes).GetAxisTimeActiveById(elementIdentifierId.Value));
        }

        protected override bool ValidateVars() {
            if(!base.ValidateVars()) return false;
            if(Controller as ControllerWithAxes == null) {
                LogError("Controller is an incompatible type.");
                return false;
            }
            return true;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("")]
    public class RewiredControllerGetAxisTimeInactiveById : RewiredControllerGetFloatFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField]
        [Tooltip("Element identifier id.")]
        public FsmInt elementIdentifierId;

        public override void Reset() {
            base.Reset();
            elementIdentifierId = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue((float)(Controller as ControllerWithAxes).GetAxisTimeInactiveById(elementIdentifierId.Value));
        }

        protected override bool ValidateVars() {
            if(!base.ValidateVars()) return false;
            if(Controller as ControllerWithAxes == null) {
                LogError("Controller is an incompatible type.");
                return false;
            }
            return true;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("")]
    public class RewiredControllerGetAxisRawTimeActiveById : RewiredControllerGetFloatFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField]
        [Tooltip("Element identifier id.")]
        public FsmInt elementIdentifierId;

        public override void Reset() {
            base.Reset();
            elementIdentifierId = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue((float)(Controller as ControllerWithAxes).GetAxisRawTimeActiveById(elementIdentifierId.Value));
        }

        protected override bool ValidateVars() {
            if(!base.ValidateVars()) return false;
            if(Controller as ControllerWithAxes == null) {
                LogError("Controller is an incompatible type.");
                return false;
            }
            return true;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("")]
    public class RewiredControllerGetAxisRawTimeInactiveById : RewiredControllerGetFloatFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField]
        [Tooltip("Element identifier id.")]
        public FsmInt elementIdentifierId;

        public override void Reset() {
            base.Reset();
            elementIdentifierId = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue((float)(Controller as ControllerWithAxes).GetAxisRawTimeInactiveById(elementIdentifierId.Value));
        }

        protected override bool ValidateVars() {
            if(!base.ValidateVars()) return false;
            if(Controller as ControllerWithAxes == null) {
                LogError("Controller is an incompatible type.");
                return false;
            }
            return true;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the index of the Axis with the specified element idenfitier id.")]
    public class RewiredControllerGetAxisIndexById : RewiredControllerGetIntFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return true; } }

        [RequiredField]
        [Tooltip("Element identifier id.")]
        public FsmInt elementIdentifierId;

        public override void Reset() {
            base.Reset();
            elementIdentifierId = 0;
        }

        protected override void DoUpdate() {
            UpdateStoreValue((Controller as ControllerWithAxes).GetAxisIndexById(elementIdentifierId.Value));
        }

        protected override bool ValidateVars() {
            if(!base.ValidateVars()) return false;
            if(Controller as ControllerWithAxes == null) {
                LogError("Controller is an incompatible type.");
                return false;
            }
            return true;
        }
    }

    // Joystick

    // systemId is not supported because ?long is not a supported type in PlayMaker

    [ActionCategory("Rewired")]
    [Tooltip("Gets the unity joystick id of this joystick. This value is only used on platforms that use Unity input as the underlying input source. This value is a 1-based index corresponding to the joystick number in the Unity input manager. Generally, you should never need to use this, but it is exposed for advanced uses. Returns 0 if the platform does not use Unity input or if the joystick is not associated with a Unity joystick.")]
    public class RewiredJoystickGetUnityId : RewiredJoystickGetIntFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            UpdateStoreValue(Joystick.unityId);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the Rewired GUID associated with this device. A GUID of all zeros is an Unknown Controller.")]
    public class RewiredJoystickGetHardwareTypeGuidString : RewiredJoystickGetStringFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            UpdateStoreValue(Joystick.hardwareTypeGuid.ToString());
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Does this controller support vibration?")]
    public class RewiredJoystickGetSupportsVibration : RewiredJoystickGetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            UpdateStoreValue(Joystick.supportsVibration);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the number of vibration motors this device supports.")]
    public class RewiredJoystickGetVibrationMotorCount : RewiredJoystickGetIntFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            UpdateStoreValue(Joystick.vibrationMotorCount);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Sets vibration level for a motor at a specified index in a Joystick.")]
    public class RewiredJoystickSetVibration : RewiredJoystickFsmStateAction {

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
            if (!HasJoystick) return;
            if (motorIndex.Value < 0) return;
            motorLevel.Value = Mathf.Clamp01(motorLevel.Value);

            if (!Joystick.supportsVibration) return;
            if (motorIndex.Value >= Joystick.vibrationMotorCount) return;
            Joystick.SetVibration(motorIndex.Value, motorLevel.Value, duration.Value, stopOtherMotors.Value);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Stops all vibration motors in the Joystick.")]
    public class RewiredPlayerStopJoystickVibration : RewiredJoystickFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            if (!HasJoystick) return;
            if (!Joystick.supportsVibration) return;
            Joystick.StopVibration();
        }
    }
}