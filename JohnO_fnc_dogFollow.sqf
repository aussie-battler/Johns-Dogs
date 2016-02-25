// Dog follower
BURK_dogFollowing = true;
JohnOplayerHasDog = true;

BURK_dog playMove "Dog_Run";
Dogfollow = player addAction ["Dog: Follow", {BURK_dog playMove "Dog_Run"; [] call BURK_dogFollowPlayer;}];

dogseek = player addAction ["Dog: Seek", {titleText ["Your dog will seekout animals..","PLAIN DOWN"];[] call BURK_dogSeek;}];
Dogpassive = player addAction ["Dog: Aggressive","agressive.sqf","",0,false];

Dogstay = player addAction ["Dog: Stay", {BURK_dog playMove "Dog_Stop";}];

Dogrun = player addAction ["Dog: Run", {BURK_dog playMove "Dog_Run";}];
Dogsprint = player addAction ["Dog: Sprint", {BURK_dog playMove "Dog_Sprint";}];

BURK_dogStopFollowing = 
{
	BURK_dog setVariable ["BIS_fnc_animalBehaviour_disable", false];
	BURK_dogFollowing = false;

	BURK_dog playMove "Dog_Idle_Stop";	
};

[] call BURK_dogFollowPlayer;

