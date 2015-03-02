package com.davita.components.buttons
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class PanelCloseButton extends MovieClip
	{
		var helpPanel:MovieClip = parent as MovieClip;
		public function PanelCloseButton()
		{
			super();
			addEventListener(MouseEvent.CLICK, OnClickHandler);
		}

		private function OnClickHandler(evt:MouseEvent):void
		{
			helpPanel.closePanel();
		}
	}
}
