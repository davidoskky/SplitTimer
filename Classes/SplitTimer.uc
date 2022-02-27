class SplitTimer extends Mutator;

simulated function Tick(float DeltaTime)
{
    local PlayerController PC;

    PC = Level.GetLocalPlayerController();

    if (PC != none)
    {
        // Create the interaction
        PC.Player.InteractionMaster.AddInteraction(string(class'Timer'), PC.Player);
        // disable me when interaction is created
        Disable('Tick');
    }

    // disable tick for servers
    if (Role == Role_Authority)
        Disable('Tick');
}

defaultproperties
{
    GroupName="KFSplitTimer"
    FriendlyName="Split Timer"
    Description="Split timer for performing speedruns"

    RemoteRole=ROLE_SimulatedProxy
    bAlwaysRelevant=true
    bAddToServerPackages=true
}