package customframe.components.buttons
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	import com.articulate.wg.v2_0.wgEventFrame;

	/**
	 * This is the logic for the ControlButtons symbol in the library (/components/buttons/ControlButtons.)
	 *
	 * The ControlButtons contain the Next, Prev and Submit buttons. Each button can be shown or hidden.
	 *
	 * A wgEventFrame is dispatched whenever one of the buttons is clicked.
	 */
	public class ControlButtons extends Sprite
	{
		public static const LEFT_MARGIN:int = 14;
		public static const BUTTON_GAP:int = 8;

		public static const SUBMIT_PRESSED:String = "submit_pressed";
		public static const NEXT_PRESSED:String = "next_pressed";
		public static const PREV_PRESSED:String = "prev_pressed";

		public var nextButton:SimpleButton;
		public var previousButton:SimpleButton;
		public var submitButton:SimpleButton;

		private var m_oLeftMostButton:SimpleButton = null;
		private var m_oSecondMostButton:SimpleButton = null;
		private var m_oThirdMostButton:SimpleButton = null;

		public function ControlButtons()
		{
			super();
			this.ShowSubmit = false;
			this.nextButton.addEventListener(MouseEvent.CLICK, NextButton_onClick);
			this.previousButton.addEventListener(MouseEvent.CLICK, PreviousButton_onClick);
			this.submitButton.addEventListener(MouseEvent.CLICK, SubmitButton_onClick);
		}

		public function get ShowNext():Boolean
		{
			return this.nextButton.visible;
		}

		public function set ShowNext(value:Boolean):void
		{
			this.nextButton.visible = value;
			Update();
		}

		public function get ShowPrevious():Boolean
		{
			return this.previousButton.visible;
		}

		public function set ShowPrevious(value:Boolean):void
		{
			this.previousButton.visible = value;
			Update();
		}

		public function get ShowSubmit():Boolean
		{
			return this.submitButton.visible;
		}

		public function set ShowSubmit(value:Boolean):void
		{
			this.submitButton.visible = value;
			Update();
		}

		override public function get width():Number
		{
			var nWidth:Number = 0;

			if (m_oSecondMostButton != null)
			{
				nWidth = m_oSecondMostButton.x + m_oSecondMostButton.width;
			}
			else if (m_oLeftMostButton != null)
			{
				nWidth = m_oLeftMostButton.x + m_oLeftMostButton.width;
			}

			return nWidth;
		}

		private function Update():void
		{
			m_oLeftMostButton = null;
			m_oSecondMostButton = null;
			m_oThirdMostButton = null;

			if (this.nextButton.visible)
			{
				m_oLeftMostButton = this.nextButton;
			}

			if (this.previousButton.visible)
			{
				m_oLeftMostButton = this.previousButton;
				if (this.nextButton.visible)
				{
					m_oSecondMostButton = this.nextButton;
				}
			}

			if (this.submitButton.visible)
			{
				m_oLeftMostButton = this.submitButton;

				if (this.previousButton.visible)
				{
					m_oSecondMostButton = this.previousButton;
					if (this.nextButton.visible)
					{
						m_oThirdMostButton = this.nextButton;
					}
				}
				else if (this.nextButton.visible)
				{
					m_oSecondMostButton = this.nextButton;
				}
			}
			if (m_oLeftMostButton != null)
			{
				m_oLeftMostButton.x = LEFT_MARGIN;

				if (m_oSecondMostButton != null)
				{
					m_oSecondMostButton.x = m_oLeftMostButton.x + m_oLeftMostButton.width + BUTTON_GAP;
				}

				if (m_oThirdMostButton != null)
				{
					m_oThirdMostButton.x = m_oSecondMostButton.x + m_oSecondMostButton.width + BUTTON_GAP;
				}
			}
		}

		private function SubmitButton_onClick(evt:MouseEvent):void
		{
			var evtFrame:wgEventFrame = new wgEventFrame(wgEventFrame.TRIGGER_CUSTOM_EVENT);
			evtFrame.Id = SUBMIT_PRESSED;
			dispatchEvent(evtFrame);
		}

		private function NextButton_onClick(evt:MouseEvent):void
		{
			var evtFrame:wgEventFrame = new wgEventFrame(wgEventFrame.TRIGGER_CUSTOM_EVENT);
			evtFrame.Id = NEXT_PRESSED;
			dispatchEvent(evtFrame);
		}

		private function PreviousButton_onClick(evt:MouseEvent):void
		{
			var evtFrame:wgEventFrame = new wgEventFrame(wgEventFrame.TRIGGER_CUSTOM_EVENT);
			evtFrame.Id = PREV_PRESSED;
			dispatchEvent(evtFrame);
		}
	}
}