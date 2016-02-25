BURK_dog setVariable ["BIS_fnc_animalBehaviour_disable", true];

BURK_dogFollowing = true;
BURK_dogSeeking = false;

private ["_safeZoneLocations"];

_safeZoneLocations = [[0,0,0],[0,0,0]];

while {BURK_dogFollowing} do 
{
	{
		if (player distance _x < 200) then
		{
			_safeZone = true;
		};
	} forEach _safeZoneLocations;

	if (_safeZone) then
	{
		BURK_dog playMove "Dog_Sit";
	};	

	if !(alive BURK_dog) exitWith 
	{
		player removeAction _follow;
		player removeAction _seek;
		player removeAction _passive;
		player removeAction _stay;
		player removeAction _run;
		player removeAction _sprint;
		player removeAction agressiveAction;
		player removeAction passiveAction;
		playerHasDog = false;
	};
	if ((alive BURK_dog) && !(Agressive)) then 
	{
		BURK_dog moveTo getPos player;				
	};
	if ((alive BURK_dog) && (Agressive)) then 
	{
		// Scan
		_dogPos = getPos BURK_dog;

		_target = _dogPos nearEntities ["Man",50];
	
		_distanceArray = [];
		{
			if ((_x in units group player) || (_x == player) || (_x isKindOf "animal") || (isPlayer _x)) then
			{
				
			}
			else
			{	
				_tar = player distance _x;
				_distanceArray = _distanceArray + [[_tar,_x]];
			};	
		} forEach _target;

		if ((alive BURK_dog) && !(_distanceArray isEqualTo []) && (Agressive)) then 
		{
			_distanceArray sort true;
			_actualTarget = (_distanceArray select 0) select 1;
			_targetPos = getPos _actualTarget;

			_damage = damage _actualTarget;
			//hint str _distanceArray;
			if (random 1 > 0.5) then
			{	
				[BURK_dog,_actualTarget] say3d "dog_one";
			};	

			BURK_dog moveTo _targetPos;

			if (BURK_dog distance _actualTarget < 2) then
			{
				BURK_dog say3d "dog_ruff";
				_dir = getDir BURK_dog;
				BURK_dog attachTo [_actualTarget, [0, -0.5, 0.1] ];
				BURK_dog setDir _dir;
				uiSleep 0.5; 
				_actualTarget setDamage _damage + 0.2;
				detach BURK_dog;
			};		
		}
		else	
		{
			BURK_dog moveTo getPos player;	
		};	
	};
	uiSleep 1;	
};