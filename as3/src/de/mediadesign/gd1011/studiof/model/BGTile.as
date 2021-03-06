/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 13.02.13
 * Time: 15:13
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.model
{
    import de.mediadesign.gd1011.studiof.model.components.PositionComponent;
    import de.mediadesign.gd1011.studiof.model.components.VelocityComponent;
	import de.mediadesign.gd1011.studiof.services.JSONReader;

	public class BGTile implements IMovable
    {
        private var _position:PositionComponent;
        private var _velocity:VelocityComponent;
		private var _layerID:String;
		private var _tileID:int;
		private var _renderable:Renderable;
		private var moving:Boolean = true;

        public function BGTile(layerID:String, tileID:int)
        {
			_layerID = layerID;
            _tileID = tileID;
			_position = new PositionComponent();
            _velocity = new VelocityComponent();

        }

		public function get layerID():String
		{
			return _layerID;
		}

        public function move(time:Number):void
        {
			if(moving)
           		_position.x -= velocity.velocityX*time;
        }

        public function get position():PositionComponent
        {
            return _position;
        }

        public function set position(value:PositionComponent):void
        {
            _position = value;
        }

        public function get velocity():VelocityComponent
        {
            return _velocity;
        }

        public function set velocity(value:VelocityComponent):void
        {
            _velocity = value;
        }

		public function get tileID():int
		{
			return _tileID;
		}

        public function stop():void {
			moving = false;
        }

        public function resume():void {
			moving = true;
        }

		public function dispose():void
		{
			_renderable.dispose();
		}

		public function set renderable(r:Renderable):void
		{
			_renderable = r;
		}
    }
}
