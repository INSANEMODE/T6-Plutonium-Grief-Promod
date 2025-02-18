#include maps/mp/gametypes_zm/_hud_util;
#include common_scripts/utility;


pregame_hud() //checked matches bo3 _globallogic.gsc within reason
{
	flag_wait( "initial_blackscreen_passed" );
	visionSetNaked( "mpIntro" );
	matchStartText = createServerFontString( "objective", 1.5 );
	matchStartText setPoint( "CENTER", "CENTER", 0, -40 );
	matchStartText.sort = 1001;
	matchStartText setText( game[ "strings" ][ "waiting_for_teams" ] );
	matchStartText.foreground = false;
	matchStartText.hidewheninmenu = true;
	matchStartText.alpha = 1;
	flag_wait( "player_quota" );
	matchStartText setText( game[ "strings" ][ "match_starting_in" ] );
	matchStartTimer = createServerFontString( "objective", 2.2 );
	matchStartTimer setPoint( "CENTER", "CENTER", 0, 0 );
	matchStartTimer.sort = 1001;
	matchStartTimer.color = ( 1, 1, 0 );
	matchStartTimer.foreground = false;
	matchStartTimer.hidewheninmenu = true;
	matchStartTimer maps\mp\gametypes_zm\_hud::fontPulseInit();
	countTime = level.grief_gamerules[ "pregame_time" ];
	if ( countTime >= 2 )
	{
		while ( countTime > 0 )
		{
			matchStartTimer setValue( countTime );
			matchStartTimer thread maps\mp\gametypes_zm\_hud::fontPulse( level );
			if ( countTime == 2 )
			{
				visionSetNaked( GetDvar( "mapname" ), 3.0 );
			}
			countTime--;
			wait 1;
		}
	}
	else
	{
		visionSetNaked( GetDvar( "mapname" ), 1.0 );
	}
	matchStartTimer destroyElem();
	matchStartText destroyElem();
}

wait_for_players()
{
	flag_wait( "initial_blackscreen_passed" );
	while ( ( getPlayers( "allies" ).size < 1 ) || ( getPlayers( "axis" ).size < 1 ) )
	{
		wait 1;
	}
	flag_set( "player_quota" );
}

pregame()
{
	flag_set( "in_pregame" );
	level thread pregame_hud();
	wait_for_players();
	playsoundatposition( "vox_zmba_grief_intro_0", ( 0, 0, 0 ) );
	wait level.grief_gamerules[ "pregame_time" ];
	flag_clear( "in_pregame" );
}