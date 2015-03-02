package com.davita.panels.help
{
	import flash.display.MovieClip;
	import com.davita.components.buttons.PanelOpenButton;
	import flash.events.MouseEvent;

	/**
	 * This is the logic for the ResourcesPanel symbol in the library (/panels/resources/ResourcesPanel.)
	 *
	 * The ResourcesPanel contains a list that is populated with ResourcelistItems.
	 *
	 */
	public class HelpPanel extends MovieClip
	{
//		public var helpButton:TestButton;
		public var bIsOpen:Boolean;

		public function HelpPanel()
		{
			super();
			stop();
		}

		public function openPanel():void
		{
			gotoAndStop(2);
			bIsOpen = true;
		}

		public function closePanel():void
		{
			gotoAndStop(1);
			bIsOpen = false;

		}
	}
}
