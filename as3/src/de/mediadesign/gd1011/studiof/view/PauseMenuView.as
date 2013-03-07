/**
 * Created with IntelliJ IDEA.
 * User: anlicht
 * Date: 06.03.13
 * Time: 21:00
 * To change this template use File | Settings | File Templates.
 */
package de.mediadesign.gd1011.studiof.view
{
	import de.mediadesign.gd1011.studiof.services.JSONReader;

	import starling.display.Button;
	import starling.display.Sprite;
	import starling.utils.AssetManager;

	public class PauseMenuView extends Sprite
	{
		public var continueButton:Button;
		public function PauseMenuView(assets:AssetManager, level:Number)
		{
			addChild(assets.getImage("Lv"+(level+1)+"_PausenmenüHG"));

			continueButton = new TopSecretButton(Localization.getString("continue"),JSONReader.read("viewconfig")["startscreen"]["button-size"]);
			continueButton.x = (this.width-continueButton.width)/2;
			continueButton.y = (this.height-continueButton.height)/2;
			addChild(continueButton);
		}
	}
}