package de.mediadesign.gd1011.studiof.assets
{
    import flash.display.Bitmap;
    import flash.media.Sound;
    import flash.utils.ByteArray;
    import flash.utils.Dictionary;
    
    import starling.text.BitmapFont;
    import starling.text.TextField;
    import starling.textures.Texture;
    import starling.textures.TextureAtlas;

    public class Assets
    {
        // If you're developing a game for the Flash Player / browser plugin, you can directly
        // embed all textures directly in this class. This demo, however, provides two sets of
        // textures for different resolutions. That's useful especially for mobile development,
        // where you have to support devices with different resolutions.
        //
        // For that reason, the actual embed statements are in separate files; one for each
        // set of textures. The correct set is chosen depending on the "contentScaleFactor".
        
        // TTF-Fonts
        
        // The 'embedAsCFF'-part IS REQUIRED!!!!
		
		//[Embed(source="../assets/audio/shot.mp3", embedAsCFF="false", fontFamily="Ubuntu")]        
        //private static const UbuntuRegular:Class;
		
        // Texture cache
        
//        [Embed(source="../assets/textures/Spermdit_small.png")]
//        private static const SpermditImage:Class;
//
//		[Embed(source="../assets/textures/SpermiGonzalez_small.png")]
//        private static const SpermiGonzalezImage:Class;
//
//		[Embed(source="../assets/textures/Spermianer_small.png")]
//        private static const SpermianerImage:Class;
//
//		[Embed(source="../assets/textures/background.png")]
//		private static const Background:Class;
//
//		[Embed(source="../assets/textures/pilly_small2.png")]
//		private static const Player:Class;
//
//		[Embed(source="../assets/textures/patrone_small.png")]
//		private static const Fire:Class;
//
//        [Embed(source="../assets/textures/powerUp_life.png")]
//		private static const PowerUp_Life:Class;
//
//		[Embed(source="../assets/textures/powerUp_shot.png")]
//		private static const PowerUp_Shot:Class;
//
//		[Embed(source="../assets/textures/start_button.png")]
//		private static const StartButton:Class;
		
		// Sounds
		
       // [Embed(source="../assets/audio/shot.mp3")]
        //private static const ShotSound:Class;
        
        private static var sContentScaleFactor:int = 1;
        private static var sTextures:Dictionary = new Dictionary();
        private static var sSounds:Dictionary = new Dictionary();
        private static var sTextureAtlas:TextureAtlas;
        private static var sBitmapFontsLoaded:Boolean;
        
        public static function getTexture(name:String):Texture
        {
            if (sTextures[name] == undefined)
            {
                var data:Object = create(name);
                
                if (data is Bitmap)
                    sTextures[name] = Texture.fromBitmap(data as Bitmap, true, false, sContentScaleFactor);
                else if (data is ByteArray)
                    sTextures[name] = Texture.fromAtfData(data as ByteArray, sContentScaleFactor);
            }
            
            return sTextures[name];
        }
        
        public static function getSound(name:String):Sound
        {
            var sound:Sound = sSounds[name] as Sound;
            if (sound) return sound;
            else throw new ArgumentError("Sound not found: " + name);
        }
        
        public static function getTextureAtlas():TextureAtlas
        {
            if (sTextureAtlas == null)
            {
                var texture:Texture = getTexture("AtlasTexture");
                var xml:XML = XML(create("AtlasXml"));
                sTextureAtlas = new TextureAtlas(texture, xml);
            }
            
            return sTextureAtlas;
        }
        
        public static function loadBitmapFonts():void
        {
            if (!sBitmapFontsLoaded)
            {
                var texture:Texture = getTexture("DesyrelTexture");
                var xml:XML = XML(create("DesyrelXml"));
                TextField.registerBitmapFont(new BitmapFont(texture, xml));
                sBitmapFontsLoaded = true;
            }
        }
        
        public static function prepareSounds():void
        {
            //sSounds["Step"] = new StepSound();   
        }
        
        private static function create(name:String):Object
        {
            //var textureClass:Class = sContentScaleFactor == 1 ? AssetEmbeds_1x : AssetEmbeds_2x;
			var textureClass:Class = Assets;
            return new textureClass[name];
        }
        
        public static function get contentScaleFactor():Number { return sContentScaleFactor; }
        public static function set contentScaleFactor(value:Number):void 
        {
            for each (var texture:Texture in sTextures)
                texture.dispose();
            
            sTextures = new Dictionary();
            sContentScaleFactor = value < 1.5 ? 1 : 2; // assets are available for factor 1 and 2 
        }
    }
}