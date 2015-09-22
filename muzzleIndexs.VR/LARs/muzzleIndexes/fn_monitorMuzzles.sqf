#define ok if
#define error if !
#define parms( _var, _index, _count ) [ [], _var select [ _index, _count ] ] select ( count _var >= ( _index + _count ) )

error ( params[
	[ "_unit", objNull, [ objNull ] ]
] ) exitWith {
	"Invalid UNIT specified for LARs_monitorMuzzles" call BIS_fnc_error;
};

error ( _unit isKindOf "CaManBase" ) exitWith {
	format [ "UNIT - %1 is not a Man", _unit ] call BIS_fnc_error;
};

ok ( parms( _this, 1, 1 ) params[
	[ "_isGlobal", false, [ 0, objNull, sideUnknown, grpNull, [] ] ]
] ) exitWith {
	[ _unit, false ] remoteExec [ "LARs_fnc_monitorMuzzles", _isGlobal, format[ "remoteMuzzles_%1", _unit ] ];
};

//if ( time > 0 ) exitWith {
//	"Can not init Muzzles after start" call BIS_fnc_error;
//};

[ _unit, "init" ] call LARs_fnc_updateMuzzleIndexes;

_unit addEventHandler [ "Put", {
	_unit = _this select 0;
	_item = _this select 2;
	[ _unit, "put", _item ] call LARs_fnc_updateMuzzleIndexes;
}];

_unit addEventHandler [ "Take", {
	_unit = _this select 0;
	_item = _this select 2;
	[ _unit, "take", _item ] call LARs_fnc_updateMuzzleIndexes;
}];

_unit addEventHandler [ "Respawn", {
	_unit = _this select 0;
	_nul = _unit spawn {
		sleep 2;
		[ _this, "init" ] call LARs_fnc_updateMuzzleIndexes;
	};
}];