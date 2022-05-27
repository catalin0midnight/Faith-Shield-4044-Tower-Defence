using UnityEngine;
using System;
using System.Collections;
using System.Collections.Generic;

namespace Rewired.Integration.PlayMaker {

    using HutongGames.PlayMaker;
    using HutongGames.PlayMaker.Actions;
    using HutongGames.Extensions;
    using HutongGames.Utility;
    using System;

    public static class Tools {

        private static Dictionary<int, Guid> __controllerTemplateTypes;
        private static Dictionary<int, Guid> _controllerTemplateTypes {
            get {
                return __controllerTemplateTypes ?? (__controllerTemplateTypes = new Dictionary<int, Guid>() {
                    { (int)Rewired.Integration.PlayMaker.ControllerTemplateType.Gamepad, new Guid("83b427e4-086f-47f3-bb06-be266abd1ca5") },
                    { (int)Rewired.Integration.PlayMaker.ControllerTemplateType.RacingWheel, new Guid("104e31d8-9115-4dd5-a398-2e54d35e6c83") },
                    { (int)Rewired.Integration.PlayMaker.ControllerTemplateType.HOTAS, new Guid("061a00cf-d8c2-4f8d-8cb5-a15a010bc53e") },
                    { (int)Rewired.Integration.PlayMaker.ControllerTemplateType.FlightYoke, new Guid("f311fa16-0ccc-41c0-ac4b-50f7100bb8ff") },
                    { (int)Rewired.Integration.PlayMaker.ControllerTemplateType.FlightPedals, new Guid("f6fe76f8-be2a-4db2-b853-9e3652075913") },
                    { (int)Rewired.Integration.PlayMaker.ControllerTemplateType.SixDofController, new Guid("2599beb3-522b-43dd-a4ef-93fd60e5eafa") }
                });
            }
        }

        public static Guid GetControllerTemplateTypeGuid(Rewired.Integration.PlayMaker.ControllerTemplateType type) {
            return _controllerTemplateTypes[(int)type];
        }

        /// <summary>
        /// Create an FsmEnum with a default value.
        /// Use this in Reset() to get around PM bug where default value is always 0.
        /// </summary>
        /// <typeparam name="TEnum">Type of the enum</typeparam>
        /// <param name="startingValue">The value to set in the FsmEnum.</param>
        /// <returns>FsmEnum</returns>
        public static FsmEnum CreateFsmEnum<TEnum>(TEnum startingValue) {
            if (startingValue as System.Enum == null) {
                Debug.LogError("TEnum must be an enum type.");
                return new FsmEnum();
            }
            FsmEnum e = new FsmEnum();
            e.EnumType = typeof(TEnum);
            e.RawValue = startingValue;
            e.Value = startingValue as System.Enum;
            return e;
        }

        public static bool DoesTypeImplement(Type type, Type baseOrInterfaceType) {
#if UNITY_WP_8 || UNITY_WP_8_1 || (UNITY_WSA && NETFX_CORE) || (WINDOWS_UWP && NETFX_CORE)
            return baseOrInterfaceType.GetTypeInfo().IsAssignableFrom(type.GetTypeInfo());
#else
            return baseOrInterfaceType.IsAssignableFrom(type);
#endif
        }
    }

    #region Base Classes

    public abstract class BaseFsmStateAction : FsmStateAction {

        public bool everyFrame;

        protected virtual bool defaultValue_everyFrame { get { return true; } } // default, classes can override

        public BaseFsmStateAction() {
            everyFrame = defaultValue_everyFrame;
        }

        public override void Reset() {
            base.Reset();
            everyFrame = defaultValue_everyFrame;
        }

        public override void OnEnter() {
            if (everyFrame) return; // only evaluate if !everyFrame so that Actions that need an immediate evaluation will work, but those that update every frame will not eval immediately like GetButtonDown

            // WARNING: Events fired from within OnEnter will cause infinite loops!
            // OnEnter is called again each time an event is fired.
            if (ValidateVars()) DoUpdate();
            Finish();
        }

        public override void OnUpdate() {
            if (!everyFrame) return; // only evaluate if every frame because things like GetButtonDown must not re-evaluate immediately
            if (!ValidateVars()) return;
            DoUpdate();
        }

        protected virtual bool ValidateVars() {
            return true;
        }

        protected void TrySendEvent(FsmEvent @event) {
            if (FsmEvent.IsNullOrEmpty(@event)) return;

            // Send the event
            Fsm.Event(@event);
        }

        protected abstract void DoUpdate();
    }

    public abstract class GetIntFsmStateAction : BaseFsmStateAction {

        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in an int variable.")]
        public FsmInt storeValue;

        [Tooltip("Event to send when the value changes.")]
        public FsmEvent valueChangedEvent;

        public override void Reset() {
            base.Reset();
            storeValue = 0;
            valueChangedEvent = null;
        }

        protected void UpdateStoreValue(int newValue) {
            if (newValue != storeValue.Value) { // value changed
                // Store new value
                storeValue.Value = newValue;
                TrySendEvent(valueChangedEvent); // send value changed event
            }
        }
    }

    public abstract class GetFloatFsmStateAction : BaseFsmStateAction {

        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a float variable.")]
        public FsmFloat storeValue;

        [Tooltip("The comparison operation to perform.")]
        public CompareOperation compareOperation = CompareOperation.None;

        [Tooltip("The value to which to compare the returned value.")]
        public FsmFloat compareToValue;

        [Tooltip("Compare using the absolute values of the two operands.")]
        public FsmBool compareAbsValues;

        [Tooltip("Event to send when the result of comparison returns true.")]
        public FsmEvent isTrueEvent;

        [Tooltip("Event to send when the result of comparison returns false.")]
        public FsmEvent isFalseEvent;

        [Tooltip("Event to send when the value changes.")]
        public FsmEvent valueChangedEvent;

        public override void Reset() {
            base.Reset();
            storeValue = 0f;
            compareOperation = CompareOperation.None;
            compareToValue = 0f;
            compareAbsValues = false;
            isTrueEvent = null;
            isFalseEvent = null;
            valueChangedEvent = null;
        }

        protected void UpdateStoreValue(float newValue) {
            if (newValue != storeValue.Value) { // value changed
                // Store new value
                storeValue.Value = newValue;
                TrySendEvent(valueChangedEvent); // send value changed event
            }

            // Compare values
            if (compareOperation != CompareOperation.None) {
                bool result = Compare(newValue);
                if (result) {
                    // send true event
                    TrySendEvent(isTrueEvent);
                } else {
                    // send false event
                    TrySendEvent(isFalseEvent);
                }
            }
        }

        private bool Compare(float value) {
            if (compareOperation == CompareOperation.None) return true;

            float val1, val2;
            if (compareAbsValues.Value) {
                val1 = Mathf.Abs(value);
                val2 = Mathf.Abs(compareToValue.Value);
            } else {
                val1 = value;
                val2 = compareToValue.Value;
            }

            switch (compareOperation) {
                case CompareOperation.LessThan:
                    return val1 < val2;
                case CompareOperation.LessThanOrEqualTo:
                    return val1 <= val2;
                case CompareOperation.EqualTo:
                    return val1 == val2;
                case CompareOperation.NotEqualTo:
                    return val1 != val2;
                case CompareOperation.GreaterThanOrEqualTo:
                    return val1 >= val2;
                case CompareOperation.GreaterThan:
                    return val1 > val2;
            }

            return false;
        }
    }

    public abstract class GetBoolFsmStateAction : BaseFsmStateAction {

        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a boolean variable.")]
        public FsmBool storeValue;

        [Tooltip("Event to send when bool value is true.")]
        public FsmEvent isTrueEvent;

        [Tooltip("Event to send when bool value is false.")]
        public FsmEvent isFalseEvent;

        [Tooltip("Event to send when the value changes.")]
        public FsmEvent valueChangedEvent;

        public override void Reset() {
            base.Reset();
            storeValue = false;
            isTrueEvent = null;
            isFalseEvent = null;
            valueChangedEvent = null;
        }

        protected void UpdateStoreValue(bool newValue) {
            if (newValue != storeValue.Value) { // value changed
                // Store new value
                storeValue.Value = newValue;
                TrySendEvent(valueChangedEvent); // send value changed event
            }

            // Send true event
            if (newValue) {
                TrySendEvent(isTrueEvent);
            } else {
                TrySendEvent(isFalseEvent);
            }
        }
    }

    public abstract class GetStringFsmStateAction : BaseFsmStateAction {

        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a string variable.")]
        public FsmString storeValue;

        [Tooltip("Event to send when the value changes.")]
        public FsmEvent valueChangedEvent;

        public override void Reset() {
            base.Reset();
            storeValue = null;
            valueChangedEvent = null;
        }

        protected void ClearStoreValue() {
            storeValue.Value = string.Empty;
        }

        protected void UpdateStoreValue(string newValue) {
            if (newValue != storeValue.Value) { // value changed
                // Store new value
                storeValue.Value = newValue;
                TrySendEvent(valueChangedEvent); // send value changed event
            }
        }
    }

    public abstract class GetEnumFsmStateAction : BaseFsmStateAction {

        //Variable must be set in the inheriting class so enum type can be set

        protected abstract FsmEnum _storeValue { get; set; }

        [Tooltip("Event to send when the value changes.")]
        public FsmEvent valueChangedEvent;

        public override void Reset() {
            base.Reset();
            _storeValue = null;
            valueChangedEvent = null;
        }

        protected void UpdateStoreValue(Enum newValue) {
            if (!newValue.Equals(_storeValue.Value)) { // value changed
                // Store new value
                _storeValue.Value = newValue;
                TrySendEvent(valueChangedEvent); // send value changed event
            }
        }
    }

    public abstract class GetIntArrayFsmStateAction : BaseFsmStateAction {

        [RequiredField, UIHint(UIHint.Variable), ArrayEditor(VariableType.Int), ObjectType(typeof(int))]
        [Tooltip("Store the result in an array variable.")]
        public FsmArray storeArray;

        protected List<int> workingList;

        public GetIntArrayFsmStateAction()
            : base() {
            workingList = new List<int>();
        }

        public override void Reset() {
            base.Reset();
            storeArray = null;
            workingList.Clear();
        }

        protected void UpdateStoreValue() {

            int listLength = workingList.Count;

            // Reset and resize the array first
            storeArray.Reset();
            storeArray.Resize(listLength);

            // Add each object to the object manager and get a unique id back
            for (int i = 0; i < listLength; i++) {
                storeArray.Set(i, workingList[i]);
            }

            // Clear the working list
            workingList.Clear();
        }
    }

    public abstract class GetFloatArrayFsmStateAction : BaseFsmStateAction {

        [RequiredField, UIHint(UIHint.Variable), ArrayEditor(VariableType.Float), ObjectType(typeof(float))]
        [Tooltip("Store the result in an array variable.")]
        public FsmArray storeArray;

        protected List<float> workingList;

        public GetFloatArrayFsmStateAction()
            : base() {
            workingList = new List<float>();
        }

        public override void Reset() {
            base.Reset();
            storeArray = null;
            workingList.Clear();
        }

        protected void UpdateStoreValue() {

            int listLength = workingList.Count;

            // Reset and resize the array first
            storeArray.Reset();
            storeArray.Resize(listLength);

            // Add each object to the object manager and get a unique id back
            for (int i = 0; i < listLength; i++) {
                storeArray.Set(i, workingList[i]);
            }

            // Clear the working list
            workingList.Clear();
        }
    }

    public abstract class GetBoolArrayFsmStateAction : BaseFsmStateAction {

        [RequiredField, UIHint(UIHint.Variable), ArrayEditor(VariableType.Bool), ObjectType(typeof(bool))]
        [Tooltip("Store the result in an array variable.")]
        public FsmArray storeArray;

        protected List<bool> workingList;

        public GetBoolArrayFsmStateAction()
            : base() {
            workingList = new List<bool>();
        }

        public override void Reset() {
            base.Reset();
            storeArray = null;
            workingList.Clear();
        }

        protected void UpdateStoreValue() {

            int listLength = workingList.Count;

            // Reset and resize the array first
            storeArray.Reset();
            storeArray.Resize(listLength);

            // Add each object to the object manager and get a unique id back
            for (int i = 0; i < listLength; i++) {
                storeArray.Set(i, workingList[i]);
            }

            // Clear the working list
            workingList.Clear();
        }
    }

    public abstract class GetStringArrayFsmStateAction : BaseFsmStateAction {

        [RequiredField, UIHint(UIHint.Variable), ArrayEditor(VariableType.String), ObjectType(typeof(string))]
        [Tooltip("Store the result in an array variable.")]
        public FsmArray storeArray;

        protected List<string> workingList;

        public GetStringArrayFsmStateAction()
            : base() {
            workingList = new List<string>();
        }

        public override void Reset() {
            base.Reset();
            storeArray = null;
            workingList.Clear();
        }

        protected void UpdateStoreValue() {

            int listLength = workingList.Count;

            // Reset and resize the array first
            storeArray.Reset();
            storeArray.Resize(listLength);

            // Add each object to the object manager and get a unique id back
            for (int i = 0; i < listLength; i++) {
                storeArray.Set(i, workingList[i]);
            }

            // Clear the working list
            workingList.Clear();
        }
    }

    public abstract class SetBoolFsmStateAction : BaseFsmStateAction {
        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField]
        [Tooltip("The value to set.")]
        public FsmBool value;

        public override void Reset() {
            base.Reset();
            value = false;
        }
    }

    public abstract class SetIntFsmStateAction : BaseFsmStateAction {
        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField]
        [Tooltip("The value to set.")]
        public FsmInt value;

        public override void Reset() {
            base.Reset();
            value = 0;
        }
    }

    public abstract class SetFloatFsmStateAction : BaseFsmStateAction {
        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField]
        [Tooltip("The value to set.")]
        public FsmFloat value;

        public override void Reset() {
            base.Reset();
            value = 0f;
        }
    }

    public abstract class SetStringFsmStateAction : BaseFsmStateAction {
        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField]
        [Tooltip("The value to set.")]
        public FsmString value;

        public override void Reset() {
            base.Reset();
            value = string.Empty;
        }
    }

    public abstract class SetEnumFsmStateAction : BaseFsmStateAction {
        protected override bool defaultValue_everyFrame { get { return false; } }

        //Variable must be set in the inheriting class so enum type can be set

        protected abstract FsmEnum _value { get; set; }

        public override void Reset() {
            base.Reset();
            _value = null;
        }
    }

    // REMOVED AT THIS TIME BECAUSE OF POTENTIAL MEMORY BLOAT ISSUES
    // Wait until PlayMaker adds support for storing non-serialized objects.
    /*public abstract class GetSystemObjectArrayFsmStateAction : BaseFsmStateAction {

        [RequiredField, UIHint(UIHint.Variable), ArrayEditor(VariableType.Int), ObjectType(typeof(int))]
        [Tooltip("Store the result in an array variable.")]
        public FsmArray storeArray;

        protected List<object> workingList;

        public GetSystemObjectArrayFsmStateAction() : base() {
            workingList = new List<object>();
        }

        public override void Reset() {
            base.Reset();
            storeArray = null;
            workingList.Clear();
        }

        protected void UpdateStoreValue() {

            int listLength = workingList.Count;

            // Reset and resize the array first
            storeArray.Reset();
            storeArray.Resize(listLength);

            // Add each object to the object manager and get a unique id back
            int count = 0;
            for(int i = 0; i < listLength; i++) {
                int uid;
                if(!ObjectManager.TryAddIfUnique(workingList[i], out uid)) continue; // failed to add
                storeArray.Set(count, uid);
                count++;
            }

            // Resize array again if some entries failed to be stored
            if(count != listLength) storeArray.Resize(count);

            // Clear the working list
            workingList.Clear();
        }
    }*/

    #region Player Base Classes

    public abstract class RewiredPlayerFsmStateAction : BaseFsmStateAction {

        [RequiredField]
        [Tooltip("The Rewired Player Id. To use the System Player, enter any value < 0 or 9999999.")]
        public FsmInt playerId;

        protected Player Player {
            get {
                if (playerId.Value == Rewired.Consts.systemPlayerId) return ReInput.players.GetSystemPlayer();
                if (playerId.Value < 0) return null;
                return ReInput.players.GetPlayer(playerId.Value);
            }
        }

        public override void Reset() {
            base.Reset();
            playerId = 0;
        }

        protected override bool ValidateVars() {
            if (!base.ValidateVars()) return false;

            if (playerId.IsNone) {
                LogError("Rewired Player Id must be assigned!");
                return false;
            }
            if (playerId.Value != Rewired.Consts.systemPlayerId && (playerId.Value < 0 || playerId.Value >= ReInput.players.playerCount)) {
                LogError("Rewired Player Id is out of range!");
                return false;
            }

            return true;
        }
    }

    public abstract class RewiredPlayerGetIntArrayFsmStateAction : RewiredPlayerFsmStateAction {

        [RequiredField, UIHint(UIHint.Variable), ArrayEditor(VariableType.Int), ObjectType(typeof(int))]
        [Tooltip("Store the result in an array variable.")]
        public FsmArray storeArray;

        protected List<int> workingList;

        public RewiredPlayerGetIntArrayFsmStateAction()
            : base() {
            workingList = new List<int>();
        }

        public override void Reset() {
            base.Reset();
            storeArray = null;
            workingList.Clear();
        }

        protected void UpdateStoreValue() {

            int listLength = workingList.Count;

            // Reset and resize the array first
            storeArray.Reset();
            storeArray.Resize(listLength);

            // Add each object to the object manager and get a unique id back
            for (int i = 0; i < listLength; i++) {
                storeArray.Set(i, workingList[i]);
            }

            // Clear the working list
            workingList.Clear();
        }
    }

    public abstract class RewiredPlayerActionFsmStateAction : RewiredPlayerFsmStateAction {

        [RequiredField]
        [Tooltip("The Action name string. Must match Action name exactly in the Rewired Input Manager.")]
        public FsmString actionName;

        public override void Reset() {
            base.Reset();
            actionName = string.Empty;
        }
    }

    public abstract class RewiredPlayerActionGetFloatFsmStateAction : RewiredPlayerActionFsmStateAction {

        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a float variable.")]
        public FsmFloat storeValue;

        [Tooltip("The comparison operation to perform.")]
        public CompareOperation compareOperation = CompareOperation.None;

        [Tooltip("The value to which to compare the returned value.")]
        public FsmFloat compareToValue;

        [Tooltip("Compare using the absolute values of the two operands.")]
        public FsmBool compareAbsValues;

        [Tooltip("Event to send when the result of comparison returns true.")]
        public FsmEvent isTrueEvent;

        [Tooltip("Event to send when the result of comparison returns false.")]
        public FsmEvent isFalseEvent;

        [Tooltip("Event to send when the value changes.")]
        public FsmEvent valueChangedEvent;

        public override void Reset() {
            base.Reset();
            storeValue = 0f;
            compareOperation = CompareOperation.None;
            compareToValue = 0f;
            compareAbsValues = false;
            isTrueEvent = null;
            isFalseEvent = null;
            valueChangedEvent = null;
        }

        protected void UpdateStoreValue(float newValue) {
            if (newValue != storeValue.Value) { // value changed
                // Store new value
                storeValue.Value = newValue;
                TrySendEvent(valueChangedEvent); // send value changed event
            }

            // Compare values
            if (compareOperation != CompareOperation.None) {
                bool result = Compare(newValue);
                if (result) {
                    // send true event
                    TrySendEvent(isTrueEvent);
                } else {
                    // send false event
                    TrySendEvent(isFalseEvent);
                }
            }
        }

        private bool Compare(float value) {
            if (compareOperation == CompareOperation.None) return true;

            float val1, val2;
            if (compareAbsValues.Value) {
                val1 = Mathf.Abs(value);
                val2 = Mathf.Abs(compareToValue.Value);
            } else {
                val1 = value;
                val2 = compareToValue.Value;
            }

            switch (compareOperation) {
                case CompareOperation.LessThan:
                    return val1 < val2;
                case CompareOperation.LessThanOrEqualTo:
                    return val1 <= val2;
                case CompareOperation.EqualTo:
                    return val1 == val2;
                case CompareOperation.NotEqualTo:
                    return val1 != val2;
                case CompareOperation.GreaterThanOrEqualTo:
                    return val1 >= val2;
                case CompareOperation.GreaterThan:
                    return val1 > val2;
            }

            return false;
        }
    }

    public abstract class RewiredPlayerActionGetBoolFsmStateAction : RewiredPlayerActionFsmStateAction {

        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a boolean variable.")]
        public FsmBool storeValue;

        [Tooltip("Event to send when bool value is true.")]
        public FsmEvent isTrueEvent;

        [Tooltip("Event to send when bool value is false.")]
        public FsmEvent isFalseEvent;

        [Tooltip("Event to send when the value changes.")]
        public FsmEvent valueChangedEvent;

        public override void Reset() {
            base.Reset();
            storeValue = false;
            isTrueEvent = null;
            isFalseEvent = null;
            valueChangedEvent = null;
        }

        protected void UpdateStoreValue(bool newValue) {
            if (newValue != storeValue.Value) { // value changed
                // Store new value
                storeValue.Value = newValue;
                TrySendEvent(valueChangedEvent); // send value changed event
            }

            // Send true event
            if (newValue) {
                TrySendEvent(isTrueEvent);
            } else {
                TrySendEvent(isFalseEvent);
            }
        }
    }

    public abstract class RewiredPlayerGetBoolFsmStateAction : RewiredPlayerFsmStateAction {

        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a boolean variable.")]
        public FsmBool storeValue;

        [Tooltip("Event to send when bool value is true.")]
        public FsmEvent isTrueEvent;

        [Tooltip("Event to send when bool value is false.")]
        public FsmEvent isFalseEvent;

        [Tooltip("Event to send when the value changes.")]
        public FsmEvent valueChangedEvent;

        public override void Reset() {
            base.Reset();
            storeValue = false;
            isTrueEvent = null;
            isFalseEvent = null;
            valueChangedEvent = null;
        }

        protected void UpdateStoreValue(bool newValue) {
            if (newValue != storeValue.Value) { // value changed
                // Store new value
                storeValue.Value = newValue;
                TrySendEvent(valueChangedEvent); // send value changed event
            }

            // Send true event
            if (newValue) {
                TrySendEvent(isTrueEvent);
            } else {
                TrySendEvent(isFalseEvent);
            }
        }
    }

    public abstract class RewiredPlayerActionGetAxis2DFsmStateAction : RewiredPlayerFsmStateAction {

        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a Vector2 variable.")]
        public FsmVector2 storeValue;

        [RequiredField]
        [Tooltip("The Action name string for the X axis value. Must match Action name exactly in the Rewired Input Manager.")]
        public FsmString actionNameX;

        [RequiredField]
        [Tooltip("The Action name string for the Y axis value. Must match Action name exactly in the Rewired Input Manager.")]
        public FsmString actionNameY;

        [Tooltip("Event to send when the value changes.")]
        public FsmEvent valueChangedEvent;

        public override void Reset() {
            base.Reset();
            storeValue = Vector2.zero;
            actionNameX = string.Empty;
            actionNameY = string.Empty;
        }

        protected void UpdateStoreValue(Vector2 newValue) {
            if (newValue != storeValue.Value) { // value changed
                // Store new value
                storeValue.Value = newValue;
                TrySendEvent(valueChangedEvent); // send value changed event
            }
        }
    }

    public abstract class RewiredPlayerInputBehaviorFsmStateAction : RewiredPlayerFsmStateAction {

        protected override bool defaultValue_everyFrame { get { return false; } }

        [RequiredField]
        [Tooltip("Input Behavior name string.")]
        public FsmString behaviorName;

        public InputBehavior Behavior {
            get {
                InputBehavior behavior = Player.controllers.maps.GetInputBehavior(behaviorName.Value);
                if (behavior == null) {
                    Debug.LogError("Input Behavior \"" + behaviorName.Value + "\" does not exist!");
                }
                return behavior;
            }
        }

        public override void Reset() {
            base.Reset();
            behaviorName = string.Empty;
        }

    }

    public abstract class RewiredPlayerSetBoolFsmStateAction : RewiredPlayerFsmStateAction {

        [Tooltip("The value to set.")]
        public FsmBool value;

        public override void Reset() {
            base.Reset();
            value = false;
        }
    }

    public abstract class RewiredPlayerLayoutManagerFsmStateAction : RewiredPlayerFsmStateAction {

        protected ControllerMapLayoutManager LayoutManager {
            get {
                if (Player == null) return null;
                return Player.controllers.maps.layoutManager;
            }
        }
    }

    public abstract class RewiredPlayerLayoutManagerGetBoolFsmStateAction : RewiredPlayerLayoutManagerFsmStateAction {

        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a boolean variable.")]
        public FsmBool storeValue;

        [Tooltip("Event to send when bool value is true.")]
        public FsmEvent isTrueEvent;

        [Tooltip("Event to send when bool value is false.")]
        public FsmEvent isFalseEvent;

        [Tooltip("Event to send when the value changes.")]
        public FsmEvent valueChangedEvent;

        public override void Reset() {
            base.Reset();
            storeValue = false;
            isTrueEvent = null;
            isFalseEvent = null;
            valueChangedEvent = null;
        }

        protected void UpdateStoreValue(bool newValue) {
            if (newValue != storeValue.Value) { // value changed
                // Store new value
                storeValue.Value = newValue;
                TrySendEvent(valueChangedEvent); // send value changed event
            }

            // Send true event
            if (newValue) {
                TrySendEvent(isTrueEvent);
            } else {
                TrySendEvent(isFalseEvent);
            }
        }
    }

    public abstract class RewiredPlayerLayoutManagerSetBoolFsmStateAction : RewiredPlayerLayoutManagerFsmStateAction {

        [Tooltip("The value to set.")]
        public FsmBool value;

        public override void Reset() {
            base.Reset();
            value = false;
        }
    }

    public abstract class RewiredPlayerLayoutManagerRuleSetFsmStateAction : RewiredPlayerLayoutManagerFsmStateAction {

        [RequiredField]
        [Tooltip("The Tag of the Rule Set.")]
        public FsmString tag;

        protected ControllerMapLayoutManager.RuleSet RuleSet {
            get {
                if (Player == null) return null;
                return Player.controllers.maps.layoutManager.ruleSets.Find(x => string.Equals(x.tag, tag.Value, StringComparison.Ordinal));
            }
        }

        public override void Reset() {
            base.Reset();
            tag = null;
        }

        protected override bool ValidateVars() {
            if (!base.ValidateVars()) return false;
            return RuleSet != null;
        }
    }

    public abstract class RewiredPlayerLayoutManagerRuleSetGetBoolFsmStateAction : RewiredPlayerLayoutManagerRuleSetFsmStateAction {

        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a boolean variable.")]
        public FsmBool storeValue;

        [Tooltip("Event to send when bool value is true.")]
        public FsmEvent isTrueEvent;

        [Tooltip("Event to send when bool value is false.")]
        public FsmEvent isFalseEvent;

        [Tooltip("Event to send when the value changes.")]
        public FsmEvent valueChangedEvent;

        public override void Reset() {
            base.Reset();
            storeValue = false;
            isTrueEvent = null;
            isFalseEvent = null;
            valueChangedEvent = null;
        }

        protected void UpdateStoreValue(bool newValue) {
            if (newValue != storeValue.Value) { // value changed
                // Store new value
                storeValue.Value = newValue;
                TrySendEvent(valueChangedEvent); // send value changed event
            }

            // Send true event
            if (newValue) {
                TrySendEvent(isTrueEvent);
            } else {
                TrySendEvent(isFalseEvent);
            }
        }
    }

    public abstract class RewiredPlayerLayoutManagerRuleSetSetBoolFsmStateAction : RewiredPlayerLayoutManagerRuleSetFsmStateAction {

        [Tooltip("The value to set.")]
        public FsmBool value;

        public override void Reset() {
            base.Reset();
            value = false;
        }
    }

    public abstract class RewiredPlayerMapEnablerFsmStateAction : RewiredPlayerFsmStateAction {

        protected ControllerMapEnabler MapEnabler {
            get {
                if (Player == null) return null;
                return Player.controllers.maps.mapEnabler;
            }
        }
    }

    public abstract class RewiredPlayerMapEnablerGetBoolFsmStateAction : RewiredPlayerMapEnablerFsmStateAction {

        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a boolean variable.")]
        public FsmBool storeValue;

        [Tooltip("Event to send when bool value is true.")]
        public FsmEvent isTrueEvent;

        [Tooltip("Event to send when bool value is false.")]
        public FsmEvent isFalseEvent;

        [Tooltip("Event to send when the value changes.")]
        public FsmEvent valueChangedEvent;

        public override void Reset() {
            base.Reset();
            storeValue = false;
            isTrueEvent = null;
            isFalseEvent = null;
            valueChangedEvent = null;
        }

        protected void UpdateStoreValue(bool newValue) {
            if (newValue != storeValue.Value) { // value changed
                // Store new value
                storeValue.Value = newValue;
                TrySendEvent(valueChangedEvent); // send value changed event
            }

            // Send true event
            if (newValue) {
                TrySendEvent(isTrueEvent);
            } else {
                TrySendEvent(isFalseEvent);
            }
        }
    }

    public abstract class RewiredPlayerMapEnablerSetBoolFsmStateAction : RewiredPlayerMapEnablerFsmStateAction {

        [Tooltip("The value to set.")]
        public FsmBool value;

        public override void Reset() {
            base.Reset();
            value = false;
        }
    }

    public abstract class RewiredPlayerMapEnablerRuleSetFsmStateAction : RewiredPlayerMapEnablerFsmStateAction {

        [RequiredField]
        [Tooltip("The Tag of the Rule Set.")]
        public FsmString tag;

        protected ControllerMapEnabler.RuleSet RuleSet {
            get {
                if (Player == null) return null;
                return Player.controllers.maps.mapEnabler.ruleSets.Find(x => string.Equals(x.tag, tag.Value, StringComparison.Ordinal));
            }
        }

        public override void Reset() {
            base.Reset();
            tag = null;
        }

        protected override bool ValidateVars() {
            if (!base.ValidateVars()) return false;
            return RuleSet != null;
        }
    }

    public abstract class RewiredPlayerMapEnablerRuleSetGetBoolFsmStateAction : RewiredPlayerMapEnablerRuleSetFsmStateAction {

        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a boolean variable.")]
        public FsmBool storeValue;

        [Tooltip("Event to send when bool value is true.")]
        public FsmEvent isTrueEvent;

        [Tooltip("Event to send when bool value is false.")]
        public FsmEvent isFalseEvent;

        [Tooltip("Event to send when the value changes.")]
        public FsmEvent valueChangedEvent;

        public override void Reset() {
            base.Reset();
            storeValue = false;
            isTrueEvent = null;
            isFalseEvent = null;
            valueChangedEvent = null;
        }

        protected void UpdateStoreValue(bool newValue) {
            if (newValue != storeValue.Value) { // value changed
                // Store new value
                storeValue.Value = newValue;
                TrySendEvent(valueChangedEvent); // send value changed event
            }

            // Send true event
            if (newValue) {
                TrySendEvent(isTrueEvent);
            } else {
                TrySendEvent(isFalseEvent);
            }
        }
    }

    public abstract class RewiredPlayerMapEnablerRuleSetSetBoolFsmStateAction : RewiredPlayerMapEnablerRuleSetFsmStateAction {

        [Tooltip("The value to set.")]
        public FsmBool value;

        public override void Reset() {
            base.Reset();
            value = false;
        }
    }

    #endregion

    #region Controller Base Classes

    public abstract class RewiredControllerFsmStateAction : BaseFsmStateAction {

        //[UIHint(UIHint.Variable)]
        //[Tooltip("The Controller object.")]
        //public FsmInt controller;

        [ObjectType(typeof(ControllerType))]
        [Tooltip("The controller type.")]// This is only used if Controller is not set.")]
        public FsmEnum controllerType;

        [Tooltip("The controller id.")]// This is only used if Controller is not set.")]
        public FsmInt controllerId = 0;

        protected Controller Controller {
            get {
                // Fail if controller uid has been set and no controller is found.
                //if(!this.controller.IsNone) {
                //    // Do not fall back to type/id if uid is non-null and no controller is found
                //    Controller controller;
                //    if(!ObjectManager.TryGet<Controller>(this.controller.Value, out controller)) {
                //        Log("Controller reference is set but is invalid. Set this to None if you want to get the Controller by Controller Type and Controller Id instead.");
                //        return null;
                //    } else return controller;
                //} else { // Controller uid is null 
                return ReInput.controllers.GetController((ControllerType)controllerType.Value, controllerId.Value);
                //}
            }
        }

        protected bool HasController { get { return Controller != null; } }

        public override void Reset() {
            base.Reset();
            //controller = null;
            controllerType = null;
            controllerId = 0;
        }

        protected override bool ValidateVars() {
            if (!base.ValidateVars()) return false;

            if (!HasController) return false;

            return true;
        }
    }

    public abstract class RewiredControllerGetIntFsmStateAction : RewiredControllerFsmStateAction {

        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a int variable.")]
        public FsmInt storeValue;

        [Tooltip("Event to send when the value changes.")]
        public FsmEvent valueChangedEvent;

        public override void Reset() {
            base.Reset();
            storeValue = null;
            valueChangedEvent = null;
        }

        protected void UpdateStoreValue(int newValue) {
            if (newValue != storeValue.Value) { // value changed
                // Store new value
                storeValue.Value = newValue;
                TrySendEvent(valueChangedEvent); // send value changed event
            }
        }
    }

    public abstract class RewiredControllerGetFloatFsmStateAction : RewiredControllerFsmStateAction {

        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a float variable.")]
        public FsmFloat storeValue;

        [Tooltip("The comparison operation to perform.")]
        public CompareOperation compareOperation = CompareOperation.None;

        [Tooltip("The value to which to compare the returned value.")]
        public FsmFloat compareToValue;

        [Tooltip("Compare using the absolute values of the two operands.")]
        public FsmBool compareAbsValues;

        [Tooltip("Event to send when the result of comparison returns true.")]
        public FsmEvent isTrueEvent;

        [Tooltip("Event to send when the result of comparison returns false.")]
        public FsmEvent isFalseEvent;

        [Tooltip("Event to send when the value changes.")]
        public FsmEvent valueChangedEvent;

        public override void Reset() {
            base.Reset();
            storeValue = null;
            compareOperation = CompareOperation.None;
            compareToValue = 0f;
            compareAbsValues = false;
            isTrueEvent = null;
            isFalseEvent = null;
            valueChangedEvent = null;
        }

        protected void UpdateStoreValue(float newValue) {
            if (newValue != storeValue.Value) { // value changed
                // Store new value
                storeValue.Value = newValue;
                TrySendEvent(valueChangedEvent); // send value changed event
            }

            // Compare values
            if (compareOperation != CompareOperation.None) {
                bool result = Compare(newValue);
                if (result) {
                    // send true event
                    TrySendEvent(isTrueEvent);
                } else {
                    // send false event
                    TrySendEvent(isFalseEvent);
                }
            }
        }

        private bool Compare(float value) {
            if (compareOperation == CompareOperation.None) return true;

            float val1, val2;
            if (compareAbsValues.Value) {
                val1 = Mathf.Abs(value);
                val2 = Mathf.Abs(compareToValue.Value);
            } else {
                val1 = value;
                val2 = compareToValue.Value;
            }

            switch (compareOperation) {
                case CompareOperation.LessThan:
                    return val1 < val2;
                case CompareOperation.LessThanOrEqualTo:
                    return val1 <= val2;
                case CompareOperation.EqualTo:
                    return val1 == val2;
                case CompareOperation.NotEqualTo:
                    return val1 != val2;
                case CompareOperation.GreaterThanOrEqualTo:
                    return val1 >= val2;
                case CompareOperation.GreaterThan:
                    return val1 > val2;
            }

            return false;
        }
    }

    public abstract class RewiredControllerGetBoolFsmStateAction : RewiredControllerFsmStateAction {

        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a bool variable.")]
        public FsmBool storeValue;

        [Tooltip("Event to send when bool value is true.")]
        public FsmEvent isTrueEvent;

        [Tooltip("Event to send when bool value is false.")]
        public FsmEvent isFalseEvent;

        [Tooltip("Event to send when the value changes.")]
        public FsmEvent valueChangedEvent;

        public override void Reset() {
            base.Reset();
            storeValue = null;
            isTrueEvent = null;
            isFalseEvent = null;
            valueChangedEvent = null;
        }

        protected void UpdateStoreValue(bool newValue) {
            if (newValue != storeValue.Value) { // value changed
                // Store new value
                storeValue.Value = newValue;
                TrySendEvent(valueChangedEvent); // send value changed event
            }

            // Send true event
            if (newValue) {
                TrySendEvent(isTrueEvent);
            } else {
                TrySendEvent(isFalseEvent);
            }
        }
    }

    public abstract class RewiredControllerGetStringFsmStateAction : RewiredControllerFsmStateAction {

        [RequiredField, UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a string variable.")]
        public FsmString storeValue;

        public override void Reset() {
            base.Reset();
            storeValue = null;
        }

        protected void UpdateStoreValue(string newValue) {
            if (newValue != storeValue.Value) { // value changed
                // Store new value
                storeValue.Value = newValue;
            }
        }
    }

    public abstract class RewiredControllerSetBoolFsmStateAction : RewiredControllerFsmStateAction {

        [UIHint(UIHint.Variable)]
        [Tooltip("The value to set.")]
        public FsmBool value;

        [Tooltip("Event to send when bool value is true.")]
        public FsmEvent isTrueEvent;

        [Tooltip("Event to send when bool value is false.")]
        public FsmEvent isFalseEvent;

        [Tooltip("Event to send when the value changes.")]
        public FsmEvent valueChangedEvent;

        public override void Reset() {
            base.Reset();
            value = null;
            isTrueEvent = null;
            isFalseEvent = null;
            valueChangedEvent = null;
        }
    }

    public abstract class RewiredControllerGetVector2FsmStateAction : RewiredControllerFsmStateAction {

        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a Vector2 variable.")]
        public FsmVector2 storeValue;

        [Tooltip("Event to send when the value changes.")]
        public FsmEvent valueChangedEvent;

        public override void Reset() {
            base.Reset();
            storeValue = null;
            valueChangedEvent = null;
        }

        protected void UpdateStoreValue(Vector2 newValue) {
            if (!Mathf.Approximately(newValue.x, storeValue.Value.x) || !Mathf.Approximately(newValue.y, storeValue.Value.y)) { // value changed
                // Store new value
                storeValue.Value = newValue;
                TrySendEvent(valueChangedEvent); // send value changed event
            }
        }
    }

    #endregion

    #region Joystick Base Classes

    public abstract class RewiredJoystickFsmStateAction : BaseFsmStateAction {

        //[UIHint(UIHint.Variable)]
        //[Tooltip("The Joystick object.")]
        //public FsmInt joystick;

        [Tooltip("The joystick id.")]// This is only used if Joystick is not set.")]
        public FsmInt joystickId = 0;

        protected Joystick Joystick {
            get {
                // Fail if joystick uid has been set and no joystick is found.
                //if(!this.joystick.IsNone) {
                //    // Do not fall back to type/id if uid is non-null and no joystick is found
                //    Joystick joystick;
                //    if(!ObjectManager.TryGet<Joystick>(this.joystick.Value, out joystick)) {
                //        Log("Joystick reference is set but is invalid. Set this to None if you want to get the Joystick by Joystick Id instead.");
                //        return null;
                //    } else return joystick;
                //} else { // Joystick uid is null 
                return ReInput.controllers.GetJoystick(joystickId.Value);
                //}
            }
        }

        protected bool HasJoystick { get { return Joystick != null; } }

        public override void Reset() {
            base.Reset();
            //joystick = null;
            joystickId = 0;
        }

        protected override bool ValidateVars() {
            if (!base.ValidateVars()) return false;

            if (!HasJoystick) return false;

            return true;
        }
    }

    public abstract class RewiredJoystickGetIntFsmStateAction : RewiredJoystickFsmStateAction {

        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a int variable.")]
        public FsmInt storeValue;

        [Tooltip("Event to send when the value changes.")]
        public FsmEvent valueChangedEvent;

        public override void Reset() {
            base.Reset();
            storeValue = null;
            valueChangedEvent = null;
        }

        protected void UpdateStoreValue(int newValue) {
            if (newValue != storeValue.Value) { // value changed
                // Store new value
                storeValue.Value = newValue;
                TrySendEvent(valueChangedEvent); // send value changed event
            }
        }
    }

    public abstract class RewiredJoystickGetFloatFsmStateAction : RewiredJoystickFsmStateAction {

        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a float variable.")]
        public FsmFloat storeValue;

        [Tooltip("The comparison operation to perform.")]
        public CompareOperation compareOperation = CompareOperation.None;

        [Tooltip("The value to which to compare the returned value.")]
        public FsmFloat compareToValue;

        [Tooltip("Compare using the absolute values of the two operands.")]
        public FsmBool compareAbsValues;

        [Tooltip("Event to send when the result of comparison returns true.")]
        public FsmEvent isTrueEvent;

        [Tooltip("Event to send when the result of comparison returns false.")]
        public FsmEvent isFalseEvent;

        [Tooltip("Event to send when the value changes.")]
        public FsmEvent valueChangedEvent;

        public override void Reset() {
            base.Reset();
            storeValue = null;
            compareOperation = CompareOperation.None;
            compareToValue = 0f;
            compareAbsValues = false;
            isTrueEvent = null;
            isFalseEvent = null;
            valueChangedEvent = null;
        }

        protected void UpdateStoreValue(float newValue) {
            if (newValue != storeValue.Value) { // value changed
                // Store new value
                storeValue.Value = newValue;
                TrySendEvent(valueChangedEvent); // send value changed event
            }

            // Compare values
            if (compareOperation != CompareOperation.None) {
                bool result = Compare(newValue);
                if (result) {
                    // send true event
                    TrySendEvent(isTrueEvent);
                } else {
                    // send false event
                    TrySendEvent(isFalseEvent);
                }
            }
        }

        private bool Compare(float value) {
            if (compareOperation == CompareOperation.None) return true;

            float val1, val2;
            if (compareAbsValues.Value) {
                val1 = Mathf.Abs(value);
                val2 = Mathf.Abs(compareToValue.Value);
            } else {
                val1 = value;
                val2 = compareToValue.Value;
            }

            switch (compareOperation) {
                case CompareOperation.LessThan:
                    return val1 < val2;
                case CompareOperation.LessThanOrEqualTo:
                    return val1 <= val2;
                case CompareOperation.EqualTo:
                    return val1 == val2;
                case CompareOperation.NotEqualTo:
                    return val1 != val2;
                case CompareOperation.GreaterThanOrEqualTo:
                    return val1 >= val2;
                case CompareOperation.GreaterThan:
                    return val1 > val2;
            }

            return false;
        }
    }

    public abstract class RewiredJoystickGetBoolFsmStateAction : RewiredJoystickFsmStateAction {

        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a bool variable.")]
        public FsmBool storeValue;

        [Tooltip("Event to send when bool value is true.")]
        public FsmEvent isTrueEvent;

        [Tooltip("Event to send when bool value is false.")]
        public FsmEvent isFalseEvent;

        [Tooltip("Event to send when the value changes.")]
        public FsmEvent valueChangedEvent;

        public override void Reset() {
            base.Reset();
            storeValue = null;
            isTrueEvent = null;
            isFalseEvent = null;
            valueChangedEvent = null;
        }

        protected void UpdateStoreValue(bool newValue) {
            if (newValue != storeValue.Value) { // value changed
                // Store new value
                storeValue.Value = newValue;
                TrySendEvent(valueChangedEvent); // send value changed event
            }

            // Send true event
            if (newValue) {
                TrySendEvent(isTrueEvent);
            } else {
                TrySendEvent(isFalseEvent);
            }
        }
    }

    public abstract class RewiredJoystickGetStringFsmStateAction : RewiredJoystickFsmStateAction {

        [RequiredField, UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a string variable.")]
        public FsmString storeValue;

        public override void Reset() {
            base.Reset();
            storeValue = null;
        }

        protected void UpdateStoreValue(string newValue) {
            if (newValue != storeValue.Value) { // value changed
                // Store new value
                storeValue.Value = newValue;
            }
        }
    }

    public abstract class RewiredJoystickSetStringFsmStateAction : RewiredJoystickFsmStateAction {

        [RequiredField]
        [Tooltip("Set the value.")]
        public FsmString value;

        public override void Reset() {
            base.Reset();
            value = null;
        }
    }

    #endregion

    #region Joystick Extension Base Classes

    public abstract class RewiredJoystickExtensionFsmStateAction<T> : BaseFsmStateAction where T : class {

        [Tooltip("The joystick id.")]
        public FsmInt joystickId = 0;

        protected override bool defaultValue_everyFrame { get { return false; } }

        protected Joystick Joystick { get { return ReInput.controllers.GetJoystick(joystickId.Value); } }

        protected T Extension {
            get {
                Joystick joystick = Joystick;
                if (joystick == null) return null;
                return joystick.GetExtension<T>();
            }
        }

        protected bool HasExtension { get { return Extension != null; } }

        public override void Reset() {
            base.Reset();
            joystickId = 0;
        }

        protected override bool ValidateVars() {
            if (!base.ValidateVars()) return false;

            if (!HasExtension) return false;

            return true;
        }
    }

    public abstract class RewiredJoystickExtensionGetIntFsmStateAction<T> : RewiredJoystickExtensionFsmStateAction<T> where T : class {

        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a int variable.")]
        public FsmInt storeValue;

        [Tooltip("Event to send when the value changes.")]
        public FsmEvent valueChangedEvent;

        public override void Reset() {
            base.Reset();
            storeValue = null;
            valueChangedEvent = null;
        }

        protected void UpdateStoreValue(int newValue) {
            if (newValue != storeValue.Value) { // value changed
                // Store new value
                storeValue.Value = newValue;
                TrySendEvent(valueChangedEvent); // send value changed event
            }
        }
    }

    public abstract class RewiredJoystickExtensionGetFloatFsmStateAction<T> : RewiredJoystickExtensionFsmStateAction<T> where T : class {

        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a float variable.")]
        public FsmFloat storeValue;

        [Tooltip("The comparison operation to perform.")]
        public CompareOperation compareOperation = CompareOperation.None;

        [Tooltip("The value to which to compare the returned value.")]
        public FsmFloat compareToValue;

        [Tooltip("Compare using the absolute values of the two operands.")]
        public FsmBool compareAbsValues;

        [Tooltip("Event to send when the result of comparison returns true.")]
        public FsmEvent isTrueEvent;

        [Tooltip("Event to send when the result of comparison returns false.")]
        public FsmEvent isFalseEvent;

        [Tooltip("Event to send when the value changes.")]
        public FsmEvent valueChangedEvent;

        public override void Reset() {
            base.Reset();
            storeValue = null;
            compareOperation = CompareOperation.None;
            compareToValue = 0f;
            compareAbsValues = false;
            isTrueEvent = null;
            isFalseEvent = null;
            valueChangedEvent = null;
        }

        protected void UpdateStoreValue(float newValue) {
            if (newValue != storeValue.Value) { // value changed
                // Store new value
                storeValue.Value = newValue;
                TrySendEvent(valueChangedEvent); // send value changed event
            }

            // Compare values
            if (compareOperation != CompareOperation.None) {
                bool result = Compare(newValue);
                if (result) {
                    // send true event
                    TrySendEvent(isTrueEvent);
                } else {
                    // send false event
                    TrySendEvent(isFalseEvent);
                }
            }
        }

        private bool Compare(float value) {
            if (compareOperation == CompareOperation.None) return true;

            float val1, val2;
            if (compareAbsValues.Value) {
                val1 = Mathf.Abs(value);
                val2 = Mathf.Abs(compareToValue.Value);
            } else {
                val1 = value;
                val2 = compareToValue.Value;
            }

            switch (compareOperation) {
                case CompareOperation.LessThan:
                    return val1 < val2;
                case CompareOperation.LessThanOrEqualTo:
                    return val1 <= val2;
                case CompareOperation.EqualTo:
                    return val1 == val2;
                case CompareOperation.NotEqualTo:
                    return val1 != val2;
                case CompareOperation.GreaterThanOrEqualTo:
                    return val1 >= val2;
                case CompareOperation.GreaterThan:
                    return val1 > val2;
            }

            return false;
        }
    }

    public abstract class RewiredJoystickExtensionGetBoolFsmStateAction<T> : RewiredJoystickExtensionFsmStateAction<T> where T : class {

        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a bool variable.")]
        public FsmBool storeValue;

        [Tooltip("Event to send when bool value is true.")]
        public FsmEvent isTrueEvent;

        [Tooltip("Event to send when bool value is false.")]
        public FsmEvent isFalseEvent;

        [Tooltip("Event to send when the value changes.")]
        public FsmEvent valueChangedEvent;

        public override void Reset() {
            base.Reset();
            storeValue = null;
            isTrueEvent = null;
            isFalseEvent = null;
            valueChangedEvent = null;
        }

        protected void UpdateStoreValue(bool newValue) {
            if (newValue != storeValue.Value) { // value changed
                // Store new value
                storeValue.Value = newValue;
                TrySendEvent(valueChangedEvent); // send value changed event
            }

            // Send true event
            if (newValue) {
                TrySendEvent(isTrueEvent);
            } else {
                TrySendEvent(isFalseEvent);
            }
        }
    }

    public abstract class RewiredJoystickExtensionGetStringFsmStateAction<T> : RewiredJoystickExtensionFsmStateAction<T> where T : class {

        [RequiredField, UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a string variable.")]
        public FsmString storeValue;

        public override void Reset() {
            base.Reset();
            storeValue = null;
        }

        protected void UpdateStoreValue(string newValue) {
            if (newValue != storeValue.Value) { // value changed
                // Store new value
                storeValue.Value = newValue;
            }
        }
    }

    public abstract class RewiredJoystickExtensionGetEnumFsmStateAction<T> : RewiredJoystickExtensionFsmStateAction<T> where T : class {

        //Variable must be set in the inheriting class so enum type can be set

        protected abstract FsmEnum _storeValue { get; set; }

        [Tooltip("Event to send when the value changes.")]
        public FsmEvent valueChangedEvent;

        public override void Reset() {
            base.Reset();
            _storeValue = null;
            valueChangedEvent = null;
        }

        protected void UpdateStoreValue(Enum newValue) {
            if (!newValue.Equals(_storeValue.Value)) { // value changed
                // Store new value
                _storeValue.Value = newValue;
                TrySendEvent(valueChangedEvent); // send value changed event
            }
        }
    }

    public abstract class RewiredJoystickExtensionGetColorFsmStateAction<T> : RewiredJoystickExtensionFsmStateAction<T> where T : class {

        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a Color variable.")]
        public FsmColor storeValue;

        [Tooltip("Event to send when the value changes.")]
        public FsmEvent valueChangedEvent;

        public override void Reset() {
            base.Reset();
            storeValue = null;
            valueChangedEvent = null;
        }

        protected void UpdateStoreValue(Color newValue) {
            if (newValue != storeValue.Value) { // value changed
                // Store new value
                storeValue.Value = newValue;
                TrySendEvent(valueChangedEvent); // send value changed event
            }
        }
    }

    public abstract class RewiredJoystickExtensionGetVector3FsmStateAction<T> : RewiredJoystickExtensionFsmStateAction<T> where T : class {

        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a Vector3 variable.")]
        public FsmVector3 storeValue;

        [Tooltip("Event to send when the value changes.")]
        public FsmEvent valueChangedEvent;

        public override void Reset() {
            base.Reset();
            storeValue = Vector3.zero;
            valueChangedEvent = null;
        }

        protected void UpdateStoreValue(Vector3 newValue) {
            if (newValue != storeValue.Value) { // value changed
                // Store new value
                storeValue.Value = newValue;
                TrySendEvent(valueChangedEvent); // send value changed event
            }
        }
    }

    public abstract class RewiredJoystickExtensionGetQuaternionFsmStateAction<T> : RewiredJoystickExtensionFsmStateAction<T> where T : class {

        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a Quaternion variable.")]
        public FsmQuaternion storeValue;

        [Tooltip("Event to send when the value changes.")]
        public FsmEvent valueChangedEvent;

        public override void Reset() {
            base.Reset();
            storeValue = Quaternion.identity;
            valueChangedEvent = null;
        }

        protected void UpdateStoreValue(Quaternion newValue) {
            if (newValue != storeValue.Value) { // value changed
                // Store new value
                storeValue.Value = newValue;
                TrySendEvent(valueChangedEvent); // send value changed event
            }
        }
    }

    public abstract class RewiredJoystickExtensionSetIntFsmStateAction<T> : RewiredJoystickExtensionFsmStateAction<T> where T : class {

        [RequiredField]
        [Tooltip("Set the value.")]
        public FsmInt value;

        public override void Reset() {
            base.Reset();
            value = 0;
        }
    }

    public abstract class RewiredJoystickExtensionSetFloatFsmStateAction<T> : RewiredJoystickExtensionFsmStateAction<T> where T : class {

        [RequiredField]
        [Tooltip("Set the value.")]
        public FsmFloat value;

        public override void Reset() {
            base.Reset();
            value = 0f;
        }
    }

    public abstract class RewiredJoystickExtensionSetBoolFsmStateAction<T> : RewiredJoystickExtensionFsmStateAction<T> where T : class {

        [RequiredField]
        [Tooltip("Set the value.")]
        public FsmBool value;

        public override void Reset() {
            base.Reset();
            value = false;
        }
    }

    public abstract class RewiredJoystickExtensionSetStringFsmStateAction<T> : RewiredJoystickExtensionFsmStateAction<T> where T : class {

        [RequiredField]
        [Tooltip("Set the value.")]
        public FsmString value;

        public override void Reset() {
            base.Reset();
            value = null;
        }
    }

    public abstract class RewiredJoystickExtensionSetEnumFsmStateAction<T> : RewiredJoystickExtensionFsmStateAction<T> where T : class {

        protected override bool defaultValue_everyFrame { get { return false; } }

        //Variable must be set in the inheriting class so enum type can be set

        protected abstract FsmEnum _value { get; set; }

        public override void Reset() {
            base.Reset();
            _value = null;
        }
    }

    public abstract class RewiredJoystickExtensionSetColorFsmStateAction<T> : RewiredJoystickExtensionFsmStateAction<T> where T : class {

        [RequiredField]
        [Tooltip("Set the value.")]
        public FsmColor value;

        public override void Reset() {
            base.Reset();
            value = new Color();
        }
    }

    #endregion

    #endregion

    #region ActionElementMap Base Classes

    public abstract class RewiredActionElementMapFsmStateAction : BaseFsmStateAction {

        [RequiredField]
        [UIHint(UIHint.Variable)]
        [Tooltip("The ActionElementMap id.")]
        public FsmInt actionElementMapId;

        protected ActionElementMap aem { get { return FindActionElementMap(actionElementMapId.Value); } }

        protected bool HasAEM { get { return aem != null; } }

        public override void Reset() {
            base.Reset();
            actionElementMapId = -1;
        }

        protected override bool ValidateVars() {
            if (!base.ValidateVars()) return false;

            if (!HasAEM) return false;

            return true;
        }

        private static ActionElementMap FindActionElementMap(int uid) {
            if (!ReInput.isReady) return null;

            int playerCount = ReInput.players.allPlayerCount;
            for (int i = 0; i < playerCount; i++) {
                Player player = ReInput.players.AllPlayers[i];
                foreach (var map in player.controllers.maps.GetAllMaps()) {
                    foreach (var aem in map.AllMaps) {
                        if (aem.id == uid) return aem;
                    }
                }
            }
            return null;
        }
    }

    public abstract class RewiredActionElementMapGetIntFsmStateAction : RewiredActionElementMapFsmStateAction {

        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a int variable.")]
        public FsmInt storeValue;

        [Tooltip("Event to send when the value changes.")]
        public FsmEvent valueChangedEvent;

        public override void Reset() {
            base.Reset();
            storeValue = null;
            valueChangedEvent = null;
        }

        protected void UpdateStoreValue(int newValue) {
            if (newValue != storeValue.Value) { // value changed
                // Store new value
                storeValue.Value = newValue;
                TrySendEvent(valueChangedEvent); // send value changed event
            }
        }
    }

    public abstract class RewiredActionElementMapGetFloatFsmStateAction : RewiredActionElementMapFsmStateAction {

        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a float variable.")]
        public FsmFloat storeValue;

        [Tooltip("The comparison operation to perform.")]
        public CompareOperation compareOperation = CompareOperation.None;

        [Tooltip("The value to which to compare the returned value.")]
        public FsmFloat compareToValue;

        [Tooltip("Compare using the absolute values of the two operands.")]
        public FsmBool compareAbsValues;

        [Tooltip("Event to send when the result of comparison returns true.")]
        public FsmEvent isTrueEvent;

        [Tooltip("Event to send when the result of comparison returns false.")]
        public FsmEvent isFalseEvent;

        [Tooltip("Event to send when the value changes.")]
        public FsmEvent valueChangedEvent;

        public override void Reset() {
            base.Reset();
            storeValue = null;
            compareOperation = CompareOperation.None;
            compareToValue = 0f;
            compareAbsValues = false;
            isTrueEvent = null;
            isFalseEvent = null;
            valueChangedEvent = null;
        }

        protected void UpdateStoreValue(float newValue) {
            if (newValue != storeValue.Value) { // value changed
                // Store new value
                storeValue.Value = newValue;
                TrySendEvent(valueChangedEvent); // send value changed event
            }

            // Compare values
            if (compareOperation != CompareOperation.None) {
                bool result = Compare(newValue);
                if (result) {
                    // send true event
                    TrySendEvent(isTrueEvent);
                } else {
                    // send false event
                    TrySendEvent(isFalseEvent);
                }
            }
        }

        private bool Compare(float value) {
            if (compareOperation == CompareOperation.None) return true;

            float val1, val2;
            if (compareAbsValues.Value) {
                val1 = Mathf.Abs(value);
                val2 = Mathf.Abs(compareToValue.Value);
            } else {
                val1 = value;
                val2 = compareToValue.Value;
            }

            switch (compareOperation) {
                case CompareOperation.LessThan:
                    return val1 < val2;
                case CompareOperation.LessThanOrEqualTo:
                    return val1 <= val2;
                case CompareOperation.EqualTo:
                    return val1 == val2;
                case CompareOperation.NotEqualTo:
                    return val1 != val2;
                case CompareOperation.GreaterThanOrEqualTo:
                    return val1 >= val2;
                case CompareOperation.GreaterThan:
                    return val1 > val2;
            }

            return false;
        }
    }

    public abstract class RewiredActionElementMapGetBoolFsmStateAction : RewiredActionElementMapFsmStateAction {

        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a bool variable.")]
        public FsmBool storeValue;

        [Tooltip("Event to send when bool value is true.")]
        public FsmEvent isTrueEvent;

        [Tooltip("Event to send when bool value is false.")]
        public FsmEvent isFalseEvent;

        [Tooltip("Event to send when the value changes.")]
        public FsmEvent valueChangedEvent;

        public override void Reset() {
            base.Reset();
            storeValue = null;
            isTrueEvent = null;
            isFalseEvent = null;
            valueChangedEvent = null;
        }

        protected void UpdateStoreValue(bool newValue) {
            if (newValue != storeValue.Value) { // value changed
                // Store new value
                storeValue.Value = newValue;
                TrySendEvent(valueChangedEvent); // send value changed event
            }

            // Send true event
            if (newValue) {
                TrySendEvent(isTrueEvent);
            } else {
                TrySendEvent(isFalseEvent);
            }
        }
    }

    public abstract class RewiredActionElementMapGetStringFsmStateAction : RewiredActionElementMapFsmStateAction {

        [RequiredField, UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a string variable.")]
        public FsmString storeValue;

        public override void Reset() {
            base.Reset();
            storeValue = null;
        }

        protected void UpdateStoreValue(string newValue) {
            if (newValue != storeValue.Value) { // value changed
                // Store new value
                storeValue.Value = newValue;
            }
        }
    }

    public abstract class RewiredActionElementMapSetBoolFsmStateAction : RewiredActionElementMapFsmStateAction {

        [Tooltip("The value to set.")]
        public FsmBool value;

        public override void Reset() {
            base.Reset();
            value = false;
        }
    }

    public abstract class RewiredActionElementMapSetIntFsmStateAction : RewiredActionElementMapFsmStateAction {

        [Tooltip("The value to set.")]
        public FsmInt value;

        public override void Reset() {
            base.Reset();
            value = 0;
        }
    }

    #endregion

    #region Enums

    public enum CompareOperation {
        None = 0,
        LessThan = 1,
        LessThanOrEqualTo = 2,
        EqualTo = 3,
        NotEqualTo = 4,
        GreaterThanOrEqualTo = 5,
        GreaterThan = 6
    }

    public enum ControllerTemplateType {
        Gamepad = 0,
        RacingWheel = 1,
        HOTAS = 2,
        FlightYoke = 3,
        FlightPedals = 4,
        SixDofController = 5,
    }

    #endregion
}