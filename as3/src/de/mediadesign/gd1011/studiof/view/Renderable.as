/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 07.02.13
 * Time: 11:32
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
    import de.mediadesign.gd1011.studiof.model.components.PositionComponent;

    import flash.geom.Point;

    import starling.display.Sprite;

    public class Renderable implements IRenderable
    {
        public var view:Sprite;
        public var position:PositionComponent;
        public var rotation:Number;

        public function Renderable(pos:PositionComponent){
            position = pos;
        }
        public function render():void
        {
            view.x = position.x;
            view.y = position.y;
            view.rotation = rotation;
        }
    }
}
