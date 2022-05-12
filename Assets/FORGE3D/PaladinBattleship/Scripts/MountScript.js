private var deployed : boolean;
private var ready : boolean;
var anim : Animation;

function Start()
{
deployed = false;	
}

function Update()
{
	if (ShipStatus.deployed)
	{
		PlayAnimOpen();
	}
	else if (!ShipStatus.deployed)
	{
		PlayAnimClose();
	}
}


function PlayAnimOpen()
{
if (!deployed)
	{
		if (!anim.animation.isPlaying)
		{
			anim.animation.Play("BayDoorsOpen");
			deployed = true;
		}
		else 
		{
			yield; while ( anim.animation.isPlaying ) yield;
			anim.animation.Play("BayDoorsOpen");
		}
		yield; while ( anim.animation.isPlaying ) yield;
		ready = true;
	}
} 

function PlayAnimClose()
{
		if (ready)
	{
		if (!anim.animation.isPlaying)
		{
			ready = false;
			anim.animation.Play("BayDoorsClose");			
		}
		else 
		{
			yield; while ( anim.animation.isPlaying ) yield;
			anim.animation.Play("BayDoorsClose");

		}
		yield; while ( anim.animation.isPlaying ) yield;
		deployed = false;
	}
	
}