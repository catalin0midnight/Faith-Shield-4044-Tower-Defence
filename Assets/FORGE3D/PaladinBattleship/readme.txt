The fbx model itself is composed of 3 LOD leves (LOD0 being the highest quality).

The deploy/retract animations of the turret mounts are partially optimised 
(parts that are not visible are not rendered to save draw calls. 
This is handleded by the BayDoorsOpen / BayDoorsClose animations. 
Beware that there are separate animation files for the Large and Medium mounts, 
but have the same names that lets you use the same script to handle both animation sets.)

This package does not include any turret / weapon models, but they can be easily added by dragging them under
TurretMount > Platform > Turrets game object.

The blinking lights are controlled by an animation rather than a script.

The deploy / retract commands are controlled in the ShipStatus Script by 
the 'deployed' static variable, that is read by each individual turret mount. 
This way each mount can animate independently 
(some can open/close sooner/later rather than all at the same time)