static var deployed : boolean;

function Start () {

	deployed = false;
	target1 = null;
}

function Update () {


}

function OnGUI() 
{
	if (GUI.Button(Rect(10,10,200,40),"Deploy / Retract Turrets"))
		deployed = !deployed;
}