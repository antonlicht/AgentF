/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 22.02.13
 * Time: 11:36
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.services
{
    import de.mediadesign.gd1011.studiof.consts.GameConsts;
    import de.mediadesign.gd1011.studiof.consts.ViewConsts;
    import de.mediadesign.gd1011.studiof.events.GameEvent;
    import de.mediadesign.gd1011.studiof.model.NautilusBoss;
    import de.mediadesign.gd1011.studiof.model.Unit;

    import flash.events.IEventDispatcher;

    public class CollisionProcess implements IProcess
    {
        [Inject]
        public var level:LevelProcess;

        [Inject]
        public var rules:Rules;

        [Inject]
        public var dispatcher:IEventDispatcher;

        private var _running:Boolean;

        public function update(time:Number):void
        {
            for (var i:int = 0; i < level.player.ammunition.length; i++)
            {
                // collision Boss
                if (level.boss.initialized)
                {
                    rules.collisionDetection(level.player.ammunition[i], level.boss as Unit);
                    if (level.boss is NautilusBoss)
                    {
                        for (var j:int = 0; j < (level.boss as NautilusBoss).ammunition.length; j++)
                        {
                            rules.collisionDetection(level.player.ammunition[i], (level.boss as NautilusBoss).ammunition[j]);
                            rules.collisionDetection(level.player, (level.boss as NautilusBoss).ammunition[j]);

                            if (rules.isDead((level.boss as NautilusBoss).ammunition[j]))
                            {
                                deleteUnits((level.boss as NautilusBoss).ammunition, j);
                                break;
                                break;
                            }
                        }
                    }
                }
                if (rules.isDead(level.player.ammunition[i]))
                {
                    deleteUnits(level.player.ammunition, i);
                    break;
                    break;
                }

                for (var j:int = 0; j < level.enemies.length; j++)
                {
                    //collision playerbullet, enemy
                    rules.collisionDetection(level.player.ammunition[i], level.enemies[j]);

                    if (rules.isDead(level.enemies[j]))
                    {
                        deleteUnits(level.enemies, j);
                        var updatePointsEvent:GameEvent = new GameEvent(ViewConsts.ENEMY_KILLED);
                        dispatcher.dispatchEvent(updatePointsEvent);
                        break;
                        break;
                    }
                    if (level.enemies[j].position.x < 0 - GameConsts.ENEMY_SPRITE_WIDTH)
                        deleteUnits(level.enemies, j);
                }
                if (level.player.ammunition[i].position.x > GameConsts.STAGE_WIDTH + GameConsts.ENEMY_SPRITE_WIDTH)
                    deleteUnits(level.player.ammunition, i);
            }

            for (var i:int = 0; i < level.enemies.length; i++)
            {
                //collision player, enemy
                rules.collisionDetection(level.player, level.enemies[i]);

                if (rules.isDead(level.enemies[i]))
                {
                    deleteUnits(level.enemies, i);
                    var updatePointsEvent:GameEvent = new GameEvent(ViewConsts.ENEMY_KILLED);
                    dispatcher.dispatchEvent(updatePointsEvent);
                    break;
                    break;
                }
            }
            for (var i:int = 0; i < level.enemieBullets.length; i++)
            {
                rules.collisionDetection(level.player, level.enemieBullets[i]);
                if (rules.isDead(level.enemieBullets[i]))
                {
                    deleteUnits(level.enemieBullets, i);
                    var updatePointsEvent:GameEvent = new GameEvent(ViewConsts.ENEMY_KILLED);
                    dispatcher.dispatchEvent(updatePointsEvent);
                    break;
                    break;
                }
            }
        }

        public function deleteUnits(units:Vector.<Unit>, index:int):void
        {
            level.deleteCurrentUnit(units[index]);
            units.splice(index,  1);
        }

        public function start():void
        {
            _running = true
        }

        public function stop():void
        {
            _running = false;
        }
    }
}
