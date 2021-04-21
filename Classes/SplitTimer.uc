class SplitTimer extends Mutator;
 
 var bool bGameStarted;
 
function PreBeginPlay()
{
	Disable('Tick');
	bGameStarted = False;
}

function MatchStarting()
{
	if (KFGameType(Level.Game) == none)
	{
	Destroy();
	return;
	}
		
	if (Level.NetMode != NM_Standalone)
	{
		AddToPackageMap("SplitTimer");
	}

	bGameStarted = True;
	Enable('Tick');
}

simulated function Tick(float DeltaTime)
{
	local PlayerController PC;

	if (!bGameStarted)
		return;
	 
	PC = Level.GetLocalPlayerController();
	
	if (PC != none) {
		PC.Player.InteractionMaster.AddInteraction("SplitTimer.Timer", PC.Player); // Create the interaction
    }

	Disable('Tick');
}
 
defaultproperties 
{
	 GroupName="KFSplitTimer"
     FriendlyName="Split Timer"
     Description="Split timer for performing speedruns"
     
     RemoteRole=ROLE_SimulatedProxy
     bAlwaysRelevant=true
}
