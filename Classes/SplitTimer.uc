class SplitTimer extends Mutator;
 
 var bool bGameStarted;
 var bool bInitiated;
 
function PreBeginPlay()
{
	Log("SplitTimer: Mutator started");
	//Disable('Tick');
	bGameStarted = False;
	bInitiated = False;
	
	Log("SplitTimer: Match starting");
	if (KFGameType(Level.Game) == none)
	{
	Log("SplitTimer: Destroying mutator");
	Destroy();
	return;
	}
		
	if (Level.NetMode != NM_Standalone)
	{
		Log("SplitTimer: Add package to map");
		AddToPackageMap("SplitTimer");
	}
}

simulated function Tick(float DeltaTime)
{
	local PlayerController PC;
	local GameReplicationInfo GRI;

	GRI = Level.GRI;
	if (!GRI.bMatchHasBegun)
	{
		return;
	}
	 
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
