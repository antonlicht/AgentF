/**
 * Created with IntelliJ IDEA.
 * User: kisalzmann
 * Date: 08.02.13
 * Time: 14:51
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.services {
    import de.mediadesign.gd1011.studiof.model.components.Moveable;

    public class MoveProcess implements IProcess
    {
        private var targets:Vector.<Moveable>;

        public function update():void
        {
            for each(var target:Moveable in targets)
            {
                target.move();
            }
        }

        public function addEntity(target:Moveable):void{
            targets.push(target);
        }
    }
}
