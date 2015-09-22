fnc_addMuzzleAction = {
	_unit = _this select 0;
	_muzzle = _this select 1;

	_unit addAction [ "Fire GL", format[ "
		_unit = _this select 0;
		_index = [ _unit, primaryWeapon _unit, %1 ] call LARs_fnc_getMuzzleIndex;
		[ _unit, [ 'SelectWeapon', _unit, _unit, _index ] ] remoteExec [ 'action', _unit ];
		[ _unit, [ 'UseWeapon', _unit, _unit, _index ] ] remoteExec [ 'action', _unit ];

	", str _muzzle ] ];
};

//		_unit  action [ 'UseWeapon', _unit, _unit, _index ];

if ( isServer ) then {
	waitUntil { time > 0 };
	{
		_unit = _x;
		if !( isPlayer _unit ) then {
			{
				if ( getText( configFile >> "CfgWeapons" >> primaryWeapon _unit >> _x >> "cursorAim" ) isEqualTo "gl" ) then {
					[ _unit, 0 ] call LARs_fnc_monitorMuzzles;
					[ _unit, configName( configFile >> "CfgWeapons" >> primaryWeapon _unit >> _x ) ] remoteExec [ "fnc_addMuzzleAction", 0, format[ "muzzleAction_", _unit ] ];
				};
			}forEach ( getArray( configFile >> "CfgWeapons" >> primaryWeapon _unit >> "muzzles" ) - [ "this" ] );
		};
	}forEach allUnits;
};
