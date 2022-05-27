using UnityEngine;
using System.Collections.Generic;

namespace Rewired.Integration.PlayMaker {

    using HutongGames.PlayMaker;
    using HutongGames.PlayMaker.Actions;
    using HutongGames.Extensions;
    using HutongGames.Utility;

    #region Get

    [ActionCategory("Rewired")]
    [Tooltip("Gets whether the Action Element Map is enabled. Disabled maps will never return input.")]
    public class RewiredActionElementMapGetEnabled : RewiredActionElementMapGetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            UpdateStoreValue(aem.enabled);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the id of the Action to which the element is bound.")]
    public class RewiredActionElementMapGetActionId : RewiredActionElementMapGetIntFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            UpdateStoreValue(aem.actionId);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the element type of the controller element bound to the Action.")]
    public class RewiredActionElementMapGetElementType : RewiredActionElementMapFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField, UIHint(UIHint.Variable), ObjectType(typeof(ControllerElementType))]
        [Tooltip("Store the result in an enum variable.")]
        public FsmEnum storeValue;

        public override void Reset() {
            base.Reset();
            storeValue = null;
        }

        protected override void DoUpdate() {
            UpdateStoreValue(aem.elementType);
        }

        protected void UpdateStoreValue(ControllerElementType newValue) {
            if (!newValue.Equals(storeValue.Value)) { // value changed
                // Store new value
                storeValue.Value = newValue;
            }
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the controller element identifier id bound to the Action.")]
    public class RewiredActionElementMapGetElementIdentifierId : RewiredActionElementMapGetIntFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            UpdateStoreValue(aem.elementIdentifierId);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the range of the axis.")]
    public class RewiredActionElementMapGetAxisRange : RewiredActionElementMapFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField, UIHint(UIHint.Variable), ObjectType(typeof(AxisRange))]
        [Tooltip("Store the result in an enum variable.")]
        public FsmEnum storeValue;

        public override void Reset() {
            base.Reset();
            storeValue = null;
        }

        protected override void DoUpdate() {
            UpdateStoreValue(aem.axisRange);
        }

        protected void UpdateStoreValue(AxisRange newValue) {
            if (!newValue.Equals(storeValue.Value)) { // value changed
                // Store new value
                storeValue.Value = newValue;
            }
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets whether the axis inverted.")]
    public class RewiredActionElementMapGetInvert : RewiredActionElementMapGetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            UpdateStoreValue(aem.invert);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the axis contribution of the axis.")]
    public class RewiredActionElementMapGetAxisContribution : RewiredActionElementMapFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField, UIHint(UIHint.Variable), ObjectType(typeof(Pole))]
        [Tooltip("Store the result in an enum variable.")]
        public FsmEnum storeValue;

        public override void Reset() {
            base.Reset();
            storeValue = null;
        }

        protected override void DoUpdate() {
            UpdateStoreValue(aem.axisContribution);
        }

        protected void UpdateStoreValue(Pole newValue) {
            if (!newValue.Equals(storeValue.Value)) { // value changed
                // Store new value
                storeValue.Value = newValue;
            }
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the keyboard key code. Only used for keyboard bindings. Returns Rewired.KeyboardKeyCode value.")]
    public class RewiredActionElementMapGetKeyboardKeyCode : RewiredActionElementMapFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField, UIHint(UIHint.Variable), ObjectType(typeof(KeyboardKeyCode))]
        [Tooltip("Store the result in an enum variable.")]
        public FsmEnum storeValue;

        public override void Reset() {
            base.Reset();
            storeValue = null;
        }

        protected override void DoUpdate() {
            UpdateStoreValue(aem.keyboardKeyCode);
        }

        protected void UpdateStoreValue(KeyboardKeyCode newValue) {
            if (newValue != (KeyboardKeyCode)storeValue.Value) { // value changed
                // Store new value
                storeValue.Value = newValue;
            }
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the first keyboard modifier key.")]
    public class RewiredActionElementMapGetModifierKey1 : RewiredActionElementMapFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField, UIHint(UIHint.Variable), ObjectType(typeof(ModifierKey))]
        [Tooltip("Store the result in an enum variable.")]
        public FsmEnum storeValue;

        public override void Reset() {
            base.Reset();
            storeValue = null;
        }

        protected override void DoUpdate() {
            UpdateStoreValue(aem.modifierKey3);
        }

        protected void UpdateStoreValue(ModifierKey newValue) {
            if (!newValue.Equals(storeValue.Value)) { // value changed
                // Store new value
                storeValue.Value = newValue;
            }
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the second keyboard modifier key.")]
    public class RewiredActionElementMapGetModifierKey2 : RewiredActionElementMapFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField, UIHint(UIHint.Variable), ObjectType(typeof(ModifierKey))]
        [Tooltip("Store the result in an enum variable.")]
        public FsmEnum storeValue;

        public override void Reset() {
            base.Reset();
            storeValue = null;
        }

        protected override void DoUpdate() {
            UpdateStoreValue(aem.modifierKey2);
        }

        protected void UpdateStoreValue(ModifierKey newValue) {
            if (!newValue.Equals(storeValue.Value)) { // value changed
                // Store new value
                storeValue.Value = newValue;
            }
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the third keyboard modifier key.")]
    public class RewiredActionElementMapGetModifierKey3 : RewiredActionElementMapFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField, UIHint(UIHint.Variable), ObjectType(typeof(ModifierKey))]
        [Tooltip("Store the result in an enum variable.")]
        public FsmEnum storeValue;

        public override void Reset() {
            base.Reset();
            storeValue = null;
        }

        protected override void DoUpdate() {
            UpdateStoreValue(aem.modifierKey3);
        }

        protected void UpdateStoreValue(ModifierKey newValue) {
            if (!newValue.Equals(storeValue.Value)) { // value changed
                // Store new value
                storeValue.Value = newValue;
            }
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the axis type.")]
    public class RewiredActionElementMapGetAxisType : RewiredActionElementMapFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField, UIHint(UIHint.Variable), ObjectType(typeof(AxisType))]
        [Tooltip("Store the result in an enum variable.")]
        public FsmEnum storeValue;

        public override void Reset() {
            base.Reset();
            storeValue = null;
        }

        protected override void DoUpdate() {
            UpdateStoreValue(aem.axisType);
        }

        protected void UpdateStoreValue(AxisType newValue) {
            if (!newValue.Equals(storeValue.Value)) { // value changed
                // Store new value
                storeValue.Value = newValue;
            }
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets flags representing all the assigned keyboard modifier keys.")]
    public class RewiredActionElementMapGetModifierKeyFlags : RewiredActionElementMapFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField, UIHint(UIHint.Variable), ObjectType(typeof(ModifierKeyFlags))]
        [Tooltip("Store the result in an enum variable.")]
        public FsmEnum storeValue;

        public override void Reset() {
            base.Reset();
            storeValue = null;
        }

        protected override void DoUpdate() {
            UpdateStoreValue(aem.modifierKeyFlags);
        }

        protected void UpdateStoreValue(ModifierKeyFlags newValue) {
            if (!newValue.Equals(storeValue.Value)) { // value changed
                // Store new value
                storeValue.Value = newValue;
            }
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the keyboard key code. Only used for keyboard bindings. Returns UnityEngine.KeyCode value.")]
    public class RewiredActionElementMapGetKeyCode : RewiredActionElementMapFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField, UIHint(UIHint.Variable), ObjectType(typeof(KeyCode))]
        [Tooltip("Store the result in an enum variable.")]
        public FsmEnum storeValue;

        public override void Reset() {
            base.Reset();
            storeValue = null;
        }

        protected override void DoUpdate() {
            UpdateStoreValue(aem.keyCode);
        }

        protected void UpdateStoreValue(KeyCode newValue) {
            if (newValue != (KeyCode)storeValue.Value) { // value changed
                // Store new value
                storeValue.Value = newValue;
            }
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets whether this use any keyboard modfiier keys.")]
    public class RewiredActionElementMapGetHasModifiers : RewiredActionElementMapGetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            UpdateStoreValue(aem.hasModifiers);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the name of the element identifier bound to the Action. For split axes, this will return the Positive or Negative name or the Descriptive Name with a +/- suffix.")]
    public class RewiredActionElementMapGetElementIdentifierName : RewiredActionElementMapGetStringFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            UpdateStoreValue(aem.elementIdentifierName);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the controller element index pointed to by this mapping.")]
    public class RewiredActionElementMapGetElementIndex : RewiredActionElementMapGetIntFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            UpdateStoreValue(aem.elementIndex);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the unique runtime id of this ActionElementMap. This value is not consistent between game sessions, so do not store it.")]
    public class RewiredActionElementMapGetId : RewiredActionElementMapGetIntFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            UpdateStoreValue(aem.id);
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Gets the descriptive name of the Action. For split axes, this will return the Positive or Negative Descriptive Name or the Descriptive Name with a +/- suffix.")]
    public class RewiredActionElementMapGetActionDescriptiveName : RewiredActionElementMapGetStringFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            UpdateStoreValue(aem.actionDescriptiveName);
        }
    }

    #endregion

    #region Set

    [ActionCategory("Rewired")]
    [Tooltip("Sets whether the Action Element Map is enabled. Disabled maps will never return input.")]
    public class RewiredActionElementMapSetEnabled : RewiredActionElementMapSetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            aem.enabled = value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Sets the id of the Action to which the element is bound.")]
    public class RewiredActionElementMapSetActionId : RewiredActionElementMapSetIntFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            aem.actionId = value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Sets the controller element identifier id bound to the Action.")]
    public class RewiredActionElementMapSetElementIdentifierId : RewiredActionElementMapSetIntFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            aem.elementIdentifierId = value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Sets the range of the axis.")]
    public class RewiredActionElementMapSetAxisRange : RewiredActionElementMapFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField, ObjectType(typeof(AxisRange))]
        [Tooltip("The value to set.")]
        public FsmEnum value;

        public override void Reset() {
            base.Reset();
            value = null;
        }

        protected override void DoUpdate() {
            aem.axisRange = (AxisRange)value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Sets whether the axis inverted.")]
    public class RewiredActionElementMapSetInvert : RewiredActionElementMapSetBoolFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected override void DoUpdate() {
            aem.invert = value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Sets the axis contribution of the axis.")]
    public class RewiredActionElementMapSetAxisContribution : RewiredActionElementMapFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField, ObjectType(typeof(Pole))]
        [Tooltip("The value to set.")]
        public FsmEnum value;

        public override void Reset() {
            base.Reset();
            value = null;
        }

        protected override void DoUpdate() {
            aem.axisContribution = (Pole)value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Sets the keyboard key code. Only used for keyboard bindings. Returns Rewired.KeyboardKeyCode value.")]
    public class RewiredActionElementMapSetKeyboardKeyCode : RewiredActionElementMapFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField, ObjectType(typeof(KeyboardKeyCode))]
        [Tooltip("The value to set.")]
        public FsmEnum value;

        public override void Reset() {
            base.Reset();
            value = null;
        }

        protected override void DoUpdate() {
            aem.keyboardKeyCode = (KeyboardKeyCode)value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Sets the first keyboard modifier key.")]
    public class RewiredActionElementMapSetModifierKey1 : RewiredActionElementMapFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField, ObjectType(typeof(ModifierKey))]
        [Tooltip("The value to set.")]
        public FsmEnum value;

        public override void Reset() {
            base.Reset();
            value = null;
        }

        protected override void DoUpdate() {
            aem.modifierKey3 = (ModifierKey)value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Sets the second keyboard modifier key.")]
    public class RewiredActionElementMapSetModifierKey2 : RewiredActionElementMapFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField, ObjectType(typeof(ModifierKey))]
        [Tooltip("The value to set.")]
        public FsmEnum value;

        public override void Reset() {
            base.Reset();
            value = null;
        }

        protected override void DoUpdate() {
            aem.modifierKey2 = (ModifierKey)value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Sets the third keyboard modifier key.")]
    public class RewiredActionElementMapSetModifierKey3 : RewiredActionElementMapFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField, ObjectType(typeof(ModifierKey))]
        [Tooltip("The value to set.")]
        public FsmEnum value;

        public override void Reset() {
            base.Reset();
            value = null;
        }

        protected override void DoUpdate() {
            aem.modifierKey3 = (ModifierKey)value.Value;
        }
    }

    [ActionCategory("Rewired")]
    [Tooltip("Sets the keyboard key code. Only used for keyboard bindings. Returns UnityEngine.KeyCode value.")]
    public class RewiredActionElementMapSetKeyCode : RewiredActionElementMapFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField, ObjectType(typeof(KeyCode))]
        [Tooltip("The value to set.")]
        public FsmEnum value;

        public override void Reset() {
            base.Reset();
            value = null;
        }

        protected override void DoUpdate() {
            aem.keyCode = (KeyCode)value.Value;
        }
    }

    #endregion
}