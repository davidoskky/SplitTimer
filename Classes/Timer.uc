Class Timer extends Interaction config(SplitTimer);

var int currentWave;
var int TotalTime;
var float Yposition;

var config bool bUpdateConfig;
var config int Best[11];
var config int WR[11];
var config int PB;

var int RealBest[11];
var String Segments[11];
var int Seconds[11];
var int WRTOT;
var int SoB;

var GUI.GUITabItem newTab;

event Initialized()
{
    local int i;

    //Log("Interaction Started");
    // Waves go from 0 to 4
    currentWave = 0;

    //Sums the wr splits to show the current WR (MASTRO)
    //Sums the best splits to show your best possible time (Sum of Best) (MASTRO)
    for ( i = 0; i < 11; i++)
    {
        RealBest[i] = Best[i];
        WRTOT += WR[i];
        SoB += Best[i];
        Segments[i] = "Wave" @ i + 1 @ FormatTime(WR[i]);
    }
}

function PostRender( canvas Canvas )
{

    local GameReplicationInfo GRI;
    local String Time;
    local int wave;
    local int elapsed;
    local int difference;
    local int FinalWave;
    local int i;
    //(MASTRO)
    local int Xbox;
    local int Ybox;
    local int BoxEnd;

    GRI = ViewportOwner.Actor.GameReplicationInfo;

    if ( FinalWave == 0 )
        FinalWave = KFGameReplicationInfo(GRI).FinalWave;

    wave = KFGameReplicationInfo(GRI).WaveNumber;

    elapsed = GRI.ElapsedTime;
    if (TotalTime == 0)
        Time = FormatTime(elapsed);
    else
        Time = FormatTime(TotalTime);

    // Check if we beat the Patriarch
    if (KFGameReplicationInfo(GRI).EndGameType == 2 && TotalTime == 0)
    {
        TotalTime = elapsed;
        Seconds[wave] = SegmentTime(elapsed, wave);
        difference = Seconds[wave] - WR[wave];
        Segments[wave] = Segments[wave] @ FormatDifference(difference);

        // Update the config for the Patriarch wave
        if (bUpdateConfig)
        {
            //If we beat the WR, update the ini file
            if (TotalTime < WRTOT)
            {
                for ( i = 0; i < wave+1; i++)
                {
                    WR[i] = Seconds[i];
                }
                SaveConfig();
            }
            if (SegmentTime(TotalTime, wave) - RealBest[wave] < 0)
            {
                Best[wave] = Seconds[wave];
                SaveConfig();
            }
            if (TotalTime < PB)
            {
                PB = TotalTime;
                SaveConfig();
            }
        }
    }

    Seconds[wave] = SegmentTime(elapsed, wave);

    // At wave change, check difference with WR
    if (wave != currentWave && TotalTime == 0)
    {
        difference = Seconds[currentWave] - WR[currentWave];

        Segments[currentWave] = Segments[currentWave] @ FormatDifference(difference);

        // Save new BEST in the ini file //The thing between parenthesis is complicated cause the variable it used has been modified above (MASTRO)
        if (bUpdateConfig && ((SegmentTime(elapsed, currentWave) - RealBest[currentWave]) < 0))
        {
            Best[currentWave] = Seconds[currentWave];
            SaveConfig();
        }
        currentWave = wave;
    }

    // Use a better font
    Canvas.Font = class'ROHUD'.Static.GetSmallMenuFont(Canvas);

    Yposition = Canvas.SizeY / 2 - 200;

    //(MASTRO) Ugly box for ugly aesthetics
    Ybox = Yposition - Canvas.SizeY * 0.05;
    Xbox = Canvas.SizeX * 0.75;
    BoxEnd = Xbox + Canvas.SizeX * 0.24;
    Canvas.SetDrawColor(0,0,255);
    Canvas.DrawTextJustified("SPLIT TIMER", 1, Xbox, Ybox, BoxEnd, Ybox + 25);
    Canvas.SetPos(Xbox , Ybox);
    Canvas.DrawBox(Canvas, Canvas.SizeX * 0.24, 450);
    Canvas.DrawHorizontal(Ybox+20, Canvas.SizeX * 0.24);

    // Changes the 3 colors of the splits by comparing them to WR and to Best splits(MASTRO)
    for ( i = 0; i < FinalWave + 1; i++ )
    {
        if (Seconds[i] <= RealBest[i])
            Canvas.SetDrawColor(255,0,255);
        else if (Seconds[i] <= WR[i])
            Canvas.SetDrawColor(0,255,0);
        else
            Canvas.SetDrawColor(255,0,0);

        //Set the color of the next waves to white
        if (wave < i)
            Canvas.SetDrawColor(255, 255, 255);

        Canvas.DrawTextJustified(Segments[i], 0, Xbox + 10, Yposition, BoxEnd, Yposition + 25);

        Yposition += 50;
    }

    //Shows Run time, WR, PB and SoB below the current splits (MASTRO)
    Canvas.SetDrawColor(0,255,0);
    Canvas.Font = class'ROHUD'.Static.GetLargeMenuFont(Canvas);
    Canvas.DrawTextJustified(Time, 0, Xbox + 30, Yposition, BoxEnd - Canvas.SizeX * 0.05, Yposition + 35);
    Canvas.SetDrawColor(0,0,255);
    Canvas.SetPos(Xbox , Ybox);
    Canvas.DrawHorizontal(Yposition + 35, Canvas.SizeX * 0.24);
    Canvas.Font = class'ROHUD'.Static.GetSmallerMenuFont(Canvas);
    Canvas.SetDrawColor(0,255,0);

    // Adaptive position of the lowest stats
    if (Canvas.SizeY < 1080) {
        Yposition += 75;
    } else {
        Yposition += 50;
    }
    Canvas.DrawTextJustified("WR: " @ FormatTime(WRTOT), 1, Xbox, Yposition, BoxEnd, Yposition + 25);
    Canvas.SetDrawColor(255,0,255);
    Yposition += 30;
    Canvas.DrawTextJustified("PB: " @ FormatTime(PB), 1, Xbox, Yposition, BoxEnd, Yposition + 25);
    Yposition += 30;
    Canvas.DrawTextJustified("SOB:" @ FormatTime(SoB), 1, Xbox, Yposition, BoxEnd, Yposition + 25);

    // Reset the canvas to prevent strange colors in other places
    Canvas.Reset();
}


event NotifyLevelChange() {
    Master.RemoveInteraction(self);
}


function bool KeyEvent(EInputKey Key, EInputAction Action, float Delta)
{
    local string alias;
    local MidGamePanel panel;

    alias= ViewportOwner.Actor.ConsoleCommand("KEYBINDING"@ViewportOwner.Actor.ConsoleCommand("KEYNAME"@Key));
    if (Action == IST_Press && alias ~= "showmenu") {
        if (KFGUIController(ViewportOwner.GUIController).ActivePage == None) {
            ViewportOwner.Actor.ShowMenu();
        }
        if (KFInvasionLoginMenu(KFGUIController(ViewportOwner.GUIController).ActivePage) != none &&
                KFInvasionLoginMenu(KFGUIController(ViewportOwner.GUIController).ActivePage).c_Main.TabIndex(newTab.caption) == -1) {
            panel= MidGamePanel(KFInvasionLoginMenu(KFGUIController(ViewportOwner.GUIController).ActivePage).c_Main.AddTabItem(newTab));
            if (panel != none) {
                panel.ModifiedChatRestriction= KFInvasionLoginMenu(KFGUIController(ViewportOwner.GUIController).ActivePage).UpdateChatRestriction;
            }
        }
    }
    return false;
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
    newTab=(ClassName="SplitTimer.TimerPanel",Caption="Split Timer",Hint="Set the time for your splits")
}