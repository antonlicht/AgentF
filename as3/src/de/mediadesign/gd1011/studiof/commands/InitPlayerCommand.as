/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 06.02.13
 * Time: 09:42
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.commands
{
    import de.mediadesign.gd1011.studiof.events.GameEvent;
    import de.mediadesign.gd1011.studiof.manager.UnitManager;

    import robotlegs.bender.bundles.mvcs.Command;

    public class InitPlayerCommand extends Command
    {
        [Inject]
        public var event:GameEvent;
        [Inject]
        public var units:UnitManager;

        override public function execute():void
        {
            units.addPlayer(event.dataObj["platform"], event.dataObj["healthPoints"], event.dataObj["weapon"], event.dataObj["movement"]);
        }
    }
}
