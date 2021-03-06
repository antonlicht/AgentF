/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 26.02.13
 * Time: 15:03
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
	import de.mediadesign.gd1011.studiof.services.JSONReader;

	import starling.animation.Tween;
	import starling.core.Starling;

	import starling.display.Image;
	import starling.display.Quad;
	import starling.display.Sprite;

	public class ProgressBar extends Sprite
	{
		private var _width:Number;
		private var _height:Number;

		private var _border:Image;
		private var _bar:Sprite;

		private var _progress:Number = 0;

		private var _onLoad:Function;

		public function ProgressBar(width:Number, height:Number, borderAsset:Image)
		{
			_progress = 0;
			_width = width;
			_height = height;
			_border = borderAsset;
			var q:Quad = new Quad(_width,_height,JSONReader.read("viewconfig")["startscreen"]["progressbar"]["color"]);
			_bar = new Sprite();
			_border.y = _height-3;
			_bar.addChild(_border);
			_bar.addChild(q);
			_bar.y = -_bar.height
			addChild(_bar);

		}

		public function set progress(state:Number):void
		{
			var progress:Number = Math.max(0,Math.min(1,state));
			_bar.y =_bar.height*progress-_bar.height;
			_progress = progress;
			if(_onLoad!= null && _progress == 1)
				_onLoad.apply();
		}

		public function set onLoad(f:Function):void
		{
			_onLoad = f;
		}
	}
}
