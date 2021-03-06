/**
 * Created with IntelliJ IDEA.
 * User: maxfrank
 * Date: 31.01.13
 * Time: 11:46
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof
{
	import de.mediadesign.gd1011.studiof.command.ChangeUnitStateCommand;
	import de.mediadesign.gd1011.studiof.command.ContinueGameCommand;
	import de.mediadesign.gd1011.studiof.command.CreateBackgroundCommand;
	import de.mediadesign.gd1011.studiof.command.CreateFortCommand;
	import de.mediadesign.gd1011.studiof.command.DamageUnitCommand;
	import de.mediadesign.gd1011.studiof.command.DeleteUnitCommand;
	import de.mediadesign.gd1011.studiof.command.InitGameCommand;
	import de.mediadesign.gd1011.studiof.command.PauseGameCommand;
	import de.mediadesign.gd1011.studiof.command.RegisterBulletCommand;
	import de.mediadesign.gd1011.studiof.command.RemoveFromMoveprocessCommand;
	import de.mediadesign.gd1011.studiof.command.SpawnBossCommand;
	import de.mediadesign.gd1011.studiof.consts.GameConsts;
	import de.mediadesign.gd1011.studiof.model.LevelConfiguration;
	import de.mediadesign.gd1011.studiof.model.Score;
	import de.mediadesign.gd1011.studiof.services.CollisionProcess;
	import de.mediadesign.gd1011.studiof.services.GameLoop;
	import de.mediadesign.gd1011.studiof.services.LevelProcess;
	import de.mediadesign.gd1011.studiof.services.MoveProcess;
	import de.mediadesign.gd1011.studiof.services.RenderProcess;
	import de.mediadesign.gd1011.studiof.services.Rules;
	import de.mediadesign.gd1011.studiof.services.Sounds;
	import de.mediadesign.gd1011.studiof.view.BackgroundView;
	import de.mediadesign.gd1011.studiof.view.BulletView;
	import de.mediadesign.gd1011.studiof.view.EnemyView;
	import de.mediadesign.gd1011.studiof.view.GUI;
	import de.mediadesign.gd1011.studiof.view.GameView;
	import de.mediadesign.gd1011.studiof.view.LevelEndScreen;
	import de.mediadesign.gd1011.studiof.view.LoadingScreen;
	import de.mediadesign.gd1011.studiof.view.MainView;
	import de.mediadesign.gd1011.studiof.view.ScrollBackgroundView;
	import de.mediadesign.gd1011.studiof.view.StartScreenView;
	import de.mediadesign.gd1011.studiof.view.mediators.BackgroundViewMediator;
	import de.mediadesign.gd1011.studiof.view.mediators.BulletViewMediator;
	import de.mediadesign.gd1011.studiof.view.mediators.EnemyViewMediator;
	import de.mediadesign.gd1011.studiof.view.mediators.GUIMediator;
	import de.mediadesign.gd1011.studiof.view.mediators.GameViewMediator;
	import de.mediadesign.gd1011.studiof.view.mediators.LevelEndScreenMediator;
	import de.mediadesign.gd1011.studiof.view.mediators.LoadingScreenMediator;
	import de.mediadesign.gd1011.studiof.view.mediators.MainViewMediator;
	import de.mediadesign.gd1011.studiof.view.mediators.ScrollBackgroundViewMediator;
	import de.mediadesign.gd1011.studiof.view.mediators.StartScreenViewMediator;

	import flash.events.IEventDispatcher;

	import org.swiftsuspenders.Injector;

	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;

	import starling.utils.AssetManager;

	public class StarlingConfig
    {
        [Inject]
        public var modelMap:Injector;
        [Inject]
        public var mediatorMap:IMediatorMap;
        [Inject]
        public var commandMap:IEventCommandMap;
        [Inject]
        public var dispatcher:IEventDispatcher;

        [PostConstruct]
        public function configure():void
        {
            initModels();
            initCommands();
            initMediators();
        }

        private function initModels():void
        {
            modelMap.map(Score).asSingleton();
            modelMap.map(MoveProcess).asSingleton();
            modelMap.map(RenderProcess).asSingleton();
            modelMap.map(LevelProcess).asSingleton();
            modelMap.map(CollisionProcess).asSingleton();

            modelMap.map(GameLoop).asSingleton();
			modelMap.map(LevelConfiguration).asSingleton();
            modelMap.map(Rules).asSingleton();

			modelMap.map(AssetManager).asSingleton();
			modelMap.map(Sounds).asSingleton();
        }

        private function initCommands():void
        {
            commandMap.map(GameConsts.INIT_GAME).toCommand(InitGameCommand);
			commandMap.map(GameConsts.PAUSE).toCommand(PauseGameCommand);
			commandMap.map(GameConsts.CONTINUE).toCommand(ContinueGameCommand);
            commandMap.map(GameConsts.CREATE_BG).toCommand(CreateBackgroundCommand);
            commandMap.map(GameConsts.REGISTER_UNIT).toCommand(RegisterBulletCommand);
            commandMap.map(GameConsts.DELETE_UNIT).toCommand(DeleteUnitCommand);
            commandMap.map(GameConsts.DAMAGE_UNIT).toCommand(DamageUnitCommand);
            commandMap.map(GameConsts.BOSS_SPAWN).toCommand(SpawnBossCommand);
            commandMap.map(GameConsts.CHANGE_STATE).toCommand(ChangeUnitStateCommand);
            commandMap.map(GameConsts.REMOVE_FROM_MOVEPROCESS).toCommand(RemoveFromMoveprocessCommand);
			commandMap.map(GameConsts.REGISTER_FORT).toCommand(CreateFortCommand);
        }

        public function initMediators() : void
        {
            mediatorMap.map(MainView).toMediator(MainViewMediator);
			mediatorMap.map(StartScreenView).toMediator(StartScreenViewMediator);
			mediatorMap.map(GameView).toMediator(GameViewMediator);
			mediatorMap.map(GUI).toMediator(GUIMediator);
            mediatorMap.map(BackgroundView).toMediator(BackgroundViewMediator);
            mediatorMap.map(EnemyView).toMediator(EnemyViewMediator);
			mediatorMap.map(ScrollBackgroundView).toMediator(ScrollBackgroundViewMediator);
            mediatorMap.map(BulletView).toMediator(BulletViewMediator);
			mediatorMap.map(LoadingScreen).toMediator(LoadingScreenMediator);
			mediatorMap.map(LevelEndScreen).toMediator(LevelEndScreenMediator);

        }
    }
}
