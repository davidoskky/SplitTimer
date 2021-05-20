/**
 * Panel class for the SplitTimer tab.  This class borrows its look and feel from the communications tab
 * Thanks to etsai (Scary Ghost) for the original code.
 */
class TimerPanel extends KFGui.KFTab_MidGameVoiceChat;

struct SliderStrPair {
    var moSlider slider;
    var String str;
};

var automated moComboBox categories, players;
var automated GUIListBox statBox;
//var array<SortedMap> statsInfo;
var automated moSlider sl_bgR, sl_bgG, sl_bgB, sl_txtR, sl_txtG, sl_txtB, sl_alpha, sl_txtScale;
var automated moNumericEdit PB, WR0, WR1;
var array<SliderStrPair> sliders;
var String statListClass;
var PlayerReplicationInfo lastSelected;
/* 
function fillList(SortedMap stats) {
    local int i;
    local GUIListElem elem;

    statBox.List.bInitializeList= true;
    statBox.List.Clear();
    for(i= 0; i < stats.maxStatIndex; i++) {
        if (stats.keys[i] != class'KFSXGameRules'.default.damageKey || 
                stats.keys[i] == class'KFSXGameRules'.default.damageKey && 
                (!KFGameReplicationInfo(PlayerOwner().GameReplicationInfo).bWaveInProgress || 
                KFGameReplicationInfo(PlayerOwner().GameReplicationInfo).EndGameType != 0)) {
            elem.Item= stats.keys[i];
            elem.ExtraStrData= string(int(stats.values[i]));
            statBox.List.AddElement(elem);
        }
    }
}
 */
function InitComponent(GUIController MyController, GUIComponent MyOwner) {
    local int i;

    super.InitComponent(MyController, MyOwner);

    // sliders.Length= 8;
    // sliders[0].slider= sl_bgR;
    // sliders[0].str= "bgR";
    // sliders[1].slider= sl_bgG;
    // sliders[1].str= "bgG";
    // sliders[2].slider= sl_bgB;
    // sliders[2].str= "bgB";
    // sliders[3].slider= sl_alpha;
    // sliders[3].str= "alpha";
    // sliders[4].slider= sl_txtR;
    // sliders[4].str= "txtR";
    // sliders[5].slider= sl_txtG;
    // sliders[5].str= "txtG";
    // sliders[6].slider= sl_txtB;
    // sliders[6].str= "txtB";
    // sliders[7].slider= sl_txtScale;
    // sliders[7].str= "txtScale";

    sb_Players.Caption= "World Record";
    sb_Players.ManageComponent(PB);
	sb_Players.ManageComponent(WR0);
	sb_Players.ManageComponent(WR1);
    sb_Players.UnManageComponent(lb_Players);

    /** 
     * This is purely for combo box placement.  The 
     * lb_Specs variable will not be visible in the window
     */
/*     sb_Specs.Caption= "Filters";
    sb_Specs.UnManageComponent(lb_Specs);
    sb_Specs.ManageComponent(categories);
    sb_Specs.ManageComponent(players);
    sb_Specs.ManageComponent(lb_Specs); */

    //sb_Options.Caption= "Settings";
/*     for(i= 0; i < sliders.Length; i++) {
        sb_Options.ManageComponent(sliders[i].slider);
    } */
}

function InternalOnLoadINI(GUIComponent sender, string s) {
    local int i;
    local String command;

    if (sender == players) {
        if (lastSelected == None) {
            //lastSelected= PlayerOwner().PlayerReplicationInfo;
        }
        players.ResetComponent();
        for(i= 0; i < PlayerOwner().GameReplicationInfo.PRIArray.Length; i++) {
            players.AddItem(PlayerOwner().GameReplicationInfo.PRIArray[i].PlayerName);
            if (PlayerOwner().GameReplicationInfo.PRIArray[i] == lastSelected) {
                players.SilentSetIndex(i);
            }
        }
        //fillStatsInfo(class'KFSXReplicationInfo'.static.findKFSXri(lastSelected));
    } else {
        while(i < sliders.Length && sender != sliders[i].slider) {
            i++;
        }
        if (i < sliders.Length) {
            command= "get" @ statListClass @ sliders[i].str;
            sliders[i].slider.SetComponentValue(float(PlayerOwner().ConsoleCommand(command)), true);
        }
    }
}

function InternalOnChange(GUIComponent sender) {
    local int i;
    local String command;

    if (sender == categories) {
        //fillList(statsInfo[categories.GetIndex()]);
    } else if (sender == players) {
        lastSelected= PlayerOwner().GameReplicationInfo.PRIArray[players.GetIndex()];
        //fillStatsInfo(class'KFSXReplicationInfo'.static.findKFSXri(lastSelected));
    } else {
        while(i < sliders.Length && sender != sliders[i].slider) {
            i++;
        }
        if (i < sliders.Length) {
            command= "set"@ statListClass @ sliders[i].str @ sliders[i].slider.GetValue();
            PlayerOwner().ConsoleCommand(command);
        }
    }
}

function FillPlayerLists() {
}

defaultproperties {
    statListClass= "KFStatsX.StatList"

    ch_NoVoiceChat= None
    ch_NoSpeech= None
    ch_NoText= None
    ch_Ban= None
	
	Begin Object Class=moNumericEdit Name=PBBox
		MinValue=0
		Caption="PB"
		IniOption="@Internal"
	End Object
	PB = moNumericEdit'TimerPanel.PBBox'
	
	Begin Object Class=moNumericEdit Name=WRBox_0
		MinValue=0
		Caption="Wave 1"
		IniOption="@Internal"
	End Object
	WR0 = moNumericEdit'TimerPanel.WRBox_0'
	
	Begin Object Class=moNumericEdit Name=WRBox_1
		MinValue=0
		Caption="Wave 2"
		IniOption="@Internal"
	End Object
	WR1 = moNumericEdit'TimerPanel.WRBox_1'
}
