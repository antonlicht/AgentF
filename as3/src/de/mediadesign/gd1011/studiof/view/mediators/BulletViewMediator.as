/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 26.02.13
 * Time: 17:58
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view.mediators
{
    import de.mediadesign.gd1011.studiof.model.FortFoxBoss;
    import de.mediadesign.gd1011.studiof.model.NautilusBoss;
    import de.mediadesign.gd1011.studiof.model.Player;
    import de.mediadesign.gd1011.studiof.services.GameJuggler;
    import de.mediadesign.gd1011.studiof.services.Sounds;
    import de.mediadesign.gd1011.studiof.view.BulletView;

    import flash.events.IEventDispatcher;

    import robotlegs.extensions.starlingViewMap.impl.StarlingMediator;

    import starling.display.Image;
    import starling.display.MovieClip;
    import starling.utils.AssetManager;

    public class BulletViewMediator extends StarlingMediator
    {
        [Inject]
        public var bulletView:BulletView;

        [Inject]
        public var dispatcher:IEventDispatcher;

        [Inject]
        public var assets:AssetManager;

        [Inject]
        public var sounds:Sounds;

        override public function initialize():void
        {
            if (bulletView.master is Player)
            {
                sounds.play("shot", 0.5);
                var img:Image = new Image(assets.getTexture("Bullet"));
                img.y = 20;
                bulletView.addChild(img);

            }
            else if (bulletView.master is NautilusBoss)
            {
                var img:Image = new MovieClip(assets.getTextures("SeaMine_"), 30);
				GameJuggler.add(img as MovieClip);
                (img as MovieClip).play();
                img.y = -60;
                bulletView.addChild(img);
            }
            else if (!(bulletView.master is Player) && !(bulletView.master is NautilusBoss) && !(bulletView.master is FortFoxBoss))
            {
                switch(bulletView.master.currentPlatform)
                {
                    case(0):
                        sounds.play("laugh", 0.8);
                        var img:Image = new Image(assets.getTexture("Bomb"));
                        img.x = -140;
                        img.y = -160;
                        bulletView.addChild(img);
                        break;
                    case(1):
                        sounds.play("laugh", 0.8);
                        var img:Image = new Image(assets.getTexture("Bomb"));
                        img.x = -140;
                        img.y = -160;
                        bulletView.addChild(img);
                        break;
                    case(3):
                        sounds.play("harpune", 1);
                        var img:Image = new Image(assets.getTexture("Arrow"));
                        img.x = 200;
                        img.y = 60;
                        bulletView.addChild(img);
                        break;
                    case(4):
                        sounds.play("harpune", 1);
                        var img:Image = new Image(assets.getTexture("Arrow"));
                        img.x = 200;
                        img.y = 60;
                        bulletView.addChild(img);
                        break;
                    case(5):
                        sounds.play("harpune", 1);
                        var img:Image = new Image(assets.getTexture("Arrow"));
                        img.x = 200;
                        img.y = 60;
                        bulletView.addChild(img);
                        break;
                    default:
                        break;
                }
            }
        }
    }
}
