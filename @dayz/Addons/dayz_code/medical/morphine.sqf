// bleed.sqf
_unit = (_this select 3) select 0;

player removeMagazine "ItemMorphine";

_unit setVariable ["hit_legs",0];
_unit setVariable ["hit_hands",0];

call fnc_usec_medic_removeActions;
r_action = false;

if (vehicle player == player) then {
	//not in a vehicle
	player playActionNow "Medic";
};
r_interrupt = false;
_animState = animationState player;
r_doLoop = true;
_started = false;
_finished = false;
while {r_doLoop} do {
	_animState = animationState player;
	_isMedic = ["medic",_animState] call fnc_inString;
	if (_isMedic) then {
		_started = true;
	};
	if (_started and !_isMedic) then {
		r_doLoop = false;
		_finished = true;
	};
	if (r_interrupt) then {
		r_doLoop = false;
	};
	sleep 0.1;
};
r_doLoop = false;

if (_finished) then {
	if (_unit == player) then {
		//Self Healing
		_id = [player,player] execVM "\z\addons\dayz_code\medical\publicEH\medMorphine.sqf";
	} else {
		//PVDZ_plr_Humanity = [player,50];
		[player,50] call player_humanityChange;
	};

	//["PVDZ_hlt_Morphine",[_unit,player]] call broadcastRpcCallAll;
	PVDZ_hlt_Morphine = [_unit,player];
	publicVariable "PVDZ_hlt_Morphine";
} else {
	player addMagazine "ItemMorphine";
	r_interrupt = false;
	[objNull, player, rSwitchMove,""] call RE;
	player playActionNow "stop";
};