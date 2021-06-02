/**
 * Panel class for the SplitTimer tab.  This class borrows its look and feel from the communications tab
 * Thanks to etsai (Scary Ghost) for the original code.
 */
class TimerPanel extends KFGui.KFTab_MidGameVoiceChat;

struct NumericStrPair {
    var moNumericEdit NumericBox;
    var String str;
};

var Timer TimerInteraction;
var automated moNumericEdit PB, WR0, WR1, WR2, WR3, WR4, WR5, WR6, WR7, WR8, WR9, WR10;
var array<NumericBox> WRBoxes[11];
var NumericStrPair WR0

function InitComponent(GUIController MyController, GUIComponent MyOwner) {
    local int i;

    super.InitComponent(MyController, MyOwner);
	
	foreach AllObjects(class'Timer', TimerInteraction)
	{
		break;
	}

	for (i = 0; i < 12; i++)
	{
		WRBoxes[i].str = 'Wave' @ i;
		sb_Players.ManageComponent(WRBoxes[i].NumericBox);
	}
    sb_Players.Caption= "World Record";
	sb_Players.UnManageComponent(lb_Players);
    sb_Players.ManageComponent(PB);
}

function InternalOnLoadINI(GUIComponent sender, string s) {
    local int i;

	WRBoxes[0].NumericBox = WR0;
	WRBoxes[1].NumericBox = WR1;
	WRBoxes[2].NumericBox = WR2;
	WRBoxes[3].NumericBox = WR3;
	WRBoxes[4].NumericBox = WR4;
	WRBoxes[5].NumericBox = WR5;
	WRBoxes[6].NumericBox = WR6;
	WRBoxes[7].NumericBox = WR7;
	WRBoxes[8].NumericBox = WR8;
	WRBoxes[9].NumericBox = WR9;
	WRBoxes[10].NumericBox = WR10;


	for (i = 0; i < 12; i++)
	{
		WRBoxes[i].NumericBox.SetValue(TimerInteraction.Best[i]);
	}
}

function InternalOnChange(GUIComponent sender) {
    local int i;

	for (i = 0; i < 12; i++)
	{
		TimerInteraction.Best[i] = Int(WRBoxes.NumericBox.GetComponentValue());
	}
	TimerInteraction.SaveConfig();
}

defaultproperties {

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
		OnChange=TimerPanel.InternalOnChange
        OnLoadINI=TimerPanel.InternalOnLoadINI
	End Object
	WRBoxes[0].NumericBox = moNumericEdit'TimerPanel.WRBox_0'
	
	Begin Object Class=moNumericEdit Name=WRBox_1
		MinValue=0
		Caption="Wave 2"
		IniOption="@Internal"
	End Object
	WRBoxes[1].NumericBox = moNumericEdit'TimerPanel.WRBox_1'
	
	Begin Object Class=moNumericEdit Name=WRBox_2
		MinValue=0
		Caption="Wave 3"
		IniOption="@Internal"
		OnLoadINI=TimerPanel.InternalOnLoadINI
	End Object
	WRBoxes[2].NumericBox = moNumericEdit'TimerPanel.WRBox_2'
	
	Begin Object Class=moNumericEdit Name=WRBox_3
		MinValue=0
		Caption="Wave 4"
		IniOption="@Internal"
		OnLoadINI=TimerPanel.InternalOnLoadINI
	End Object
	WRBoxes[3].NumericBox = moNumericEdit'TimerPanel.WRBox_3'
	
		Begin Object Class=moNumericEdit Name=WRBox_4
		MinValue=0
		Caption="Wave 5"
		IniOption="@Internal"
		OnLoadINI=TimerPanel.InternalOnLoadINI
	End Object
	WRBoxes[4].NumericBox = moNumericEdit'TimerPanel.WRBox_4'
	
	Begin Object Class=moNumericEdit Name=WRBox_5
		MinValue=0
		Caption="Wave 6"
		IniOption="@Internal"
		OnLoadINI=TimerPanel.InternalOnLoadINI
	End Object
	WRBoxes[5].NumericBox = moNumericEdit'TimerPanel.WRBox_5'
	
	Begin Object Class=moNumericEdit Name=WRBox_6
		MinValue=0
		Caption="Wave 7"
		IniOption="@Internal"
		OnLoadINI=TimerPanel.InternalOnLoadINI
	End Object
	WRBoxes[6].NumericBox = moNumericEdit'TimerPanel.WRBox_6'
	
	Begin Object Class=moNumericEdit Name=WRBox_7
		MinValue=0
		Caption="Wave 8"
		IniOption="@Internal"
		OnLoadINI=TimerPanel.InternalOnLoadINI
	End Object
	WRBoxes[7].NumericBox = moNumericEdit'TimerPanel.WRBox_7'
	
	Begin Object Class=moNumericEdit Name=WRBox_8
		MinValue=0
		Caption="Wave 9"
		IniOption="@Internal"
		OnLoadINI=TimerPanel.InternalOnLoadINI
	End Object
	WRBoxes[8].NumericBox = moNumericEdit'TimerPanel.WRBox_8'
	
	Begin Object Class=moNumericEdit Name=WRBox_9
		MinValue=0
		Caption="Wave 10"
		IniOption="@Internal"
		OnLoadINI=TimerPanel.InternalOnLoadINI
	End Object
	WRBoxes[9].NumericBox = moNumericEdit'TimerPanel.WRBox_9'
	
	Begin Object Class=moNumericEdit Name=WRBox_10
		MinValue=0
		Caption="Wave 11"
		IniOption="@Internal"
		OnLoadINI=TimerPanel.InternalOnLoadINI
	End Object
	WRBoxes[10].NumericBox = moNumericEdit'TimerPanel.WRBox_10'
}
