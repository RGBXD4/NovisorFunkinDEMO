package;

#if desktop
import Discord.DiscordClient;
#end
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
import lime.app.Application;
import Achievements;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;
import flixel.util.FlxTimer;

using StringTools;

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = '0.5.2h'; //This is also used for Discord RPC
	public static var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;
	private var camGame:FlxCamera;
	private var camAchievement:FlxCamera;
	
	var optionShit:Array<String> = [
		'story_mode',
		'freeplay',
		'credits',
		'options'
	];

	var debugKeys:Array<FlxKey>;
	var logoBl:FlxSprite;
	var camFollow:FlxObject;
	var gorefield:FlxSprite;
	var gorefieldenter:FlxSprite;
	var camFollowPos:FlxObject;
	var fire:FlxSprite;
	var menuInfomation:FlxText;
	var versionShit:FlxText;
	var versionGore:FlxText;
	var bg:FlxSprite;
	var startcutscene:FlxSprite;
	var allowinput:Bool = false;

	public static var seencutscene:Bool = false;

	override function create()
	{
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();
		WeekData.loadTheFirstEnabledMod();

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end
		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));

		camGame = new FlxCamera();
		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camAchievement);
		FlxCamera.defaultCameras = [camGame];

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		var yScroll:Float = Math.max(0.25 - (0.05 * (optionShit.length - 4)), 0.1);
		bg = new FlxSprite(-80).loadGraphic(Paths.image('menuBG'));
		bg.scrollFactor.set(0, yScroll);
		bg.setGraphicSize(Std.int(bg.width * 1.175));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		camFollow = new FlxObject(0, 0, 1, 1);
		camFollowPos = new FlxObject(0, 0, 1, 1);
		add(camFollow);
		add(camFollowPos);

		fire = new FlxSprite(-80);
		fire.frames = Paths.getSparrowAtlas('fire');
		fire.antialiasing = ClientPrefs.globalAntialiasing;
		fire.animation.addByPrefix('fire', 'fire', 24);
		fire.scrollFactor.set(0, yScroll);
		fire.setGraphicSize(Std.int(fire.width * 1.175));
		fire.animation.play('fire');
		fire.updateHitbox();

		logoBl = new FlxSprite(-10, -60);
		logoBl.frames = Paths.getSparrowAtlas('logoBumpin');
		logoBl.antialiasing = ClientPrefs.globalAntialiasing;
		logoBl.animation.addByPrefix('bump', 'logo bumpin', 24);
		logoBl.setGraphicSize(Std.int(logoBl.width * 0.60));
		logoBl.animation.play('bump');
		logoBl.updateHitbox();
		logoBl.visible = false;
		add(logoBl);

		FlxTween.tween(logoBl, {y: logoBl.y + 5}, 0.5, {ease: FlxEase.quadInOut, type: PINGPONG});

		gorefield = new FlxSprite(589.5, 40);
		gorefield.frames = Paths.getSparrowAtlas('GorefieldMENU');
		gorefield.antialiasing = true;
		gorefield.animation.addByPrefix('idle', 'MenuIdle', 24);
		gorefield.animation.addByPrefix('jeje', 'JEJE', 24);
		gorefield.setGraphicSize(Std.int(gorefield.width * 1));
		gorefield.animation.play('idle');
		gorefield.updateHitbox();
		gorefield.visible = false;
		add(gorefield);
		
		// magenta.scrollFactor.set();

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		menuInfomation = new FlxText(110, 675, 1000, "Please select a option.", 28);
		menuInfomation.setFormat("Pixel-Art Regular", 28, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		menuInfomation.scrollFactor.set(0, 0);
		menuInfomation.borderSize = 2;
		menuInfomation.visible = false;
		add(menuInfomation);

		var scale:Float = 1;
		/*if(optionShit.length > 6) {
			scale = 6 / optionShit.length;
		}*/

		for (i in 0...optionShit.length)
		{
			var offset:Float = 308 - (Math.max(optionShit.length, 4) - 4) * 80;
			var menuItem:FlxSprite = new FlxSprite(0, (i * 100)  + offset);
			menuItem.scale.x = scale;
			menuItem.scale.y = scale;
			menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_' + optionShit[i]);
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItem.x = 2;
			menuItems.add(menuItem);
			var scr:Float = (optionShit.length - 4) * 0.135;
			if(optionShit.length < 6) scr = 0;
			menuItem.scrollFactor.set(0, scr);
			menuItem.antialiasing = ClientPrefs.globalAntialiasing;
			menuItem.setGraphicSize(Std.int(menuItem.width * 0.90));
			menuItem.updateHitbox();
			menuItem.x -= menuItem.width;

			switch(i)
			{
				case 0:
					menuItem.x -= 16;	
				case 1:
					menuItem.x -= 22;	
				case 3:
					menuItem.x -= 23.5;
			}
			menuItem.visible = false;
		}

		//FlxG.camera.follow(camFollowPos, null, 1);

		versionShit = new FlxText(12, FlxG.height - 44, 0, "Psych Engine v" + psychEngineVersion, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("Pixel-Art Regular", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		versionShit.visible = false;
		add(versionShit);
		versionGore = new FlxText(12, FlxG.height - 24, 0, "Vs Gorefield v1.0", 12);
		versionGore.scrollFactor.set();
		versionGore.setFormat("Pixel-Art Regular", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		versionGore.visible = false;
		add(versionGore);

		changeItem();

		startcutscene = new FlxSprite();
		startcutscene.frames = Paths.getSparrowAtlas('Garfield_menu_startup');
		startcutscene.animation.addByPrefix('start up', 'GARFIELD', 24, false);
		startcutscene.updateHitbox();
		startcutscene.screenCenter();
		startcutscene.visible = false;
		add(startcutscene);	
		if (!seencutscene) {
			new FlxTimer().start(1.5, function(tmr:FlxTimer) {
				startcutscene.animation.play('start up');
				startcutscene.visible = true;
			});
				
			startcutscene.animation.finishCallback = function (name:String) 
			{
				seencutscene = true;
				startcutscene.visible = false;
				remove(startcutscene);
				logoBl.visible = true;
				menuInfomation.visible = true;
				versionGore.visible = true;
				versionShit.visible = true;
				gorefield.visible = true;
				menuItems.forEach(function(spr:FlxSprite)
				{
					spr.visible = true;
					FlxTween.tween(spr, {x: spr.x + spr.width}, 0.7, {
						onComplete: function(twn:FlxTween) 
						{
							allowinput = true;
						}
					});	
				});
			}
		} 
		else 
		{
			startcutscene.visible = false;
			remove(startcutscene);
			logoBl.visible = true;
			menuInfomation.visible = true;
			versionGore.visible = true;
			versionShit.visible = true;
			gorefield.visible = true;
			menuItems.forEach(function(spr:FlxSprite)
			{
				spr.visible = true;
				spr.x = spr.x + spr.width;
				allowinput = true;
			});
		}

	        #if android
		addVirtualPad(UP_DOWN, A_B);
		#end

		super.create();
		
		menuItems.forEach(function(spr:FlxSprite)
			{
				//spr.screenCenter(X);
			});
	}

	#if ACHIEVEMENTS_ALLOWED
	// Unlocks "Freaky on a Friday Night" achievement
	function giveAchievement() {
		add(new AchievementObject('friday_night_play', camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace('Giving achievement "friday_night_play"');
	}
	#end

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);
		camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));

		if (!selectedSomethin && allowinput)
		{
			if (controls.UI_UP_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(-1);
			}

			if (controls.UI_DOWN_P)
			{
				FlxG.sound.play(Paths.sound('scrollMenu'));
				changeItem(1);
			}

			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}

			if (controls.ACCEPT)
			{
				if (optionShit[curSelected] == 'story_mode')
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('pressStorymode'));
					gorefield.animation.play('jeje');
					gorefield.offset.y = 15;
					gorefield.offset.x = -25;
					gorefield.x = 250;
					FlxG.sound.music.stop();
					FlxG.camera.flash(FlxColor.WHITE, 1);
					menuInfomation.text = "WARNING, YOU ARE APPROACHING GOREFIELD!!";
					if(ClientPrefs.language) menuInfomation.text = "ADVERTENCIA, ¡¡SE ESTÁ ACERCANDO A GOREFIELD!!";
					menuInfomation.color = FlxColor.RED;
					remove(logoBl);
					remove(menuItems);
					remove(versionShit);
					remove(versionGore);
					remove(bg);
					add(fire);

					new FlxTimer().start(2, function(tmr:FlxTimer)
					{
						FlxG.camera.fade(FlxColor.RED, 2.5);
					});

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {x: -1000, "alpha": 0}, 1, {ease: FlxEase.quadIn});
						}
						else
						{
							FlxFlicker.flicker(spr, 5, 0.06, false, false, function(flick:FlxFlicker)
							{
								var daChoice:String = optionShit[curSelected];

								var diffic = CoolUtil.getDifficultyFilePath(1);
								if(diffic == null) diffic = '';

								switch (daChoice)
								{
									case 'story_mode':

									MusicBeatState.switchState(new StoryMenuState());

									FreeplayState.destroyFreeplayVocals();
								}
							});
						}
					});
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {"x": -1000}, 1, {ease: FlxEase.linear});
						}
						else
						{
							FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
							{
								var daChoice:String = optionShit[curSelected];

								switch (daChoice)
								{
									case 'freeplay':
										MusicBeatState.switchState(new FreeplayState());
									case 'credits':
										MusicBeatState.switchState(new CreditsState());
									case 'options':
										LoadingState.loadAndSwitchState(new options.OptionsState());
								}
							});
						}
					});
				}
			}
			#if desktop
			else if (FlxG.keys.anyJustPressed(debugKeys))
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end
		}

		super.update(elapsed);
	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		switch (curSelected) 
		{
			case 0:
				menuInfomation.text = "Be very careful, be cautious!!";
				if(ClientPrefs.language) menuInfomation.text = "Ten mucho cuidado, se cuidadoso!!";
				menuInfomation.color = FlxColor.WHITE;
			case 1:
				menuInfomation.text = "Sing along with GoreField";
				if(ClientPrefs.language) menuInfomation.text = "Canta junto con GoreField";
				menuInfomation.color = FlxColor.WHITE;
			case 2:
				menuInfomation.text = "Credits to those who helped!";
				if(ClientPrefs.language) menuInfomation.text = "Creditos a los que ayudaron!";
				menuInfomation.color = FlxColor.WHITE;
			case 3:
				menuInfomation.text = "The options you expected?";
				if(ClientPrefs.language) menuInfomation.text = "Las opciones que esperabas?";
				menuInfomation.color = FlxColor.WHITE;
		}

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');
			spr.updateHitbox();

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				var add:Float = 0;
				if(menuItems.length > 4) {
					add = menuItems.length * 8;
				}
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y - add);
				spr.centerOffsets();
			}
		});
	}
}
