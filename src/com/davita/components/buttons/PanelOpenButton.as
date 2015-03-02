package com.davita.components.buttons
{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import com.davita.panels.help.HelpPanel;

	public class PanelOpenButton extends MovieClip
	{
		var helpPanel:HelpPanel = parent as HelpPanel;
		public function PanelOpenButton()
		{
			super();
			this.buttonMode = true;
			addEventListener(MouseEvent.CLICK, OnClickHandler);
		}

		private function OnClickHandler(evt:MouseEvent):void
		{
			if(helpPanel.bIsOpen)
			{
				helpPanel.closePanel();
			}
			else
			{
				helpPanel.openPanel();
			}
		}
	}
}
