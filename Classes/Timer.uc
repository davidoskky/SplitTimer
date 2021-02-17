Class Timer extends Interaction config(SplitTimer);

var int currentWave;
var float Yposition;

var config int Best[11];

var String Segments[11];
var int Seconds[11];
 
event Initialized()
{
		//Log("Interaction Started");
		// Waves go from 0 to 4
		currentWave = 0;
}
 
function PostRender( canvas Canvas )
{

	local GameReplicationInfo GRI;
	local String Time;
	local float canvasDim;
	local int wave;
	local int elapsed;
	local int difference;
	local int FinalWave;
	local int i;
	
	GRI = ViewportOwner.Actor.GameReplicationInfo;
	
	if ( FinalWave == 0 )
		FinalWave = KFGameReplicationInfo(GRI).FinalWave;
	
	canvasDim = Canvas.SizeX * 0.9;
	Yposition = Canvas.SizeY / 2;
	Yposition = Yposition - 100;
	
	wave = KFGameReplicationInfo(GRI).WaveNumber;
	
	elapsed = GRI.ElapsedTime;
	Time = FormatTime(elapsed);
	
	// If we beat the Patriarch add an imaginary wave to block printing time
	if (wave == FinalWave && !KFGameReplicationInfo(GRI).bWaveInProgress && FinalWave > 0)
		wave += 1;
		
	// At wave change, check difference with best
	if ( wave != currentWave ) 
	{
		difference = SegmentTime(elapsed, currentWave);
		Seconds[currentWave] = difference;

		difference -= Best[currentWave];
		
		Segments[currentWave] = Time @ FormatDifference(difference);
		currentWave = wave;
	}

	for ( i = 0; i < wave; i++ )
	{
		if (Seconds[i] > Best[i])
			Canvas.SetDrawColor(255,0,0);
		else
			Canvas.SetDrawColor(0,255,0);

		Canvas.SetPos(canvasDim, Yposition);
		Canvas.DrawText(Segments[i]);
		
		Yposition += 50;

	}

	
	difference = SegmentTime(elapsed, wave);
	
	if (difference > Best[wave])
		Canvas.SetDrawColor(255,0,0);
	else
		Canvas.SetDrawColor(0,255,0);

		
	Canvas.SetPos(canvasDim, Yposition);
	
	if (wave != FinalWave + 1)
		Canvas.DrawText(Time);
	
}

function String FormatTime( int Seconds )
{
    local int Minutes, Hours;
    local String Time;

    if( Seconds > 3600 )
    {
        Hours = Seconds / 3600;
        Seconds -= Hours * 3600;

        Time = Hours$":";
	}
	Minutes = Seconds / 60;
    Seconds -= Minutes * 60;

    if( Minutes >= 10 )
        Time = Time $ Minutes $ ":";
    else
        Time = Time $ "0" $ Minutes $ ":";

    if( Seconds >= 10 )
        Time = Time $ Seconds;
    else
        Time = Time $ "0" $ Seconds;

    return Time;
}
 
 
function String FormatDifference ( int Seconds )
{
	local String difference;
	
	if ( Seconds > 0 )
	{
		difference = "+";
		difference $= FormatTime(Seconds);
	}
	else
	{
		difference = FormatTime(-Seconds);
		difference = "-" $ difference;
	}
	return difference;
}		
		
		
function int SegmentTime ( int Elapsed, int Wave)
{
	local int i;
	local int time;
	
	time = Elapsed;
	for ( i = 0; i < Wave; i++ )
		time -= Seconds[i];

	return time;
}

defaultproperties
{
    bVisible=true
    bActive=true
}

