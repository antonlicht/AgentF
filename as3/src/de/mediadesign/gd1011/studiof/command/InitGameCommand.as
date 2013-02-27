/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 12.02.13
 * Time: 13:39
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.command
{
    import de.mediadesign.gd1011.studiof.consts.GameConsts;
    import de.mediadesign.gd1011.studiof.consts.ViewConsts;
    import de.mediadesign.gd1011.studiof.events.GameEvent;
    import de.mediadesign.gd1011.studiof.model.FortFoxBoss;
    import de.mediadesign.gd1011.studiof.model.NautilusBoss;
	import de.mediadesign.gd1011.studiof.services.JSONReader;
	import de.mediadesign.gd1011.studiof.services.LevelProcess;
    import de.mediadesign.gd1011.studiof.model.NautilusBoss;
    import de.mediadesign.gd1011.studiof.model.Player;
    import de.mediadesign.gd1011.studiof.model.Renderable;
	import de.mediadesign.gd1011.studiof.model.BGTile;
	import de.mediadesign.gd1011.studiof.services.CollisionProcess;
    import de.mediadesign.gd1011.studiof.services.GameLoop;
    import de.mediadesign.gd1011.studiof.services.MoveProcess;
    import de.mediadesign.gd1011.studiof.services.RenderProcess;
    import de.mediadesign.gd1011.studiof.view.EnemyView;

    import flash.events.IEventDispatcher;
	import flash.utils.getDefinitionByName;

	import robotlegs.bender.bundles.mvcs.Command;

    public class InitGameCommand extends Command
    {
        [Inject]
        public var gameLoop:GameLoop;

        [Inject]
        public var moveProcess:MoveProcess;

        [Inject]
        public var renderProcess:RenderProcess;

        [Inject]
        public var collisionProcess:CollisionProcess;

        [Inject]
        public var level:LevelProcess;

        [Inject]
        public var dispatcher:IEventDispatcher;

        override public function execute():void
        {
			level.setPlayer(new Player(level));

            moveProcess.addEntity(level.player);
            level.boss = new (getDefinitionByName("de.mediadesign.gd1011.studiof.model."+JSONReader.read("level/level")[0][level.currentLevel]["endboss"]) as Class)(level);

            var playerView:EnemyView = new EnemyView(ViewConsts.PLAYER, ViewConsts.PLAYER);

            gameLoop.registerProcess(moveProcess);
            gameLoop.registerProcess(renderProcess);
            gameLoop.registerProcess(collisionProcess);
            gameLoop.registerProcess(level);

            renderProcess.registerRenderable(new Renderable(level.player.position, playerView));
            var addSpriteToGameEvent:GameEvent = new GameEvent(ViewConsts.ADD_SPRITE_TO_GAME, playerView);
            dispatcher.dispatchEvent(addSpriteToGameEvent);
        }
    }
}
