package com.davita.components.buttons
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.external.ExternalInterface;
	import flash.events.MouseEvent;

	public class WindowCloseButton extends SimpleButton
	{

		public function WindowCloseButton()
		{
			super();
			addEventListener(MouseEvent.CLICK, WindowCloseButton_onClick);
		}

		private function WindowCloseButton_onClick(evt:MouseEvent):void
		{
			ExternalInterface.call("onBWEvent", "BW_ClosePlayer");
		}
	}
}
