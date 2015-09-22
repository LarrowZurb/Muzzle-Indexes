//Pass a weapon by className
//return : An array of muzzleIndexes each index is an array of [ weapon, muzzle, mode ] as strings

private[ "_muzzle", "_modes", "_mode", "_muzzleIndexes" ];

params [
	[ "_weapon", "", [ "" ] ]
];

_muzzleIndexes = [];
{
	_muzzle = _x;
	_modes = if ( _muzzle isEqualTo "this" ) then {
		_muzzle = _weapon;
		getArray( configFile >> "CfgWeapons" >> _weapon >> "modes" )
	}else{
		getArray( configFile >> "CfgWeapons" >> _weapon >> _muzzle >> "modes" )
	};
	{
		_mode = _x;
		if ( _mode isEqualTo "this" ) then {
			_mode = _muzzle;
		};
		_muzzleIndexes pushBack [ _weapon, _muzzle, _mode ];
	}forEach _modes;
}forEach getArray( configFile >> "CfgWeapons" >> _weapon >> "muzzles" );

_muzzleIndexes