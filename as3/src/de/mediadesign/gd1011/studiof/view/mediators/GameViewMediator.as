package de.mediadesign.gd1011.studiof.view.mediators {
    import de.mediadesign.gd1011.studiof.consts.GameConsts;
    import de.mediadesign.gd1011.studiof.events.GameEvent;
    import de.mediadesign.gd1011.studiof.model.Level;
    import de.mediadesign.gd1011.studiof.services.GameLoop;
    import de.mediadesign.gd1011.studiof.services.JSONReader;
    import de.mediadesign.gd1011.studiof.view.GameView;

    import flash.events.IEventDispatcher;

    import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

    import starling.events.EnterFrameEvent;
    import starling.events.Touch;
    import starling.events.TouchEvent;
    import starling.events.TouchPhase;

    public class GameViewMediator extends StarlingMediator
	{
		[Inject]
		public var contextView:GameView;

        [Inject]
        public var game:GameLoop;

		[Inject]
		public var level:Level;

        [Inject]
        public var dispatcher:IEventDispatcher;

		private var _touchConfig:Object;
		private var _validTouchID:int = -1;

		
		override public function initialize():void
		{
			_touchConfig = JSONReader.read("viewconfig")["game"];

			contextView.addEventListener(TouchEvent.TOUCH, handleTouch);
            contextView.addEventListener(EnterFrameEvent.ENTER_FRAME, game.update);

            addContextListener(GameConsts.ADD_SPRITE_TO_GAME, add);

            var initGameEvent:GameEvent = new GameEvent(GameConsts.INIT_GAME, GameConsts.INIT_GAME);
            dispatcher.dispatchEvent(initGameEvent);
		}

		override public function destroy():void
		{
            contextView.removeEventListener(TouchEvent.TOUCH, handleTouch);
            contextView.removeEventListener(EnterFrameEvent.ENTER_FRAME, game.update);
		}

		private function add(event:GameEvent):void
		{
			contextView.addChildAt(event.dataObj, contextView.numChildren);
		}

		private function handleTouch(e:TouchEvent):void
		{
			var vTouchPos:Number;
			var platform:int;

			//Handle starting touches
			var initTouches:Vector.<Touch> = e.getTouches(contextView, TouchPhase.BEGAN);
			for (var i:int = 0; i < initTouches.length; i++)
			{
				if (initTouches[i].getLocation(contextView).x <= _touchConfig["hTouch"])
				{
					vTouchPos = initTouches[i].getLocation(contextView).y;
					platform = getVTouchzone(vTouchPos);
					trace(platform);
					if(platform>=0 && _touchConfig["vTouch"][platform]<=vTouchPos && _touchConfig["vTouch"][platform+1]>=vTouchPos)
					{
						_validTouchID = initTouches[i].id;
						if(level.player != null && platform >=0 && platform != level.player.targetPlatform)
						{
							level.player.targetPlatform = platform;
						}
					}
				}
			}



			//Handle moves
			var touches:Vector.<Touch> = e.getTouches(contextView, TouchPhase.MOVED);
			for (var j:int = 0; j < touches.length; j++)
				if (touches[j].id == _validTouchID)
				{
					vTouchPos = touches[j].getLocation(contextView).y;
					platform = getVTouchzone(vTouchPos);
					trace(platform);
					if(level.player != null && platform >=0 && platform != level.player.targetPlatform)
					{
						level.player.targetPlatform = platform;
					}
				}

			//Handle end touch
			var endingTouches:Vector.<Touch> = e.getTouches(contextView, TouchPhase.ENDED);
			for (var k:int = 0; k < endingTouches.length; k++)
				if (endingTouches[k].id == _validTouchID)
				{
					if(level.player != null)
					{
						level.player.startJump();
						_validTouchID = -1;
					}

				}
		}

		private function getVTouchzone(vTouchPos:Number):int
		{
			for(var i:int = _touchConfig["vTouch"].length-1 ;i>=0;i--)
			{
				if(vTouchPos>=_touchConfig["vTouch"][i])
				{
					return i;
				}
			}
			return -1;
		}
	}
}
