package customframe
{
	import customframe.Frame;
	import com.davita.components.buttons.WindowCloseButton;
	import com.davita.panels.help.HelpPanel;
	import com.junkbyte.console.Cc;
	/**
	 * This is the logic for the Frame symbol in the library (/Frame.)
	 *
	 * The Frame contains all the visual elements that make up the custom frame. It implements the wgIFrame interface
	 * and thus can be used as a frame for the Articulate player.
	 */
	public class FrameDavita extends Frame
	{
		public static const DEFAULT_WIDTH:int = 1000;
		public static const DEFAULT_HEIGHT:int = 750;

		private const MARGIN_LEFT:int = 0;
		private const MARGIN_RIGHT:int = 0;
		private const MARGIN_LOGO_TOP:int = 0;
		private const MARGIN_BUTTON_BOTTOM:int = 0;

		public var helpPanel:HelpPanel;

		public function FrameDavita()
		{
			//junkbyte console
			Cc.config.commandLineAllowed = true;
			Cc.start(this, "dbf");
		}

		override public function UpdateControls():void
		{
			this.background.width = 1000;
			this.background.height = 700;
			this.background.y = 50;

			this.slideContainer.x = 0;
			this.slideContainer.y = 69;
			this.slideContainer.width = 1000;
			this.slideContainer.height = 600;


			this.logo.visible = false;
			this.sidebar.visible = false;

			// Bottom bar
			var bShowBottomBar:Boolean = true;

			// Volume button - m_spVolume
			this.volumeButton.visible = true;
			this.volumeButton.x = 220;
			this.volumeButton.y = 690;

			// Control buttons
			this.controlButtons.ShowSubmit = (m_oControlManager.IsControlEnabled(SUBMIT) && bShowBottomBar);
			this.controlButtons.ShowSubmitAll = (m_oControlManager.IsControlEnabled(SUBMITALL) && bShowBottomBar);
			this.controlButtons.ShowFinish = (m_oControlManager.IsControlEnabled(FINISH) && bShowBottomBar);
			this.controlButtons.ShowNext = (m_oControlManager.IsControlEnabled(NEXT) && bShowBottomBar);
			this.controlButtons.ShowPrevious = (m_oControlManager.IsControlEnabled(PREVIOUS) && bShowBottomBar);
			this.controlButtons.x = this.width - 15 - this.controlButtons.width;
			this.controlButtons.y = 690;

			// Sidebar
			var bShowLogo:Boolean = false;
			var bShowElapsedTime:Boolean = false;

			this.infopanel.visible = false;
			this.sidebar.visible = false;
			this.background.SidebarBackgroundVisible = false;
			this.elapsedTimeField.visible = false;

			var leftPosition:int = 200;

			// Seekbar
			this.seekbar.x = 270;
			this.seekbar.y = 690;
			this.seekbar.width = this.controlButtons.x - this.seekbar.x;
			this.seekbar.visible = (m_oControlManager.IsControlEnabled(SEEKBAR) && bShowBottomBar);
			this.seekbar.ReplayButtonEnabled = (m_oControlManager.IsControlEnabled(REPLAY) && bShowBottomBar);
			this.seekbar.PlayPauseButtonEnabled = (m_oControlManager.IsControlEnabled(PAUSE_PLAY) && bShowBottomBar);

		}
/*
		override public function UpdateControls():void
		{
			// Bottom bar
			var bShowBottomBar:Boolean = m_oOptionManager.GetOptionAsBool(OptionManager.OPTGROUP_BOTTOMBAR, OptionManager.OPTION_BOTTOMBAR_ENABLED, true);

			// Volume button - m_spVolume
			this.volumeButton.visible = true;
			this.volumeButton.y = 750;

			// Control buttons
			this.controlButtons.ShowSubmit = (m_oControlManager.IsControlEnabled(SUBMIT) && bShowBottomBar);
			this.controlButtons.ShowSubmitAll = (m_oControlManager.IsControlEnabled(SUBMITALL) && bShowBottomBar);
			this.controlButtons.ShowFinish = (m_oControlManager.IsControlEnabled(FINISH) && bShowBottomBar);
			this.controlButtons.ShowNext = (m_oControlManager.IsControlEnabled(NEXT) && bShowBottomBar);
			this.controlButtons.ShowPrevious = (m_oControlManager.IsControlEnabled(PREVIOUS) && bShowBottomBar);
			this.controlButtons.x = this.width - MARGIN_RIGHT - this.controlButtons.width;
			this.controlButtons.y = this.height - (this.controlButtons.height + MARGIN_BUTTON_BOTTOM);

			// Sidebar
			var bShowLogo:Boolean = m_oOptionManager.GetOptionAsBool(OptionManager.OPTGROUP_SIDEBAR, OptionManager.OPTION_LOGO_ENABLED) && m_oOptionManager.GetOptionAsBool(OptionManager.OPTGROUP_SIDEBAR, OptionManager.OPTION_SIDEBAR_ENABLED);
			var bShowElapsedTime:Boolean = m_oOptionManager.GetOptionAsBool(OptionManager.OPTGROUP_CONTROLS, OptionManager.OPTION_CONTROLS_ELAPSEDANDTOTALTIME);

			if (bShowLogo)
			{
				this.logo.visible = true;
				this.logo.FileName = m_oOptionManager.GetOptionAsString(OptionManager.OPTGROUP_SIDEBAR, OptionManager.OPTION_LOGO_URL);
				this.logo.ImageWidth =  parseInt(m_oOptionManager.GetOptionProperty(OptionManager.OPTGROUP_SIDEBAR, OptionManager.OPTION_LOGO_URL, WIDTH));
				this.logo.ImageHeight =  parseInt(m_oOptionManager.GetOptionProperty(OptionManager.OPTGROUP_SIDEBAR, OptionManager.OPTION_LOGO_URL, HEIGHT));
				this.logo.Load();
				this.logo.height = this.logo.ImageHeight + 16;
				this.sidebar.y = this.logo.y + this.logo.height + 8;
				logo.DisplayFlatSide = m_bShowInfo;
			}
			else
			{
				this.logo.visible = false;
				this.sidebar.y = 8;
			}

			if (m_bShowInfo)
			{
				this.infopanel.visible = true;
				this.infopanel.y = this.sidebar.y;
				this.sidebar.y = this.infopanel.y + this.infopanel.height + 8;
				infopanel.DisplayFlatSide = bShowLogo;
			}
			else
			{
				this.infopanel.visible = false;
			}

			this.sidebar.height = this.height - this.sidebar.y - 12;

			if (bShowElapsedTime) {
				this.elapsedTimeField.visible = true;

				if (m_oTimeline.ElapsedTimeMode != ELAPSEDTIME_MODE_IGNORE)
				{
					UpdateElapsedTime();
				}
				m_oTimeline.addEventListener(wgEventTimeline.UPDATE_TIMELINE, UpdateTimelineStatus);
				m_oTimeline.addEventListener(wgEventTimeline.TIMELINE_CHANGED, UpdateTimelineStatus);
			}
			else
			{
				this.elapsedTimeField.visible = false;
			}

			var oSidebarList:OptionList = m_oOptionManager.GetOptionList(OptionManager.OPTGROUP_SIDEBAR, OptionManager.OPTLIST_TABS);
			var oOutlineOptions:OptionListItem = oSidebarList.GetListItemByName(CONTROL_OUTLINE);
			var bShowNotes:Boolean = (m_oControlManager.IsControlEnabled(TRANSCRIPT));
			var bShowGlossary:Boolean = (m_oControlManager.IsControlEnabled(GLOSSARY));
			var bShowResources:Boolean = m_oControlManager.IsControlEnabled(RESOURCES);
			var bShowMenu:Boolean = (m_oControlManager.IsControlEnabled(OUTLINE) && m_oOptionManager.GetOptionAsBool(OptionManager.OPTGROUP_SIDEBAR, OptionManager.OPTION_SIDEBAR_ENABLED));
			var bShowMenuPopup:Boolean = (m_oControlManager.IsControlEnabled(OUTLINE) && (oOutlineOptions.Group == OptionManager.LISTGROUP_LINKLEFT || oOutlineOptions.Group == OptionManager.LISTGROUP_LINKRIGHT));
			var bShowSidebar:Boolean = m_oOptionManager.GetOptionAsBool(OptionManager.OPTGROUP_SIDEBAR, OptionManager.OPTION_SIDEBAR_ENABLED) && (bShowNotes || bShowGlossary || bShowLogo || (bShowMenu && oOutlineOptions.Group == OptionManager.LISTGROUP_SIDEBAR));

			var leftPosition:int;

			if (bShowSidebar)
			{
				this.sidebar.visible = true;
				this.background.SidebarBackgroundVisible = true;
				this.slideContainer.x = this.background.SidebarBackgroundWidth + (this.width - this.background.SidebarBackgroundWidth - this.slideContainer.width) * 0.5;
				this.titleField.x = this.slideContainer.x;

				(bShowNotes) ? this.sidebar.ShowNotes() : this.sidebar.HideNotes();
				(bShowGlossary) ? this.sidebar.ShowGlossary() : this.sidebar.HideGlossary();
				(bShowMenu) ? this.sidebar.ShowMenu() : this.sidebar.HideMenu();
				leftPosition = this.sidebar.x + this.sidebar.width + (MARGIN_LEFT * 2);
			}
			else
			{
				this.sidebar.visible = false;
				this.background.SidebarBackgroundVisible = false;
				this.slideContainer.x = (this.width - this.slideContainer.width) * 0.5;
				this.titleField.x = MARGIN_LEFT;
				leftPosition = MARGIN_LEFT;
			}

			if (this.controlButtons.submitAllButton.visible)
			{
				this.controlButtons.submitAllButton.x = leftPosition - this.controlButtons.x;
				leftPosition = leftPosition + this.controlButtons.submitAllButton.width + MARGIN_LEFT;
			}

			if (this.volumeButton.visible)
			{
				this.volumeButton.x = leftPosition;
				leftPosition = this.volumeButton.x + this.volumeButton.width + MARGIN_LEFT;
			}

			// Seekbar
			this.seekbar.x = leftPosition;
			this.seekbar.width = this.controlButtons.x - this.seekbar.x;
			this.seekbar.visible = (m_oControlManager.IsControlEnabled(SEEKBAR) && bShowBottomBar);
			this.seekbar.ReplayButtonEnabled = (m_oControlManager.IsControlEnabled(REPLAY) && bShowBottomBar);
			this.seekbar.PlayPauseButtonEnabled = (m_oControlManager.IsControlEnabled(PAUSE_PLAY) && bShowBottomBar);
			this.seekbar.y = this.height - (this.seekbar.height + MARGIN_BUTTON_BOTTOM);

			if (bShowResources)
			{
				this.resourcesPopup.x = this.width - MARGIN_RIGHT - this.resourcesPopup.width
				this.resourcesPopup.visible = true;
			}
			else
			{
				this.resourcesPopup.visible = false;
			}

			if (bShowMenuPopup)
			{
				this.menuPopup.visible = true;
				this.titleField.y = 8;
				this.titleField.x = MARGIN_LEFT + 3;
				this.elapsedTimeField.y = 11;
				if (m_xmlData.@outputtype == OUTPUT_TYPE_QM)
				{
					this.menuPopup.UpdateLabel(MenuPopup.LABEL_QUESTION_LIST);
				}
				else
				{
					this.menuPopup.UpdateLabel(MenuPopup.LABEL_MENU);
				}
			}
			else
			{
				this.menuPopup.visible = false;
			}

			var nTitleBottom:Number = 0;
			var nVisibleBottom:Number = (bShowBottomBar) ? this.seekbar.y : this.height;

			if (m_oOptionManager.GetOptionAsBool(OptionManager.OPTGROUP_SIDEBAR, OptionManager.OPTION_TITLE_ENABLED))
			{
				nTitleBottom = this.titleField.y + this.titleField.textHeight;

				var strProjectTitle:String = m_oOptionManager.GetOptionAsString(OptionManager.OPTGROUP_SIDEBAR, OptionManager.OPTION_TITLE_TEXT);

				if (strProjectTitle != null)
				{
					SetTitle(strProjectTitle);
				}
			}
			else
			{
				this.titleField.visible = false;
			}

			this.slideContainer.y = nTitleBottom + (nVisibleBottom - nTitleBottom - this.slideContainer.height) * 0.5;
		}
*/

	}
}
