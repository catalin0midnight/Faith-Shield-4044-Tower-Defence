var turnspeed = 5.0;
var speed = 1;
var strafeSpeed = 5.0;
var yawTorque = 1.0;
var pitchTorque = 1.0;
var rollTorque = 1.0;

function Update () {

	var roll = Input.GetAxis("Roll");
	var pitch = Input.GetAxis("Pitch");
	var yaw = Input.GetAxis("Yaw");

	
	rigidbody.AddRelativeTorque(pitch*turnspeed*Time.deltaTime*pitchTorque, yaw*turnspeed*Time.deltaTime*yawTorque, roll*turnspeed*Time.deltaTime*rollTorque);
}