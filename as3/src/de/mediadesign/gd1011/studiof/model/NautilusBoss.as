/**
 * Created with IntelliJ IDEA.
 * User: kisalzmann
 * Date: 20.02.13
 * Time: 11:04
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.model
{
    import de.mediadesign.gd1011.studiof.consts.GameConsts;
    import de.mediadesign.gd1011.studiof.consts.ViewConsts;
    import de.mediadesign.gd1011.studiof.events.GameEvent;
    import de.mediadesign.gd1011.studiof.services.JSONReader;
    import de.mediadesign.gd1011.studiof.services.LevelProcess;

    public class NautilusBoss extends Unit implements IEndboss
    {
        private var timeCounter:Number = 0;
        private var idleTimeFrame:Number;
        private var upMovementRunning:Boolean = false;
        private var downMovementRunning:Boolean = false;
        private var changePosTime:Number;
        private var idleXPosition:int;
        private var movementSpeed:Number;
        private var yOffset:int = 2;
        private var _moveLeftRunning:Boolean = false;
        private var _initialized:Boolean = false;
        private var level:LevelProcess;
        private var backMovementDistance:int;
        private var _finishLine:int = 0;
        private var changePosMovementSpeed:Number = 0;
        private var xOffset:int;
        private var attackSpeed:Number;
        private var _ammunition:Vector.<Unit>;
        private var _scrollLevel:Boolean = true;
        private var _idleState:Boolean = true;

        public function NautilusBoss(currentLevel:LevelProcess, config:Object)
        {
            _ammunition = new Vector.<Unit>();
            changePosMovementSpeed = config["changePosMovementSpeed"];
            changePosTime = config["changePosTime"];
            xOffset = config["xOffset"];
            idleXPosition = config["idleXPosition"];
            idleTimeFrame = config["idleTimeFrame"];
            attackSpeed = config["attackSpeed"];
            backMovementDistance = GameConsts.STAGE_WIDTH+xOffset-idleXPosition;
            //trace("backMovementDistance im konstruktor: "+backMovementDistance);
            movementSpeed = backMovementDistance/changePosTime;
            level = currentLevel;
            _ammunition = new Vector.<Unit>();
            super(config["healthPoints"],config["startingPlatform"],0,idleXPosition, currentLevel, false, false, GameConsts.BOSS_SPAWN);
            position.x = GameConsts.STAGE_WIDTH+xOffset;
            state = GameConsts.IDLE;
            if (currentLevel.bossHaveLowLife) {
                healthPoints = 2;
            }
        }


		override public function stop():void
		{
			for (var index5:int = 0; index5<_ammunition.length; index5++)
			{
				_ammunition[index5].stop();
			}
			super.stop();
		}

		public function reset():void
        {
            position.x = GameConsts.STAGE_WIDTH+config["xOffset"];
            _initialized = false;
            healthPoints = config["healthpoints"];
            position.y = config["startingPlatform"]*GameConsts.PLATFORM_HEIGHT+yOffset;
        }

        public function start():void
        {   trace("NAUTILUS SPAWNED");
            _moveLeftRunning = true;
            var a:GameEvent = new GameEvent(GameConsts.BOSS_SPAWN);
            level.dispatcher.dispatchEvent(a);
        }

        override public function move(time:Number):void
        {
            currentPlatform = observePlatform(position.y);
            if (!stopped)
            {
                if (!upMovementRunning && !downMovementRunning && !_moveLeftRunning && _initialized)
                {
                    timeCounter+=time;
                    if (timeCounter >= idleTimeFrame)
                    {
                        timeCounter = 0;
                        _finishLine = currentPlatform;
                        while(_finishLine == currentPlatform)
                        {
                            _finishLine = Math.round((Math.random()*2)+3);
                        }
                        if (currentPlatform > _finishLine)
                        {
                            upMovementRunning = true;
                        }
                        else
                        {
                            downMovementRunning = true;
                        }
                    }
                }
                else
                {
                    if (upMovementRunning) {
                        doUpMovement(time);
                    }
                    if (downMovementRunning) {
                        doDownMovement(time);
                    }
                    if (_moveLeftRunning) {
                        doMoveLeft(time);
                    }
                }
            }
        }

        private function doMoveLeft(time:Number):void
        {
            if (position.x > idleXPosition)
            {
                position.x-=movementSpeed*time;
            }
            else
            {
                _moveLeftRunning = false;
                _initialized      = true;
            }
        }

        private function doDownMovement(time:Number):void
        {
            if (position.y+changePosMovementSpeed*time >= GameConsts.PLATFORM_HEIGHT*_finishLine)
            {
                state = GameConsts.IDLE;
                position.y = GameConsts.PLATFORM_HEIGHT*_finishLine+yOffset;
                downMovementRunning = false;
            }
            else
            {
                state = GameConsts.CHANGE;
                position.y+=changePosMovementSpeed*time;
            }
        }

        private function doUpMovement(time:Number):void
        {
            if (position.y-changePosMovementSpeed*time <= GameConsts.PLATFORM_HEIGHT*_finishLine+yOffset)
            {
                state = GameConsts.IDLE;
                position.y = GameConsts.PLATFORM_HEIGHT*_finishLine+yOffset;
                upMovementRunning = false;
            }
            else
            {
                state = GameConsts.CHANGE;
                position.y-=changePosMovementSpeed*time;
            }
        }

        override public function shoot(time:Number):Unit
        {
            cooldown += time;
            if (cooldown >= (1 / attackSpeed) && position.x<=idleXPosition && healthPoints > 0)
            {
                var bullet:Unit = new Unit(6, currentPlatform, -300, position.x, level, false, false);
                bullet.position.y += 100;
                _ammunition.push(bullet);
                cooldown = 0;
                state = GameConsts.IDLE;
                return bullet;
            }
            return null;
        }

        override public function shootBullet(time:Number):void
        {
            var bullet:Unit = shoot(time);
            if (bullet != null)
            {
                level.register(bullet, this);
            }
        }

        public function get moveLeftRunning():Boolean
        {
            return _moveLeftRunning;
        }

        public function get initialized():Boolean
        {
            return _initialized;
        }

		public function update(time:Number):void
		{
			if (initialized)
				shootBullet(time);
		}

		override public function resume():void
		{
			for (var index5:int = 0; index5<_ammunition.length; index5++)
			{
				_ammunition[index5].resume();
			}
			super.resume();
		}

        public function get scrollLevel():Boolean {
            return _scrollLevel;
        }

        public function get idleState():Boolean {
            return _idleState;
        }

        public function get ammunition():Vector.<Unit> {
            return _ammunition;
        }

        public function set ammunition(value:Vector.<Unit>):void {
            _ammunition = value;
        }
    }
}
