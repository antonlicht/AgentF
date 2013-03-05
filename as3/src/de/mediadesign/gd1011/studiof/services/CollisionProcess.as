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
                if (rules.isDead(level.player.ammunition[i]))
                {
                    deleteUnits(level.player.ammunition, i);
                    break;
                    break;
                }
                // collision Boss
                if (level.boss.initialized)
                {
                    if (level.boss.idleState)
                    {
                        rules.collisionDetection(level.player.ammunition[i], level.boss as Unit);
                    }
                    if (level.boss is NautilusBoss)
                    {
                        for (var j:int = 0; j < (level.boss as NautilusBoss).ammunition.length; j++)
                        {
                            rules.collisionDetection(level.player, (level.boss as NautilusBoss).ammunition[j]);
                            rules.collisionDetection(level.player.ammunition[i], (level.boss as NautilusBoss).ammunition[j]);

                            if (rules.isDead((level.boss as NautilusBoss).ammunition[j]))
                            {
                                deleteUnits((level.boss as NautilusBoss).ammunition, j);
                                break;
                                break;
                            }
                        }
                    }
                }
                // collision SeaMine , Player
                for (var j:int = 0; j < level.enemies.length; j++)
                {
                    //collision playerbullet, enemy
                    rules.collisionDetection(level.player.ammunition[i], level.enemies[j]);

                    if (rules.isDead(level.enemies[j]))
                    {
                        if (level.enemies[j].currentPlatform == 2)
                            deleteUnits(level.enemies, j);
                        else
                            level.enemies.splice(j, 1);

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
                if (level.enemies[i].currentPlatform == 2)
                {
                    rules.collisionDetection(level.player, level.enemies[i]);
                }

                if (rules.isDead(level.enemies[i]))
                {
                    deleteUnits(level.enemies, i);/*
                    var updatePointsEvent:GameEvent = new GameEvent(ViewConsts.ENEMY_KILLED);
                    dispatcher.dispatchEvent(updatePointsEvent);*/
                    break;
                    break;
                }
            }
            for (var i:int = 0; i < level.enemieBullets.length; i++)
            {
                if (!level.enemieBullets[i].verticalBullet)
                {
                    rules.collisionDetection(level.player, level.enemieBullets[i]);
                }
                else
                {
                    if (level.enemieBullets[i].healthPoints > 0 && level.enemieBullets[i].position.y > level.player.position.y)
                    {
                        level.enemieBullets[i].healthPoints-=1;
                        level.player.healthPoints-=1;
                        var a:GameEvent = new GameEvent(ViewConsts.EXPLOSION, level.enemieBullets[i]);
                        dispatcher.dispatchEvent(a);
                    }
                }
                if (rules.isDead(level.enemieBullets[i]))
                {
                    deleteUnits(level.enemieBullets, i);/*
                    var updatePointsEvent:GameEvent = new GameEvent(ViewConsts.ENEMY_KILLED);
                    dispatcher.dispatchEvent(updatePointsEvent);*/
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
