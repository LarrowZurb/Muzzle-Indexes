//passed
//	0: unit to get muzzle index from
//	1: weapon to index for
//	2: ( optional ) weapon muzzle to get index for, if not supplied muzzle "this" is used
//	3: ( optional ) weapon mode to get index for, if not supplied first mode is returned

private [ "_muzzleIndexes", "_index", "_ret" ];

params[
	[ "_unit", objNull, [ objNull ] ],
	[ "_weapon", "", [ "" ] ],
	[ "_muzzle", "", [ "" ] ],
	[ "_mode", "", [ "" ] ]
];

if ( count ( _unit getVariable [ "LARs_muzzleIndexes", [] ] ) isEqualTo 0 ) exitWith {};

_checkFor = [ _weapon ];

if ( _muzzle isEqualTo "" ) then {
	_checkFor pushBack _weapon;
}else{
	_checkFor pushBack _muzzle;
};

if !( _mode isEqualTo "" ) then {
	_checkFor pushBack _mode;
};

_muzzleIndexes = _unit getVariable [ "LARs_muzzleIndexes", [] ];
_ret = -1;
{
	_index = _x select [ 0, count _checkFor ];
	if ( _index isEqualTo _checkFor ) exitWith { _ret = _forEachIndex };
}forEach _muzzleIndexes;

_ret