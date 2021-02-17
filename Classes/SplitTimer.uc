class SplitTimer extends Mutator;
 
function PreBeginPlay()
{
}

function PostBeginPlay()
{
	    if (KFGameType(Level.Game) == none) {
        Destroy();
        return;
        }
	    if (Level.NetMode != NM_Standalone)
        AddToPackageMap("SplitTimer");
}

simulated function Tick(float DeltaTime)
{
	local PlayerController PC;
 
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
