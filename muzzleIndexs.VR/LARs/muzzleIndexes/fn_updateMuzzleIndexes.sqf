//Passed:
//	0: unit to update muzzles for
//	1: mode, mainly used internally for evenHandlers to update muzzles
//	2: weapon, STRING className of weapon

private[ "_muzzleIndexes", "_nul" ];

params[
	[ "_unit", objNull, [ objNull ] ],
	[ "_mode", "init", [ "" ] ],
	[ "_weapon", "", [ "" ] ]
];

if ( isClass( configFile >> "CfgWeapons" >> _weapon ) || _mode isEqualTo "init" ) then {
	_muzzleIndexes = _unit getVariable [ "LARs_muzzleIndexes", [] ];
	switch ( _mode ) do {
		case "init" : {
			_unit setVariable [ "LARs_muzzleIndexes", [] ];
			{
				[ _unit, "take", _x ] call LARs_fnc_updateMuzzleIndexes;
			}forEach ( getArray( configFile >> "CfgVehicles" >> typeOf _unit >> "weapons" ) );
		};
		case "take" : {
			{
				_nul = _muzzleIndexes pushBack _x;
			}forEach ( _weapon call LARs_fnc_getMuzzleDetails );
			_unit setVariable [ "LARs_muzzleIndexes", _muzzleIndexes ];
		};
		case "put" : {
			{
				if ( _x select 0 isEqualTo _weapon ) then {
					_muzzleIndexes set [ _forEachIndex, -1 ];
				};
			}forEach _muzzleIndexes;
			_muzzleIndexes = _muzzleIndexes - [ -1 ];
			_unit setVariable [ "LARs_muzzleIndexes", _muzzleIndexes ];
		};
	};
};