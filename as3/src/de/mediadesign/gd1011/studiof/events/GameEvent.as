/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 05.02.13
 * Time: 14:39
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.events
{
    import flash.events.Event;

    public class GameEvent extends Event
    {
        public var dataObj:*;

        public function GameEvent(type:String, dataObj:* = null)
        {
            super(type, false, false);
            this.dataObj = dataObj;
        }
    }
}
