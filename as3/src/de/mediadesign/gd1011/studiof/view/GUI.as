/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 05.02.13
 * Time: 09:59
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;

	public class GUI extends Sprite
    {

		private var _centerCenter:Sprite;

		private var _lifepoints:TextField;
		private var _gameOverScreen:TextField;
		public function GUI()
        {
			_centerCenter = new Sprite();
			addChild(_centerCenter);

			_lifepoints = new TextField(100,100,"3","Verdana",60,0xffffff,true);
			addChild(_lifepoints);

			if(stage)
				adjust();
			else
				addEventListener(Event.ADDED_TO_STAGE,adjust);


        }

		private function adjust(e:Event=null):void
		{
			_centerCenter.x = getWidth()/2;
			_centerCenter.y = getHeight()/2;

		}

		private function getWidth():Number
		{
			if(stage)
				return stage.stageWidth/scaleX;
			return 0;
		}

		private function getHeight():Number
		{
			if(stage)
				return stage.stageHeight/scaleY;
			return 0;
		}

		public function setLifepoints(points:int):void
		{
			_lifepoints.text=points.toString();
		}

		public function showGameOver(won:Boolean):void
		{
			_gameOverScreen = new TextField(600,100,"","Verdana",60,0xffffff,true);
			_gameOverScreen.x = -_gameOverScreen.width/2;
			_gameOverScreen.y = -_gameOverScreen.height/2;
			if(won)
				_gameOverScreen.text="Gewonnen, Hase!";
			else
				_gameOverScreen.text="Verloren, leider!"
			_centerCenter.addChild(_gameOverScreen);
		}
    }
}
