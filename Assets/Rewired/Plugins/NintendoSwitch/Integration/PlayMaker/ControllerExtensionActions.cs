using UnityEngine;
using System.Collections.Generic;

namespace Rewired.Integration.PlayMaker.NintendoSwitch {

    using HutongGames.PlayMaker;
    using HutongGames.PlayMaker.Actions;
    using HutongGames.Extensions;
    using HutongGames.Utility;
    using System;
    using Rewired.Platforms.Switch;

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Determines if a Joystick implements a particular Switch Controller Extension type.")]
    public class RewiredSwitchJoystickImplementsExtension : RewiredJoystickGetBoolFsmStateAction {

        [Tooltip("The Controller Extension type.")]
        [ObjectType(typeof(Rewired.Integration.PlayMaker.NintendoSwitch.SwitchControllerExtensionType))]
        public FsmEnum extensionType;

        protected override bool defaultValue_everyFrame { get { return false; } }

        public override void Reset() {
            base.Reset();
        }

        protected override void DoUpdate() {
            if(!HasJoystick) return;
            Controller.Extension extension = Tools.GetControllerExtension(this.Joystick, (Rewired.Integration.PlayMaker.NintendoSwitch.SwitchControllerExtensionType)extensionType.Value);
            UpdateStoreValue(extension != null);
        }
    }

    #region SwitchGamepadExtension

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Gets the number of sub devices that makes up this device. This is used for compound devices such as Dual Joy-Con Gamepad.")]
    public class RewiredSwitchGamepadExtensionGetSubDeviceCount : RewiredJoystickExtensionGetIntFsmStateAction<SwitchGamepadExtension> {
        
        public override void Reset() {
            base.Reset();
        }

        protected override void DoUpdate() {
            if(!HasExtension) return;
            UpdateStoreValue(Extension.subDeviceCount);
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Gets the Npad Id of the controller. This is useful if you need to interact directly with the Nintendo SDK.")]
    public class RewiredSwitchGamepadExtensionGetNpadId : RewiredJoystickExtensionGetEnumFsmStateAction<SwitchGamepadExtension> {

        [RequiredField, UIHint(UIHint.Variable), ObjectType(typeof(NpadId))]
        [Tooltip("The enum value to store.")]
        public FsmEnum storeValue;

        protected override FsmEnum _storeValue { get { return storeValue; } set { storeValue = value; } }

        public override void Reset() {
            base.Reset();
            storeValue = NpadId.No1;
        }

        protected override void DoUpdate() {
            if(!HasExtension) return;
            UpdateStoreValue(Extension.npadId);
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Gets the Npad Style of the controller. This is useful if you need to interact directly with the Nintendo SDK.")]
    public class RewiredSwitchGamepadExtensionGetNpadStyle : RewiredJoystickExtensionGetEnumFsmStateAction<SwitchGamepadExtension> {

        [RequiredField, UIHint(UIHint.Variable), ObjectType(typeof(NpadStyle))]
        [Tooltip("The enum value to store.")]
        public FsmEnum storeValue;

        protected override FsmEnum _storeValue { get { return storeValue; } set { storeValue = value; } }

        public override void Reset() {
            base.Reset();
            storeValue = NpadStyle.None;
        }

        protected override void DoUpdate() {
            if(!HasExtension) return;
            UpdateStoreValue(Extension.npadStyle);
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Disconnects the controller.")]
    public class RewiredSwitchGamepadExtensionDisconnect : RewiredJoystickExtensionFsmStateAction<SwitchGamepadExtension> {

        protected override void DoUpdate() {
            if(!HasExtension) return;
            Extension.Disconnect();
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Is the controller or sub-device connected?")]
    public class RewiredSwitchGamepadExtensionGetIsConnected : RewiredJoystickExtensionGetBoolFsmStateAction<SwitchGamepadExtension> {

        [Tooltip("Check for a sub-device by index. If false, checks he controller itself.")]
        public FsmBool checkSubDevice;

        [Tooltip("The index of the sub device. This is used for compound devices such as Dual Joy-Con Gamepad. Check subDeviceCount to determine the number of sub devices in this device.")]
        public FsmInt subDeviceIndex;

        public override void Reset() {
            base.Reset();
            checkSubDevice = false;
            subDeviceIndex = 0;
        }

        protected override void DoUpdate() {
            if(!HasExtension) return;
            bool result = checkSubDevice.Value ? Extension.IsConnected(subDeviceIndex.Value) : Extension.IsConnected();
            UpdateStoreValue(result);
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Is the controller or sub-device connected by wire?")]
    public class RewiredSwitchGamepadExtensionGetIsWired : RewiredJoystickExtensionGetBoolFsmStateAction<SwitchGamepadExtension> {

        [Tooltip("Check for a sub-device by index. If false, checks the controller itself.")]
        public FsmBool checkSubDevice;

        [Tooltip("The index of the sub device. This is used for compound devices such as Dual Joy-Con Gamepad. Check subDeviceCount to determine the number of sub devices in this device.")]
        public FsmInt subDeviceIndex;

        public override void Reset() {
            base.Reset();
            checkSubDevice = false;
            subDeviceIndex = 0;
        }

        protected override void DoUpdate() {
            if(!HasExtension) return;
            bool result = checkSubDevice.Value ? Extension.IsWired(subDeviceIndex.Value) : Extension.IsWired();
            UpdateStoreValue(result);
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Gets the player lights on the controller.")]
    public class RewiredSwitchGamepadExtensionGetPlayerLightPattern : RewiredJoystickExtensionFsmStateAction<SwitchGamepadExtension> {

        [UIHint(UIHint.Variable)]
        [Tooltip("Whether the first light is on.")]
        public FsmBool light1IsOn;

        [UIHint(UIHint.Variable)]
        [Tooltip("Whether the second light is on.")]
        public FsmBool light2IsOn;

        [UIHint(UIHint.Variable)]
        [Tooltip("Whether the third light is on.")]
        public FsmBool light3IsOn;

        [UIHint(UIHint.Variable)]
        [Tooltip("Whether the fourth light is on.")]
        public FsmBool light4IsOn;

        [Tooltip("The value to store.")]
        [UIHint(UIHint.Variable), ObjectType(typeof(GamepadPlayerLight))]
        public FsmEnum storeValue;

        [Tooltip("Event to send when the value changes.")]
        public FsmEvent valueChangedEvent;

        public override void Reset() {
            base.Reset();
            light1IsOn = false;
            light2IsOn = false;
            light3IsOn = false;
            light4IsOn = false;
            storeValue = GamepadPlayerLight.None;
            valueChangedEvent = null;
        }

        protected override void DoUpdate() {
            if(!HasExtension) return;
            GamepadPlayerLight lights = Extension.GetPlayerLightPattern();
            storeValue.Value = lights;
            bool light1 = (lights & GamepadPlayerLight.Light1) != 0;
            bool light2 = (lights & GamepadPlayerLight.Light2) != 0;
            bool light3 = (lights & GamepadPlayerLight.Light3) != 0;
            bool light4 = (lights & GamepadPlayerLight.Light4) != 0;
            bool changed = false;
            if(light1IsOn.Value != light1) changed = true;
            if(light2IsOn.Value != light2) changed = true;
            if(light3IsOn.Value != light3) changed = true;
            if(light4IsOn.Value != light4) changed = true;
            light1IsOn.Value = light1;
            light2IsOn.Value = light2;
            light3IsOn.Value = light3;
            light4IsOn.Value = light4;
            if(changed) TrySendEvent(valueChangedEvent); // send value changed event
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Gets the current Joy-Con assignment mode.")]
    public class RewiredSwitchGamepadExtensionGetJoyConAssignmentMode : RewiredJoystickExtensionGetEnumFsmStateAction<SwitchGamepadExtension> {

        [RequiredField, UIHint(UIHint.Variable), ObjectType(typeof(JoyConAssignmentMode))]
        [Tooltip("The enum value to store.")]
        public FsmEnum storeValue;

        protected override FsmEnum _storeValue { get { return storeValue; } set { storeValue = value; } }

        public override void Reset() {
            base.Reset();
            storeValue = JoyConAssignmentMode.Dual;
        }

        protected override void DoUpdate() {
            if(!HasExtension) return;
            UpdateStoreValue(Extension.GetJoyConAssignmentMode());
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Changes the Joy-Con assignment mode. If called on a Single Joy-Con, it will be set to Dual mode and then next attached Joy-Con will be paired with it. " +
        "If called on a Dual Joy-Con, the left Joy-Con will remain connected to the same npadId while the right will be reassigned by the system.")]
    public class RewiredSwitchGamepadExtensionSetJoyConAssignmentMode : RewiredJoystickExtensionSetEnumFsmStateAction<SwitchGamepadExtension> {

        [RequiredField, ObjectType(typeof(JoyConAssignmentMode))]
        [Tooltip("The value to set.")]
        public FsmEnum value;

        protected override FsmEnum _value { get { return value; } set { this.value = value; } }

        protected override void DoUpdate() {
            if(!HasExtension) return;
            Extension.SetJoyConAssignmentMode((JoyConAssignmentMode)value.Value);
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Is the controller color available from the controller or a or sub-device of the controller?")]
    public class RewiredSwitchGamepadExtensionGetIsColorAvailable : RewiredJoystickExtensionGetBoolFsmStateAction<SwitchGamepadExtension> {

        [Tooltip("Check for a sub-device by index. If false, checks the controller itself.")]
        public FsmBool checkSubDevice;

        [Tooltip("The index of the sub device. This is used for compound devices such as Dual Joy-Con Gamepad. Check subDeviceCount to determine the number of sub devices in this device.")]
        public FsmInt subDeviceIndex;

        public override void Reset() {
            base.Reset();
            checkSubDevice = false;
            subDeviceIndex = 0;
        }

        protected override void DoUpdate() {
            if(!HasExtension) return;
            bool result = checkSubDevice.Value ? Extension.IsColorAvailable(subDeviceIndex.Value) : Extension.IsColorAvailable();
            UpdateStoreValue(result);
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Gets the main color from the controller or a sub-device of the controller. You should check if color information is available first by checking the value of Is Color Available.")]
    public class RewiredSwitchGamepadExtensionGetMainColor : RewiredJoystickExtensionGetColorFsmStateAction<SwitchGamepadExtension> {

        [Tooltip("Check for a sub-device by index. If false, checks the controller itself.")]
        public FsmBool checkSubDevice;

        [Tooltip("The index of the sub device. This is used for compound devices such as Dual Joy-Con Gamepad. Check subDeviceCount to determine the number of sub devices in this device.")]
        public FsmInt subDeviceIndex;

        public override void Reset() {
            base.Reset();
            checkSubDevice = false;
            subDeviceIndex = 0;
        }

        protected override void DoUpdate() {
            if(!HasExtension) return;
            Color result = checkSubDevice.Value ? Extension.GetMainColor(subDeviceIndex.Value) : Extension.GetMainColor();
            UpdateStoreValue(result);
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Gets the sub color from the controller or a sub-device of the controller. You should check if color information is available first by checking the value of Is Color Available.")]
    public class RewiredSwitchGamepadExtensionGetSubColor : RewiredJoystickExtensionGetColorFsmStateAction<SwitchGamepadExtension> {

        [Tooltip("Check for a sub-device by index. If false, checks the controller itself.")]
        public FsmBool checkSubDevice;

        [Tooltip("The index of the sub device. This is used for compound devices such as Dual Joy-Con Gamepad. Check subDeviceCount to determine the number of sub devices in this device.")]
        public FsmInt subDeviceIndex;

        public override void Reset() {
            base.Reset();
            checkSubDevice = false;
            subDeviceIndex = 0;
        }

        protected override void DoUpdate() {
            if(!HasExtension) return;
            Color result = checkSubDevice.Value ? Extension.GetSubColor(subDeviceIndex.Value) : Extension.GetSubColor();
            UpdateStoreValue(result);
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Gets the number of vibration motors.")]
    public class RewiredSwitchGamepadExtensionGetVibrationMotorCount : RewiredJoystickExtensionGetIntFsmStateAction<SwitchGamepadExtension> {
        protected override void DoUpdate() {
            if(!HasExtension) return;
            UpdateStoreValue(Extension.vibrationMotorCount);
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Gets the current vibration value from the controller.")]
    public class RewiredSwitchGamepadExtensionGetVibration : RewiredJoystickExtensionFsmStateAction<SwitchGamepadExtension> {

        [Tooltip("The index of the vibration motor.")]
        [RequiredField]
        public FsmInt motorIndex;

        [Tooltip("The high bandwidth amplitude [0.0 - 1.0]")]
        [UIHint(UIHint.Variable)]
        [HasFloatSlider(0f, 1f)]
        public FsmFloat amplitudeHigh;

        [Tooltip("The low bandwidth amplitude [0.0 - 1.0]")]
        [UIHint(UIHint.Variable)]
        [HasFloatSlider(0f, 1f)]
        public FsmFloat amplitudeLow;
        
        [Tooltip("The high bandwidth frequency in Hertz.")]
        [UIHint(UIHint.Variable)]
        public FsmFloat frequencyHigh;
        
        [Tooltip("The low bandwidth frequency in Hertz.")]
        [UIHint(UIHint.Variable)]
        public FsmFloat frequencyLow;

        [Tooltip("Event to send when the value changes.")]
        public FsmEvent valueChangedEvent;
        
        public override void Reset() {
            base.Reset();
            motorIndex = 0;
            SwitchVibration vib = SwitchVibration.Create(); // get default values
            amplitudeHigh = vib.amplitudeHigh;
            amplitudeLow = vib.amplitudeLow;
            frequencyHigh = vib.frequencyHigh;
            frequencyLow = vib.frequencyLow;
            valueChangedEvent = null;
        }

        protected override void DoUpdate() {
            if(!HasExtension) return;
            SwitchVibration vib = Extension.GetVibration(motorIndex.Value);

            bool changed = false;
            
            if(vib.amplitudeHigh != amplitudeHigh.Value) {
                amplitudeHigh.Value = vib.amplitudeHigh;
                changed = true;
            }
            if(vib.amplitudeLow != amplitudeLow.Value) {
                amplitudeLow.Value = vib.amplitudeLow;
                changed = true;
            }
            if(vib.frequencyHigh != frequencyHigh.Value) {
                frequencyHigh.Value = vib.frequencyHigh;
                changed = true;
            }
            if(vib.frequencyLow != frequencyLow.Value) {
                frequencyLow.Value = vib.frequencyLow;
                changed = true;
            }

            if(changed) { // value changed
                TrySendEvent(valueChangedEvent); // send value changed event
            }
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Sets vibration in the controller.")]
    public class RewiredSwitchGamepadExtensionSetVibration : RewiredJoystickExtensionFsmStateAction<SwitchGamepadExtension> {

        [Tooltip("The index of the vibration motor.")]
        [RequiredField]
        public FsmInt motorIndex;

        [Tooltip("Stop other motors?")]
        public FsmBool stopOtherMotors;

        [Tooltip("Length of time in seconds to activate the motor before it stops. [0 = Infinite]")]
        public FsmFloat duration;

        [Tooltip("The high bandwidth amplitude [0.0 - 1.0]")]
        [HasFloatSlider(0f, 1f)]
        public FsmFloat amplitudeHigh;

        [Tooltip("The low bandwidth amplitude [0.0 - 1.0]")]
        [HasFloatSlider(0f, 1f)]
        public FsmFloat amplitudeLow;

        [Tooltip("The high bandwidth frequency in Hertz.")]
        public FsmFloat frequencyHigh;

        [Tooltip("The low bandwidth frequency in Hertz.")]
        public FsmFloat frequencyLow;

        public override void Reset() {
            base.Reset();
            motorIndex = 0;
            stopOtherMotors = false;
            duration = 0;
            SwitchVibration vib = SwitchVibration.Create(); // get default values
            amplitudeHigh = vib.amplitudeHigh;
            amplitudeLow = vib.amplitudeLow;
            frequencyHigh = vib.frequencyHigh;
            frequencyLow = vib.frequencyLow;
        }

        protected override void DoUpdate() {
            if(!HasExtension) return;
            Extension.SetVibration(
                motorIndex.Value,
                amplitudeLow.Value,
                frequencyLow.Value,
                amplitudeHigh.Value,
                frequencyHigh.Value,
                duration.Value,
                stopOtherMotors.Value
            );
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Plays back a vibration file through the controller's vibration motor.")]
    public class RewiredSwitchGamepadExtensionSetVibrationFile : RewiredJoystickExtensionFsmStateAction<SwitchGamepadExtension> {

        [Tooltip("The index of the vibration motor.")]
        [RequiredField]
        public FsmInt motorIndex;

        [Tooltip("Stop other motors?")]
        public FsmBool stopOtherMotors;

        [Tooltip("Vibration file in BNVIB format.")]
        [ObjectType(typeof(TextAsset))]
        public FsmObject vibrationFile;

        public override void Reset() {
            base.Reset();
            motorIndex = 0;
            stopOtherMotors = false;
            vibrationFile = null;
        }

        protected override void DoUpdate() {
            if(!HasExtension) return;
            TextAsset textAsset = vibrationFile.Value as TextAsset;
            if(textAsset == null) return;
            Extension.SetVibration(
                motorIndex.Value,
                textAsset.bytes
            );
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("The number of six-axis sensors in the controller.")]
    public class RewiredSwitchGamepadExtensionGetIMUCount : RewiredJoystickExtensionGetIntFsmStateAction<SwitchGamepadExtension> {
        protected override void DoUpdate() {
            if(!HasExtension) return;
            UpdateStoreValue(Extension.imuCount);
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("The number of six-axis sensor states received since the previous frame available for reading. " +
        "If no new states were received since the last frame, the sensor state count will be 0.")]
    public class RewiredSwitchGamepadExtensionGetIMUStateCount : RewiredJoystickExtensionGetIntFsmStateAction<SwitchGamepadExtension> {

        [Tooltip("The index of the six-axis sensor.")]
        [RequiredField]
        public FsmInt sensorIndex;

        public override void Reset() {
            base.Reset();
            sensorIndex = 0;
        }

        protected override void DoUpdate() {
            if(!HasExtension) return;
            UpdateStoreValue(Extension.GetIMUStateCount(sensorIndex.Value));
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Gets the six-axis sensor state at a particular index from the queue of sensor states received since the previous frame. " +
        "Check Get IMU State Count to determine how many sensor states are available. " +
        "The queue is ordered newest to oldest with the state at index 0 being the most current.")]
    public class RewiredSwitchGamepadExtensionGetIMUState : RewiredJoystickExtensionFsmStateAction<SwitchGamepadExtension> {

        [Tooltip("The index of the six-axis sensor.")]
        [RequiredField]
        public FsmInt sensorIndex;

        [Tooltip("The index of the six-axis sensor state to retrieve.")]
        [RequiredField]
        public FsmInt stateIndex;

        [Tooltip(" The acceleration vector in units of G force.  The value has been converted to Unity's coordinate system.")]
        public FsmVector3 acceleration;
        
        [Tooltip("The acceleration vector in units of G force as reported by the sensor. The value has not been converted to Unity's coordinate system.")]
        public FsmVector3 accelerationRaw;
        
        [Tooltip("The angular velocity. (1.0 = 360 dps) The value has been converted to Unity's coordinate system.")]
        public FsmVector3 angularVelocity;
        
        [Tooltip("The angular velocity as reported by the sensor. (1.0 = 360 dps) The value has not been converted to Unity's coordinate system.")]
        public FsmVector3 angularVelocityRaw;
        
        [Tooltip("Attributes of the sensor state.")]
        [ObjectType(typeof(SwitchIMUAttribute))]
        public FsmEnum attributes;

        [Tooltip("Is the sensor is connected?")]
        public FsmBool attributeIsConnected;

        [Tooltip("Is the sensor is interpolated?")]
        public FsmBool attributeIsInterpolated;
        
        [Tooltip("The time elapsed between the previous sensor sampling and the current. NOTE: The actual data type is a 64-bit long. This is represented as a string due to the lack of a FsmLong data type.")]
        public FsmString deltaTimeString;

        [Tooltip("The orientation of the sensor.  The value has been converted to Unity's coordinate system.")]
        public FsmQuaternion orientation;
        
        [Tooltip("The orientation as reported by the sensor. The value has not been converted to Unity's coordinate system.")]
        public FsmQuaternion orientationRaw;
        
        [Tooltip("The angle of rotation around each axis. The value has been converted to Unity's coordinate system.")]
        public FsmVector3 rotationAngle;
        
        [Tooltip("The angle of rotation around each axis as reported by the sensor. The value has not been converted to Unity's coordinate system.")]
        public FsmVector3 rotationAngleRaw;

        [Tooltip("A counter that increases each time the sensor is sampled. NOTE: The actual data type is a 64-bit long. This is represented as a string due to the lack of a FsmLong data type.")]
        public FsmString samplingNumberString;

        public override void Reset() {
            base.Reset();
            sensorIndex = 0;
            stateIndex = 0;
            acceleration = Vector3.zero;
            accelerationRaw = Vector3.zero;
            angularVelocity = Vector3.zero;
            angularVelocityRaw = Vector3.zero;
            attributes = (SwitchIMUAttribute)0;
            attributeIsConnected = false;
            attributeIsInterpolated = false;
            deltaTimeString = "0";
            orientation = Quaternion.identity;
            orientationRaw = Quaternion.identity;
            rotationAngle = Vector3.zero;
            rotationAngleRaw = Vector3.zero;
            samplingNumberString = "0";
        }

        protected override void DoUpdate() {
            if(!HasExtension) return;
            SwitchIMUState state = Extension.GetIMUState(sensorIndex.Value, stateIndex.Value);
            acceleration.Value = state.acceleration;
            accelerationRaw.Value = state.accelerationRaw;
            angularVelocity.Value = state.angularVelocity;
            angularVelocityRaw.Value = state.angularVelocityRaw;
            attributes.Value = state.attributes;
            attributeIsConnected.Value = (state.attributes & SwitchIMUAttribute.IsConnected) != 0;
            attributeIsInterpolated.Value = (state.attributes & SwitchIMUAttribute.IsInterpolated) != 0;
            deltaTimeString.Value = state.deltaTime.ToString();
            orientation.Value = state.orientation;
            orientationRaw.Value = state.orientationRaw;
            rotationAngle.Value = state.rotationAngle;
            rotationAngleRaw.Value = state.rotationAngleRaw;
            samplingNumberString = state.samplingNumber.ToString();
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Gets the current orientation.")]
    public class RewiredSwitchGamepadExtensionGetOrientation : RewiredJoystickExtensionGetQuaternionFsmStateAction<SwitchGamepadExtension> {

        [Tooltip("If enabled, the first available sensor value will be returned. If false, Sensor Index must be set.")]
        public FsmBool useFirstAvailableSensor;

        [Tooltip("The index of the six-axis sensor.")]
        public FsmInt sensorIndex;

        [Tooltip("If enabled, the raw orientation will be retrieved. The raw value is not converted to Unity's coordinate system.")]
        public FsmBool getRawValue;

        public override void Reset() {
            base.Reset();
            useFirstAvailableSensor = true;
            sensorIndex = 0;
            getRawValue = false;
        }

        protected override void DoUpdate() {
            if(!HasExtension) return;
            Quaternion value;
            if(getRawValue.Value) {
                if(useFirstAvailableSensor.Value) value = Extension.GetOrientationRaw();
                else value = Extension.GetOrientationRaw(sensorIndex.Value);
            } else {
                if(useFirstAvailableSensor.Value) value = Extension.GetOrientation();
                else value = Extension.GetOrientation(sensorIndex.Value);
            }
            UpdateStoreValue(value);
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Gets the current acceleration vector in units of G force.")]
    public class RewiredSwitchGamepadExtensionGetAcceleration : RewiredJoystickExtensionGetVector3FsmStateAction<SwitchGamepadExtension> {

        [Tooltip("If enabled, the first available sensor value will be returned. If false, Sensor Index must be set.")]
        public FsmBool useFirstAvailableSensor;

        [Tooltip("The index of the six-axis sensor.")]
        public FsmInt sensorIndex;

        [Tooltip("If enabled, the raw acceleration will be retrieved. The raw value is not converted to Unity's coordinate system.")]
        public FsmBool getRawValue;

        public override void Reset() {
            base.Reset();
            useFirstAvailableSensor = true;
            sensorIndex = 0;
            getRawValue = false;
        }

        protected override void DoUpdate() {
            if(!HasExtension) return;
            Vector3 value;
            if(getRawValue.Value) {
                if(useFirstAvailableSensor.Value) value = Extension.GetAccelerationRaw();
                else value = Extension.GetAccelerationRaw(sensorIndex.Value);
            } else {
                if(useFirstAvailableSensor.Value) value = Extension.GetAcceleration();
                else value = Extension.GetAcceleration(sensorIndex.Value);
            }
            UpdateStoreValue(value);
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Gets the current angular velocity. (1.0 = 360 dps)")]
    public class RewiredSwitchGamepadExtensionGetAngularVelocity : RewiredJoystickExtensionGetVector3FsmStateAction<SwitchGamepadExtension> {

        [Tooltip("If enabled, the first available sensor value will be returned. If false, Sensor Index must be set.")]
        public FsmBool useFirstAvailableSensor;

        [Tooltip("The index of the six-axis sensor.")]
        public FsmInt sensorIndex;

        [Tooltip("If enabled, the raw angular velocity will be retrieved. The raw value is not converted to Unity's coordinate system.")]
        public FsmBool getRawValue;

        public override void Reset() {
            base.Reset();
            useFirstAvailableSensor = true;
            sensorIndex = 0;
            getRawValue = false;
        }

        protected override void DoUpdate() {
            if(!HasExtension) return;
            Vector3 value;
            if(getRawValue.Value) {
                if(useFirstAvailableSensor.Value) value = Extension.GetAngularVelocityRaw();
                else value = Extension.GetAngularVelocityRaw(sensorIndex.Value);
            } else {
                if(useFirstAvailableSensor.Value) value = Extension.GetAngularVelocity();
                else value = Extension.GetAngularVelocity(sensorIndex.Value);
            }
            UpdateStoreValue(value);
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Gets the current angle of rotation around each axis.")]
    public class RewiredSwitchGamepadExtensionGetRotationAngle : RewiredJoystickExtensionGetVector3FsmStateAction<SwitchGamepadExtension> {

        [Tooltip("If enabled, the first available sensor value will be returned. If false, Sensor Index must be set.")]
        public FsmBool useFirstAvailableSensor;

        [Tooltip("The index of the six-axis sensor.")]
        public FsmInt sensorIndex;

        [Tooltip("If enabled, the raw rotation angle will be retrieved. The raw value is not converted to Unity's coordinate system.")]
        public FsmBool getRawValue;

        public override void Reset() {
            base.Reset();
            useFirstAvailableSensor = true;
            sensorIndex = 0;
            getRawValue = false;
        }

        protected override void DoUpdate() {
            if(!HasExtension) return;
            Vector3 value;
            if(getRawValue.Value) {
                if(useFirstAvailableSensor.Value) value = Extension.GetRotationAngleRaw();
                else value = Extension.GetRotationAngleRaw(sensorIndex.Value);
            } else {
                if(useFirstAvailableSensor.Value) value = Extension.GetRotationAngle();
                else value = Extension.GetRotationAngle(sensorIndex.Value);
            }
            UpdateStoreValue(value);
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Stops sampling sensors. No data will be returned when a sensor is stopped.")]
    public class RewiredSwitchGamepadExtensionStopIMU : RewiredJoystickExtensionFsmStateAction<SwitchGamepadExtension> {

        [Tooltip("If enabled, all sensors will be stopped. Otherwise, use Sensor Index to determine which sensor to stop.")]
        public FsmBool useAllSensors;

        [Tooltip("The index of the six-axis sensor.")]
        public FsmInt sensorIndex;

        public override void Reset() {
            base.Reset();
            useAllSensors = true;
            sensorIndex = 0;
        }

        protected override void DoUpdate() {
            if(!HasExtension) return;
            if(useAllSensors.Value) {
                Extension.StopIMU();
            } else {
                Extension.StopIMU(sensorIndex.Value);
            }
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Starts sampling the sensor. Data will be returned when the sensor is started. " + 
        "SDK documentation states that calling this function will set the base attitude of the sensor.")]
    public class RewiredSwitchGamepadExtensionStartIMU : RewiredJoystickExtensionFsmStateAction<SwitchGamepadExtension> {

        [Tooltip("If enabled, all sensors will be started. Otherwise, use Sensor Index to determine which sensor to start.")]
        public FsmBool useAllSensors;

        [Tooltip("The index of the six-axis sensor.")]
        public FsmInt sensorIndex;

        public override void Reset() {
            base.Reset();
            useAllSensors = true;
            sensorIndex = 0;
        }

        protected override void DoUpdate() {
            if(!HasExtension) return;
            if(useAllSensors.Value) {
                Extension.StartIMU();
            } else {
                Extension.StartIMU(sensorIndex.Value);
            }
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Determines whether sensors are at rest or moving. " +
        "Refer to the Nintendo SDK documentation on nn::hid::IsIMUAtRest for important requirements.")]
    public class RewiredSwitchGamepadExtensionIsIMUAtRest : RewiredJoystickExtensionGetBoolFsmStateAction<SwitchGamepadExtension> {

        [Tooltip("If enabled, this action will return true only if all sensors are at rest. Otherwise, use Sensor Index to monitor the state of a single sensor.")]
        public FsmBool useAllSensors;

        [Tooltip("The index of the six-axis sensor.")]
        public FsmInt sensorIndex;

        public override void Reset() {
            base.Reset();
            useAllSensors = true;
            sensorIndex = 0;
        }

        protected override void DoUpdate() {
            if(!HasExtension) return;
            if(useAllSensors.Value) {
                UpdateStoreValue(Extension.IsIMUAtRest());
            } else {
                UpdateStoreValue(Extension.IsIMUAtRest(sensorIndex.Value));
            }
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Gets the attitude correction state of the six-axis sensor.")]
    public class RewiredSwitchGamepadExtensionGetIMUSensorFusionEnabled : RewiredJoystickExtensionGetBoolFsmStateAction<SwitchGamepadExtension> {

        [Tooltip("The index of the six-axis sensor.")]
        public FsmInt sensorIndex;

        public override void Reset() {
            base.Reset();
            sensorIndex = 0;
        }

        protected override void DoUpdate() {
            if(!HasExtension) return;
            UpdateStoreValue(Extension.GetIMUSensorFusionEnabled(sensorIndex.Value));
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Sets the attitude correction state of the six-axis sensor(s).")]
    public class RewiredSwitchGamepadExtensionSetIMUSensorFusionEnabled : RewiredJoystickExtensionSetBoolFsmStateAction<SwitchGamepadExtension> {

        [Tooltip("If enabled, sets the gyroscope zero point correction mode of all sensors. Otherwise, use Sensor Index to set the value for a single sensor.")]
        public FsmBool useAllSensors;

        [Tooltip("The index of the six-axis sensor.")]
        public FsmInt sensorIndex;

        public override void Reset() {
            base.Reset();
            useAllSensors = true;
            sensorIndex = 0;
        }

        protected override void DoUpdate() {
            if(!HasExtension) return;
            if(useAllSensors.Value) {
                Extension.SetIMUSensorFusionEnabled(value.Value);
            } else {
                Extension.SetIMUSensorFusionEnabled(sensorIndex.Value, value.Value);
            }
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Gets the gyroscope zero point correction mode of the sensor.")]
    public class RewiredSwitchGamepadExtensionGetGyroscopeZeroDriftMode : RewiredJoystickExtensionGetEnumFsmStateAction<SwitchGamepadExtension> {

        [Tooltip("The value to store.")]
        [RequiredField, UIHint(UIHint.Variable), ObjectType(typeof(GyroscopeZeroDriftMode))]
        public FsmEnum storeValue;

        [Tooltip("The index of the six-axis sensor.")]
        public FsmInt sensorIndex;

        protected override FsmEnum _storeValue { get { return storeValue; } set { storeValue = value; } }

        public override void Reset() {
            base.Reset();
            sensorIndex = 0;
            storeValue = GyroscopeZeroDriftMode.Standard;
        }

        protected override void DoUpdate() {
            if(!HasExtension) return;
            UpdateStoreValue(Extension.GetGyroscopeZeroDriftMode(sensorIndex.Value));
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Sets the gyroscope zero point correction mode of the sensor(s).")]
    public class RewiredSwitchGamepadExtensionSetGyroscopeZeroDriftMode : RewiredJoystickExtensionSetEnumFsmStateAction<SwitchGamepadExtension> {

        [Tooltip("If enabled, sets the gyroscope zero point correction mode of all sensors. Otherwise, use Sensor Index to set the value for a single sensor.")]
        public FsmBool useAllSensors;

        [Tooltip("The index of the six-axis sensor.")]
        public FsmInt sensorIndex;

        [Tooltip("The value to set.")]
        [RequiredField, ObjectType(typeof(GyroscopeZeroDriftMode))]
        public FsmEnum value;

        protected override FsmEnum _value { get { return value; } set { this.value = value; } }

        public override void Reset() {
            base.Reset();
            useAllSensors = true;
            sensorIndex = 0;
            value = GyroscopeZeroDriftMode.Standard;
        }

        protected override void DoUpdate() {
            if(!HasExtension) return;
            if(useAllSensors.Value) {
                Extension.SetGyroscopeZeroDriftMode((GyroscopeZeroDriftMode)value.Value);
            } else {
                Extension.SetGyroscopeZeroDriftMode(sensorIndex.Value, (GyroscopeZeroDriftMode)value.Value);
            }
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Gets the sensor fusion options of the sensor.")]
    public class RewiredSwitchGamepadExtensionGetIMUSensorFusionOptions : RewiredJoystickExtensionFsmStateAction<SwitchGamepadExtension> {

        [Tooltip("The index of the six-axis sensor.")]
        public FsmInt sensorIndex;

        [Tooltip("Weight of acceleration correction. The greater the value, the more strongly correction is applied.")]
        [UIHint(UIHint.Variable)]
        public FsmFloat power;

        [Tooltip("Valid range for acceleration correction.  Correction calculations use the accelerometer values in this range, which is centered around gravitational " +
            "acceleration (1.0f).  For example, if 0.4f is specified, accelerometer values in the range from 0.6f to 1.4f are used in the correction calculation.")]
        [UIHint(UIHint.Variable)]
        public FsmFloat range;

        [Tooltip("Event to send when the value changes.")]
        public FsmEvent valueChangedEvent;

        public override void Reset() {
            base.Reset();
            sensorIndex = 0;
            power = 0f;
            range = 0f;
            valueChangedEvent = null;
        }

        protected override void DoUpdate() {
            if(!HasExtension) return;

            SwitchIMUSensorFusionOptions options = Extension.GetIMUSensorFusionOptions(sensorIndex.Value);
            bool changed = false;

            if(options.power != power.Value) {
                power.Value = options.power;
                changed = true;
            }
            if(options.range != range.Value) {
                range.Value = options.range;
                changed = true;
            }

            if(changed) { // value changed
                TrySendEvent(valueChangedEvent); // send value changed event
            }
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Sets the sensor fusion options of the sensor(s).")]
    public class RewiredSwitchGamepadExtensionSetIMUSensorFusionOptions : RewiredJoystickExtensionFsmStateAction<SwitchGamepadExtension> {

        [Tooltip("If enabled, sets the gyroscope zero point correction mode of all sensors. Otherwise, use Sensor Index to set the value for a single sensor.")]
        public FsmBool useAllSensors;

        [Tooltip("The index of the six-axis sensor.")]
        public FsmInt sensorIndex;

        [Tooltip("Weight of acceleration correction. The greater the value, the more strongly correction is applied.")]
        public FsmFloat power;

        [Tooltip("Valid range for acceleration correction.  Correction calculations use the accelerometer values in this range, which is centered around gravitational " +
            "acceleration (1.0f).  For example, if 0.4f is specified, accelerometer values in the range from 0.6f to 1.4f are used in the correction calculation.")]
        public FsmFloat range;

        public override void Reset() {
            base.Reset();
            useAllSensors = true;
            sensorIndex = 0;
            power = 0f;
            range = 0f;
        }

        protected override void DoUpdate() {
            if(!HasExtension) return;

            SwitchIMUSensorFusionOptions options = new SwitchIMUSensorFusionOptions();
            options.power = power.Value;
            options.range = range.Value;

            if(useAllSensors.Value) {
                Extension.SetIMUSensorFusionOptions(options);
            } else {
                Extension.SetIMUSensorFusionOptions(sensorIndex.Value, options);
            }
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Resets the sensor fusion options of the sensor(s) to the default values.")]
    public class RewiredSwitchGamepadExtensionResetIMUSensorFusionOptions : RewiredJoystickExtensionFsmStateAction<SwitchGamepadExtension> {

        [Tooltip("If enabled, sensor fusion options for all sensors will be reset. Otherwise, use Sensor Index to determine which sensor to reset.")]
        public FsmBool useAllSensors;

        [Tooltip("The index of the six-axis sensor.")]
        public FsmInt sensorIndex;

        public override void Reset() {
            base.Reset();
            useAllSensors = true;
            sensorIndex = 0;
        }

        protected override void DoUpdate() {
            if(!HasExtension) return;
            if(useAllSensors.Value) {
                Extension.ResetIMUSensorFusionOptions();
            } else {
                Extension.ResetIMUSensorFusionOptions(sensorIndex.Value);
            }
        }
    }

    #endregion

    #region JoyConExtension

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Gets the type of Joy-Con. This can be used to identify the Left or Right Joy-Con.")]
    public class RewiredSwitchGamepadExtensionGetJoyConType : RewiredJoystickExtensionGetEnumFsmStateAction<JoyConExtension> {

        [RequiredField, UIHint(UIHint.Variable), ObjectType(typeof(JoyConType))]
        [Tooltip("The enum value to store.")]
        public FsmEnum storeValue;

        protected override FsmEnum _storeValue { get { return storeValue; } set { storeValue = value; } }

        public override void Reset() {
            base.Reset();
            storeValue = JoyConType.Left;
        }

        protected override void DoUpdate() {
            if(!HasExtension) return;
            UpdateStoreValue(Extension.joyConType);
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Merges two Single Joy-Cons into one Dual Joy-Con. You must pass in a left or a right Joy-Con of " +
        "JoyConType depending on the JoyConType of this Joy-Con. Check the JoyConType with the joyConType property.")]
    public class RewiredSwitchJoyConExtensionMergeJoyCons : RewiredJoystickExtensionFsmStateAction<JoyConExtension> {

        [Tooltip("The Joystick id of the second Joy-Con.")]
        public FsmInt secondJoystickId;

        [Tooltip("Event to send when bool value is true.")]
        public FsmEvent isTrueEvent;

        [Tooltip("Event to send when bool value is false.")]
        public FsmEvent isFalseEvent;

        [UIHint(UIHint.Variable)]
        [Tooltip("Store the result in a bool variable.")]
        public FsmBool storeValue;

        public override void Reset() {
            base.Reset();
            secondJoystickId = 0;
            storeValue = null;
            isTrueEvent = null;
            isFalseEvent = null;
            storeValue = false;
        }

        protected override void DoUpdate() {
            if(!HasExtension) return;
            if(joystickId.Value == secondJoystickId.Value) {
                LogError("Joystick Id and Second Joystick Id cannot be the same value.");
                UpdateStoreValue(false);
                return;
            }

            Joystick second = ReInput.controllers.GetJoystick(secondJoystickId.Value);
            if(second == null) {
                LogError("No Joystick with Id " + secondJoystickId.Value + " was found.");
                UpdateStoreValue(false);
                return;
            }

            JoyConExtension secondExtension = second.GetExtension<JoyConExtension>();
            if(secondExtension == null) {
                LogError("The second joystick is not the right type.");
                UpdateStoreValue(false);
                return;
            }

            bool result = Extension.MergeJoyCons(secondExtension);
            if(!result) LogError("Failed to merge Joy-Cons.");
            UpdateStoreValue(result);
        }
        
        private void UpdateStoreValue(bool newValue) {
            if (newValue != storeValue.Value) { // value changed
                // Store new value
                storeValue.Value = newValue;
            }

            // Send true event
            if (newValue) {
                TrySendEvent(isTrueEvent);
            } else {
                TrySendEvent(isFalseEvent);
            }
        }
    }

    #endregion

    #region DualJoyConExtension

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Sub device index for the Left Joy-Con.")]
    public class RewiredSwitchDualJoyConExtensionGetSubDeviceIndexLeftJoyCon : GetIntFsmStateAction {
        protected override void DoUpdate() {
            UpdateStoreValue(DualJoyConExtension.subDeviceIndex_leftJoyCon);
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Sub device index for the Right Joy-Con.")]
    public class RewiredSwitchDualJoyConExtensionGetSubDeviceIndexRightJoyCon : GetIntFsmStateAction {
        protected override void DoUpdate() {
            UpdateStoreValue(DualJoyConExtension.subDeviceIndex_rightJoyCon);
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Is the left Joy-Con present?")]
    public class RewiredSwitchDualJoyConExtensionGetIsLeftJoyConConnected : RewiredJoystickExtensionGetBoolFsmStateAction<DualJoyConExtension> {
        protected override void DoUpdate() {
            if(!HasExtension) return;
            UpdateStoreValue(Extension.IsLeftJoyConConnected());
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Is the right Joy-Con present?")]
    public class RewiredSwitchDualJoyConExtensionGetIsRightJoyConConnected : RewiredJoystickExtensionGetBoolFsmStateAction<DualJoyConExtension> {
        protected override void DoUpdate() {
            if(!HasExtension) return;
            UpdateStoreValue(Extension.IsRightJoyConConnected());
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Is the left Joy-Con connected by wire?")]
    public class RewiredSwitchDualJoyConExtensionGetIsLeftJoyConWired : RewiredJoystickExtensionGetBoolFsmStateAction<DualJoyConExtension> {
        protected override void DoUpdate() {
            if(!HasExtension) return;
            UpdateStoreValue(Extension.IsLeftJoyConWired());
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Is the right Joy-Con connected by wire?")]
    public class RewiredSwitchDualJoyConExtensionGetIsRightJoyConWired : RewiredJoystickExtensionGetBoolFsmStateAction<DualJoyConExtension> {
        protected override void DoUpdate() {
            if(!HasExtension) return;
            UpdateStoreValue(Extension.IsRightJoyConWired());
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Sets the Joy-Con assignment mode to single.")]
    public class RewiredSwitchDualJoyConExtensionSetJoyConAssignmentModeToSingle : RewiredJoystickExtensionFsmStateAction<DualJoyConExtension> {

        [Tooltip("Which of the two Joy-Cons should remain connected and assigned to the same npadId?")]
        [ObjectType(typeof(JoyConType))]
        public FsmEnum joyConToKeepConnected;

        public override void Reset() {
            base.Reset();
            joyConToKeepConnected = JoyConType.Left;
        }

        protected override void DoUpdate() {
            if(!HasExtension) return;
            Extension.SetJoyConAssignmentModeToSingle((JoyConType)joyConToKeepConnected.Value);
        }
    }

    #endregion

    #region HandheldExtension

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Sub device index for the Left Joy-Con.")]
    public class RewiredSwitchHandheldExtensionGetSubDeviceIndexLeftJoyCon : GetIntFsmStateAction {
        protected override void DoUpdate() {
            UpdateStoreValue(HandheldExtension.subDeviceIndex_leftJoyCon);
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Sub device index for the Right Joy-Con.")]
    public class RewiredSwitchHandheldExtensionGetSubDeviceIndexRightJoyCon : GetIntFsmStateAction {
        protected override void DoUpdate() {
            UpdateStoreValue(HandheldExtension.subDeviceIndex_rightJoyCon);
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Is the left Joy-Con present?")]
    public class RewiredSwitchHandheldExtensionGetIsLeftJoyConConnected : RewiredJoystickExtensionGetBoolFsmStateAction<HandheldExtension> {
        protected override void DoUpdate() {
            if(!HasExtension) return;
            UpdateStoreValue(Extension.IsLeftJoyConConnected());
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Is the right Joy-Con present?")]
    public class RewiredSwitchHandheldExtensionGetIsRightJoyConConnected : RewiredJoystickExtensionGetBoolFsmStateAction<HandheldExtension> {
        protected override void DoUpdate() {
            if(!HasExtension) return;
            UpdateStoreValue(Extension.IsRightJoyConConnected());
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Is the left Joy-Con connected by wire?")]
    public class RewiredSwitchHandheldExtensionGetIsLeftJoyConWired : RewiredJoystickExtensionGetBoolFsmStateAction<HandheldExtension> {
        protected override void DoUpdate() {
            if(!HasExtension) return;
            UpdateStoreValue(Extension.IsLeftJoyConWired());
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Is the right Joy-Con connected by wire?")]
    public class RewiredSwitchHandheldExtensionGetIsRightJoyConWired : RewiredJoystickExtensionGetBoolFsmStateAction<HandheldExtension> {
        protected override void DoUpdate() {
            if(!HasExtension) return;
            UpdateStoreValue(Extension.IsRightJoyConWired());
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Gets the mode that activates the handheld style of operation. " +
        "There are two different conditional modes for activating the handheld style of operation. " +
        "<see HandheldActivationMode.Dual:  " +
        "In this mode, the handheld style of operation is enabled when both the left and right Joy-Con controllers are attached.  " +
        "This mode is set by default. " +
        "HandheldActivationMode.Single: " +
        "In this mode, the handheld style of operation is enabled when either just the left or right Joy-Con controller is attached. " +
        "When just one of the two controllers is attached to Switch, the input from the unattached controller is treated as no input (as if no digital buttons are being pressed and the analog stick is in the neutral position). The input state of the six-axis sensor is obtained from the actually attached Joy-Con. " +
        "The input from the unattached controller is treated as no input (as if no digital buttons are being pressed and the analog stick is in the neutral position). " +
        "The input state of the six-axis sensor is obtained from the actually attached Joy-Con.")]
    public class RewiredSwitchHandheldExtensionGetActivationMode : GetEnumFsmStateAction {

        [Tooltip("The value to store.")]
        [ObjectType(typeof(HandheldActivationMode))]
        public FsmEnum storeValue;

        protected override FsmEnum _storeValue { get { return storeValue; } set { this.storeValue = value; } }

        public override void Reset() {
            base.Reset();
            storeValue = HandheldActivationMode.Dual;
        }

        protected override void DoUpdate() {
            storeValue.Value = HandheldExtension.activationMode;
        }
    }

    [ActionCategory(Consts.playMakerActionCategory)]
    [Tooltip("Sets the mode that activates the handheld style of operation. " +
        "There are two different conditional modes for activating the handheld style of operation. " +
        "<see HandheldActivationMode.Dual:  " +
        "In this mode, the handheld style of operation is enabled when both the left and right Joy-Con controllers are attached.  " +
        "This mode is set by default. " +
        "HandheldActivationMode.Single: " +
        "In this mode, the handheld style of operation is enabled when either just the left or right Joy-Con controller is attached. " +
        "When just one of the two controllers is attached to Switch, the input from the unattached controller is treated as no input (as if no digital buttons are being pressed and the analog stick is in the neutral position). The input state of the six-axis sensor is obtained from the actually attached Joy-Con. " +
        "The input from the unattached controller is treated as no input (as if no digital buttons are being pressed and the analog stick is in the neutral position). " +
        "The input state of the six-axis sensor is obtained from the actually attached Joy-Con.")]
    public class RewiredSwitchHandheldExtensionSetActivationMode : SetEnumFsmStateAction {

        [Tooltip("The value to set.")]
        [RequiredField, ObjectType(typeof(HandheldActivationMode))]
        public FsmEnum value;

        protected override FsmEnum _value { get { return value; } set { this.value = value; } }

        public override void Reset() {
            base.Reset();
            value = HandheldActivationMode.Dual;
        }

        protected override void DoUpdate() {
            HandheldExtension.activationMode = (HandheldActivationMode)value.Value;
        }
    }

    #endregion
}