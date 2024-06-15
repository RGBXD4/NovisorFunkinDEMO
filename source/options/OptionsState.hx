package options;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.addons.display.FlxBackdrop;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import lime.app.Application;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import openfl.filters.ShaderFilter;
import Shaders;
import openfl.display.Shader;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;

using StringTools;

class OptionsState extends MusicBeatState
{
	var options:Array<String> = ['Controls', 'Adjust Delay and Combo', 'Graphics', 'Visuals and UI', 'Gameplay'];
	private var grpOptions:FlxTypedGroup<Alphabet>;

	private static var curSelected:Int = 0;
	public static var menuBG:FlxSprite;

	function openSelectedSubstate(label:String)
	{
		switch (label)
		{
			case 'Controls':
			#if android
				removeVirtualPad();
				#end
				openSubState(new options.ControlsSubState());
				Application.current.window.title = "Novisor Funkin' - Control Settings";
			case 'Graphics':
			#if android
				removeVirtualPad();
				#end
				openSubState(new options.GraphicsSettingsSubState());
				Application.current.window.title = "Novisor Funkin' - Graphic Settings";
			case 'Visuals and UI':
			#if android
				removeVirtualPad();
				#end
				openSubState(new options.VisualsUISubState());
				Application.current.window.title = "Novisor Funkin' - Visual and  UI Settings";
			case 'Gameplay':
			#if android
				removeVirtualPad();
				#end
				openSubState(new options.GameplaySettingsSubState());
				Application.current.window.title = "Novisor Funkin' - Gameplay Settings";
			case 'Adjust Delay and Combo':
			#if android
				removeVirtualPad();
				#end
				LoadingState.loadAndSwitchState(new options.NoteOffsetState());
				Application.current.window.title = "Novisor Funkin' - Adjust Delay & Combo Settings";
		}
	}

	var selectorLeft:Alphabet;
	var selectorRight:Alphabet;

	var starFG:FlxBackdrop;
	var starBG:FlxBackdrop;

	override function create()
	{
		#if desktop
		DiscordClient.changePresence("Options Menu", null);
		#end

		var shader:Shaders.ChromaticAberrationEffect = new Shaders.ChromaticAberrationEffect();
		shader.setChrome(0.003);
		FlxG.camera.setFilters([new ShaderFilter(shader.shader)]);

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.color = 0xFFea71fd;
		// bg.updateHitbox();

		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		// add(bg);

		var titlebg:FlxSprite = new FlxSprite(0, 0).makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
		titlebg.scrollFactor.set();
		add(titlebg);

		starFG = new FlxBackdrop(Paths.image('mainmenu/mainmenuV4/starFG'), XY);
		starFG.antialiasing = ClientPrefs.globalAntialiasing;
		add(starFG);

		starBG = new FlxBackdrop(Paths.image('mainmenu/mainmenuV4/starBG'), XY);
		starBG.antialiasing = ClientPrefs.globalAntialiasing;
		add(starBG);

		Application.current.window.title = "Novisor Funkin' - Options Menu";

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		for (i in 0...options.length)
		{
			var optionText:Alphabet = new Alphabet(0, 0, options[i], true);
			optionText.screenCenter();
			optionText.y += (100 * (i - (options.length / 2))) + 50;
			grpOptions.add(optionText);
		}

		selectorLeft = new Alphabet(0, 0, '>', true);
		add(selectorLeft);
		selectorRight = new Alphabet(0, 0, '<', true);
		add(selectorRight);

		changeSelection();
		ClientPrefs.saveSettings();
		
		#if android
		addVirtualPad(UP_DOWN, A_B_X_Y);
		#end

		super.create();
	}

	override function closeSubState()
	{
		super.closeSubState();
		ClientPrefs.saveSettings();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		starFG.x -= 0.03;
		starBG.x -= 0.01;

		if (controls.UI_UP_P)
		{
			changeSelection(-1);
		}
		if (controls.UI_DOWN_P)
		{
			changeSelection(1);
		}
		
		#if android
		if (_virtualpad.buttonX.justPressed) {
			FlxTransitionableState.skipNextTransIn = true;
			FlxTransitionableState.skipNextTransOut = true;
			MusicBeatState.switchState(new android.AndroidControlsMenu());
		}
		if (_virtualpad.buttonY.justPressed) {
			removeVirtualPad();
			openSubState(new android.HitboxSettingsSubState());
		}
		#end

		if (controls.BACK)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}

		if (controls.ACCEPT)
		{
			openSelectedSubstate(options[curSelected]);
		}
	}

	function changeSelection(change:Int = 0)
	{
		curSelected += change;
		if (curSelected < 0)
			curSelected = options.length - 1;
		if (curSelected >= options.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpOptions.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			if (item.targetY == 0)
			{
				item.alpha = 1;
				selectorLeft.x = item.x - 63;
				selectorLeft.y = item.y;
				selectorRight.x = item.x + item.width + 15;
				selectorRight.y = item.y;
			}
		}
		FlxG.sound.play(Paths.sound('scrollMenu'));
	}
}
