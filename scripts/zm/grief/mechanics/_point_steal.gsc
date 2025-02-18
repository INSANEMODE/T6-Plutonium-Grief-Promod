#include maps/mp/zombies/_zm_score;

attacker_steal_points( attacker, event )
{
	if ( level.intermission )
	{
		return;
	}
	if ( event == "MOD_MELEE" )
	{
		event = "knife";
	}
	else if ( event == "MOD_PISTOL_BULLET" || event == "MOD_RIFLE_BULLET" ) 
	{
		event = "gun";
	}
	else if ( event == "MOD_GRENADE" || event == "MOD_GRENADE_SPLASH")
	{
		event = "grenade";
	}
	else if ( event == "MOD_IMPACT" || event == "MOD_HIT_BY_OBJECT" )
	{
		event = "impact";
	}
	if ( isDefined( attacker ) && isDefined( self ) )
	{
		points_to_steal = 0;
		switch( event )
		{
			case "meat":
				points_to_steal = 1000;
				break;
			case "knife":
				points_to_steal = 100;
				break;
			case "gun":
				points_to_steal = 20;
				break;
			case "grenade":
				points_to_steal = 100;
				break;
			case "impact":
				points_to_steal = 50;
				break;
			case "down_player":
				points_to_steal = 500;
				break;
			case "kill_player":
				points_to_steal = 500;
				break;
			case "deny_revive":
				points_to_steal = 300;
				break;
			case "deny_box_weapon_pickup":
				points_to_steal = 100;
				break;
			case "emp_pap_with_weapon":
				break;
			case "emp_box_roll":
				break;
			case "emp_player":
				points_to_steal = 100;
				break;
			default:
				break;
		}
		if ( points_to_steal == 0 )
		{
			return;
		}
		attacker add_to_player_score( points_to_steal );
		self minus_to_player_score( points_to_steal, true );
	}
}

player_reduce_points_override( event, mod, hit_location ) //checked matches cerberus output
{
	return;
}

steal_points_on_bleedout( attacker )
{
	level endon( "end_game" );
	self endon( "disconnect" );
	self endon( "spawned" );
	self endon( "revived" );
	self waittill( "bled_out" );
	if ( isDefined( attacker ) )
	{
		self attacker_steal_points( attacker, "kill_player" );
	}
}