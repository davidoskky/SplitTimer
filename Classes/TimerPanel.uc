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
var automated moNumericEdit Best0, Best1, Best2, Best3, Best4, Best5, Best6, Best7, Best8, Best9, Best10;
var array<NumericStrPair> WRBoxes[11], BestBoxes[11];

function InitComponent(GUIController MyController, GUIComponent MyOwner) {
    local int i;

    super.InitComponent(MyController, MyOwner);
	
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
	
	BestBoxes[0].NumericBox = Best0;
	BestBoxes[1].NumericBox = Best1;
	BestBoxes[2].NumericBox = Best2;
	BestBoxes[3].NumericBox = Best3;
	BestBoxes[4].NumericBox = Best4;
	BestBoxes[5].NumericBox = Best5;
	BestBoxes[6].NumericBox = Best6;
	BestBoxes[7].NumericBox = Best7;
	BestBoxes[8].NumericBox = Best8;
	BestBoxes[9].NumericBox = Best9;
	BestBoxes[10].NumericBox = Best10;
	
	foreach AllObjects(class'Timer', TimerInteraction)
	{
		break;
	}
	
    sb_Players.Caption= "World Record";
    sb_Players.ManageComponent(PB);
	//sb_Specs.UnManageComponent(lb_Specs);
	sb_Specs.Caption = "Personal Best";

	for (i = 0; i < 12; i++)
	{
		WRBoxes[i].str = 'Wave' @ i;
		BestBoxes[i].str = 'Wave' @ i;
		sb_Players.ManageComponent(WRBoxes[i].NumericBox);
		sb_Specs.ManageComponent(BestBoxes[i].NumericBox);
	}
}

function InternalOnLoadINI(GUIComponent sender, string s) {
    local int i;

	for (i = 0; i < 12; i++)
	{
		WRBoxes[i].NumericBox.SetValue(TimerInteraction.Best[i]);
		BestBoxes[i].NumericBox.SetValue(TimerInteraction.Best[i]);
	}
	//PB.SetValue(TimerInteraction.PB);
}

function InternalOnChange(GUIComponent sender) {
    local int i;

	for (i = 0; i < 12; i++)
	{
		TimerInteraction.Best[i] = Int(WRBoxes[i].NumericBox.GetComponentValue());
		TimerInteraction.Best[i] = Int(BestBoxes[i].NumericBox.GetComponentValue());
	}
	//TimerInteraction.PB = Int(PB.GetComponentValue());
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
	WR0=moNumericEdit'TimerPanel.WRBox_0'
	
	Begin Object Class=moNumericEdit Name=WRBox_1
		MinValue=0
		Caption="Wave 2"
		IniOption="@Internal"
	End Object
	WR1=moNumericEdit'TimerPanel.WRBox_1'
	
	Begin Object Class=moNumericEdit Name=WRBox_2
		MinValue=0
		Caption="Wave 3"
		IniOption="@Internal"
		OnLoadINI=TimerPanel.InternalOnLoadINI
	End Object
	WR2=moNumericEdit'TimerPanel.WRBox_2'
	
	Begin Object Class=moNumericEdit Name=WRBox_3
		MinValue=0
		Caption="Wave 4"
		IniOption="@Internal"
		OnLoadINI=TimerPanel.InternalOnLoadINI
	End Object
	WR3=moNumericEdit'TimerPanel.WRBox_3'
	
		Begin Object Class=moNumericEdit Name=WRBox_4
		MinValue=0
		Caption="Wave 5"
		IniOption="@Internal"
		OnLoadINI=TimerPanel.InternalOnLoadINI
	End Object
	WR4=moNumericEdit'TimerPanel.WRBox_4'
	
	Begin Object Class=moNumericEdit Name=WRBox_5
		MinValue=0
		Caption="Wave 6"
		IniOption="@Internal"
		OnLoadINI=TimerPanel.InternalOnLoadINI
	End Object
	WR5=moNumericEdit'TimerPanel.WRBox_5'
	
	Begin Object Class=moNumericEdit Name=WRBox_6
		MinValue=0
		Caption="Wave 7"
		IniOption="@Internal"
		OnLoadINI=TimerPanel.InternalOnLoadINI
	End Object
	WR6=moNumericEdit'TimerPanel.WRBox_6'
	
	Begin Object Class=moNumericEdit Name=WRBox_7
		MinValue=0
		Caption="Wave 8"
		IniOption="@Internal"
		OnLoadINI=TimerPanel.InternalOnLoadINI
	End Object
	WR7=moNumericEdit'TimerPanel.WRBox_7'
	
	Begin Object Class=moNumericEdit Name=WRBox_8
		MinValue=0
		Caption="Wave 9"
		IniOption="@Internal"
		OnLoadINI=TimerPanel.InternalOnLoadINI
	End Object
	WR8=moNumericEdit'TimerPanel.WRBox_8'
	
	Begin Object Class=moNumericEdit Name=WRBox_9
		MinValue=0
		Caption="Wave 10"
		IniOption="@Internal"
		OnLoadINI=TimerPanel.InternalOnLoadINI
	End Object
	WR9 = moNumericEdit'TimerPanel.WRBox_9'
	
	Begin Object Class=moNumericEdit Name=WRBox_10
		MinValue=0
		Caption="Wave 11"
		IniOption="@Internal"
		OnLoadINI=TimerPanel.InternalOnLoadINI
	End Object
	WR10 = moNumericEdit'TimerPanel.WRBox_10'
	
	Begin Object Class=moNumericEdit Name=BestBox_0
		MinValue=0
		Caption="Wave 1"
		IniOption="@Internal"
		OnChange=TimerPanel.InternalOnChange
        OnLoadINI=TimerPanel.InternalOnLoadINI
	End Object
	Best0=moNumericEdit'TimerPanel.BestBox_0'
	
	Begin Object Class=moNumericEdit Name=BestBox_1
		MinValue=0
		Caption="Wave 2"
		IniOption="@Internal"
	End Object
	Best1=moNumericEdit'TimerPanel.BestBox_1'
	
	Begin Object Class=moNumericEdit Name=BestBox_2
		MinValue=0
		Caption="Wave 3"
		IniOption="@Internal"
		OnLoadINI=TimerPanel.InternalOnLoadINI
	End Object
	Best2=moNumericEdit'TimerPanel.BestBox_2'
	
	Begin Object Class=moNumericEdit Name=BestBox_3
		MinValue=0
		Caption="Wave 4"
		IniOption="@Internal"
		OnLoadINI=TimerPanel.InternalOnLoadINI
	End Object
	Best3=moNumericEdit'TimerPanel.BestBox_3'
	
		Begin Object Class=moNumericEdit Name=BestBox_4
		MinValue=0
		Caption="Wave 5"
		IniOption="@Internal"
		OnLoadINI=TimerPanel.InternalOnLoadINI
	End Object
	Best4=moNumericEdit'TimerPanel.BestBox_4'
	
	Begin Object Class=moNumericEdit Name=BestBox_5
		MinValue=0
		Caption="Wave 6"
		IniOption="@Internal"
		OnLoadINI=TimerPanel.InternalOnLoadINI
	End Object
	Best5=moNumericEdit'TimerPanel.BestBox_5'
	
	Begin Object Class=moNumericEdit Name=BestBox_6
		MinValue=0
		Caption="Wave 7"
		IniOption="@Internal"
		OnLoadINI=TimerPanel.InternalOnLoadINI
	End Object
	Best6=moNumericEdit'TimerPanel.BestBox_6'
	
	Begin Object Class=moNumericEdit Name=BestBox_7
		MinValue=0
		Caption="Wave 8"
		IniOption="@Internal"
		OnLoadINI=TimerPanel.InternalOnLoadINI
	End Object
	Best7=moNumericEdit'TimerPanel.BestBox_7'
	
	Begin Object Class=moNumericEdit Name=BestBox_8
		MinValue=0
		Caption="Wave 9"
		IniOption="@Internal"
		OnLoadINI=TimerPanel.InternalOnLoadINI
	End Object
	Best8=moNumericEdit'TimerPanel.BestBox_8'
	
	Begin Object Class=moNumericEdit Name=BestBox_9
		MinValue=0
		Caption="Wave 10"
		IniOption="@Internal"
		OnLoadINI=TimerPanel.InternalOnLoadINI
	End Object
	Best9 = moNumericEdit'TimerPanel.BestBox_9'
	
	Begin Object Class=moNumericEdit Name=BestBox_10
		MinValue=0
		Caption="Wave 11"
		IniOption="@Internal"
		OnLoadINI=TimerPanel.InternalOnLoadINI
	End Object
	Best10 = moNumericEdit'TimerPanel.BestBox_10'
}
