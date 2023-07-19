package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.addons.display.FlxBackdrop;
import flixel.util.FlxTimer;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flash.system.System;
import Achievements;
import lime.app.Application;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;
import openfl.filters.ShaderFilter;
import Shaders;
import openfl.display.Shader;

using StringTools;

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.6.2'; //This is also used for Discord RPC
	public static var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;
	var debugKeys:Array<FlxKey>;
	private var camGame:FlxCamera;
	
	var optionShit:Array<String> = [
	'Freeplay', 
	'Options', 
	'Credits',
	'Quit',
	'Twitter',
	'Discord'
    ];

	var magenta:FlxSprite;
	public static var finishedFunnyMove:Bool = false;
	public static var FreeplayUnlocked:Bool = false;

	var starFG:FlxBackdrop;
	var starBG:FlxBackdrop;
	var vignette:FlxSprite;
	var logo2:FlxSprite;
	var logo:FlxSprite;

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Main Menu", null);
		#end
		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));

		camGame = new FlxCamera();
		FlxG.cameras.reset(camGame);
		FlxCamera.defaultCameras = [camGame];

		persistentUpdate = persistentDraw = true;

		FlxG.mouse.visible = true;

		var shader:Shaders.ChromaticAberrationEffect = new Shaders.ChromaticAberrationEffect();
		shader.setChrome(0.003);
		FlxG.camera.setFilters([new ShaderFilter(shader.shader)]);

		var bg:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		bg.scrollFactor.set();
		add(bg);

		starFG = new FlxBackdrop(Paths.image('mainmenu/mainmenuV4/starFG'), XY);
		starFG.antialiasing = ClientPrefs.globalAntialiasing;
		add(starFG);

		starBG = new FlxBackdrop(Paths.image('mainmenu/mainmenuV4/starBG'), XY);
		starBG.antialiasing = ClientPrefs.globalAntialiasing;
		add(starBG);

		var visorx:FlxSprite = new FlxSprite(1066.9, 527.05).loadGraphic(Paths.image('menu_assets/visorx'));
		visorx.updateHitbox();
		visorx.antialiasing = true;
		//add(visorx);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		logo = new FlxSprite(680, 100);
		logo.frames = Paths.getSparrowAtlas('logoBumpin');
		logo.animation.addByPrefix('idle', 'logo bumpin', 24, true);
		logo.setGraphicSize(Std.int(logo.width * 0.70));
		logo.updateHitbox();
		//add(logo);

		for (i in 0...optionShit.length)
		{
			var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
			var menuItem:FlxSprite = new FlxSprite(0, (i * 140)  + offset);
	        menuItem.frames = Paths.getSparrowAtlas('mainmenu/mainmenuV4/mainmenuStuff');
			menuItem.animation.addByPrefix('idle', optionShit[i] + 'Idle', 24, true);
			menuItem.animation.addByPrefix('hover', optionShit[i] + 'Hover', 24, true);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItem.antialiasing = true;
			menuItem.updateHitbox();
			menuItem.scrollFactor.set();
			switch(i) {
				case 0:
					menuItem.setPosition(305, 297);
				case 1:
					menuItem.setPosition(376.9, -89.45);
					FlxTween.tween(menuItem, {y: 0}, 1, {ease: FlxEase.expoOut});
				case 2:
					menuItem.setPosition(-147, 598.75);
					FlxTween.tween(menuItem, {x: 14.8}, 1, {ease: FlxEase.expoOut});
				case 3:
			        menuItem.setPosition(1295.45, 645.3);
					FlxTween.tween(menuItem, {x: 1015.9}, 1, {ease: FlxEase.expoOut});
				case 4:
					menuItem.setPosition(16, -157.45);
					FlxTween.tween(menuItem, {y: 12}, 1, {ease: FlxEase.expoOut});
				case 5:
					menuItem.setPosition(16, -105.35);
					FlxTween.tween(menuItem, {y: 115.3}, 1, {ease: FlxEase.expoOut});
			}
			menuItems.add(menuItem);
		}

		Application.current.window.title = "Novisor Funkin' - Main Menu";

	    var versionShit:FlxText = new FlxText(12, FlxG.height - 24, 0, "Novisor Funkin' v4.0 Demo", 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 20, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		versionShit.screenCenter(X);
		add(versionShit);

		// NG.core.calls.event.logEvent('swag').send();

		changeItem();

		super.create();
	}

	var selectedSomethin:Bool = false;

	var canClick:Bool = true;
	var usingMouse:Bool = false;

	override function update(elapsed:Float)
	{
		starFG.x -= 0.03;
		starBG.x -= 0.01;
		
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if (!selectedSomethin)
		{

			if (controls.BACK)
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('cancelMenu'));
					MusicBeatState.switchState(new TitleState());
				}
			
			    menuItems.forEach(function(spr:FlxSprite)
				{
					
					if(usingMouse)
					{
						if(!FlxG.mouse.overlaps(spr))
							spr.animation.play('idle');
					}
			
					if (FlxG.mouse.overlaps(spr))
					{

						if(canClick)
						{
							curSelected = spr.ID;
							usingMouse = true;
							spr.animation.play('hover');
						}
							
						if(FlxG.mouse.pressed && canClick)
						{
							switch(optionShit[curSelected]) {

								case 'Quit':
									System.exit(0);
								case 'Twitter':
									CoolUtil.browserLoad('https://twitter.com/NovisorDev');
								case 'Discord':
									CoolUtil.browserLoad('https://discord.gg/7UFXgKBqRj');
								default:
									selectSomething();
							}
						}
					}		
					spr.updateHitbox();
				});
		}

		#if desktop
			if (FlxG.keys.justPressed.SEVEN)
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end

		super.update(elapsed);

		/*menuItems.forEach(function(spr:FlxSprite)
		{
		//	spr.screenCenter(X);
		});*/
	}

	function selectSomething()
		{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('confirmMenu'));
				
				canClick = false;

				menuItems.forEach(function(spr:FlxSprite)
				{
					if (curSelected != spr.ID)
					{
						FlxTween.tween(FlxG.camera, {zoom: 20}, 1, {ease: FlxEase.expoIn});
						
						FlxTween.tween(spr, {alpha: 0}, 0.4, {
							ease: FlxEase.quadOut,
							onComplete: function(twn:FlxTween)
							{
								spr.kill();
							}
							});
					} else {
						
						FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
						{
						    new FlxTimer().start(1, function(tmr:FlxTimer)
							{
								goToState();
							});
						});
					}
				});
				}

	function goToState()
	{
		var daChoice:String = optionShit[curSelected];

		switch (daChoice)
		{
			case 'Freeplay':
			    MusicBeatState.switchState(new FreeplayState());
			case 'Options':
				MusicBeatState.switchState(new options.OptionsState());
			case 'Credits':
				MusicBeatState.switchState(new CreditsState());
		}
	}

	function changeItem(huh:Int = 0)
	{
		if (finishedFunnyMove)
		{
			curSelected += huh;
	
			if (curSelected >= menuItems.length)
				curSelected = 0;
			if (curSelected < 0)
				curSelected = menuItems.length - 1;
		}
		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');
	
			if (spr.ID == curSelected && finishedFunnyMove)
			{
				spr.animation.play('hover');				
			}
			spr.updateHitbox();
		});
	}
}