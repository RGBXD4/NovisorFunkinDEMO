package;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.addons.display.FlxBackdrop;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
import lime.app.Application;
import flixel.tweens.FlxEase;
#if MODS_ALLOWED
import sys.FileSystem;
import sys.io.File;
#end
import lime.utils.Assets;
import openfl.filters.ShaderFilter;
import Shaders;
import openfl.display.Shader;

using StringTools;

class CreditsState extends MusicBeatState
{
	var curSelected:Int = -1;

	private var grpOptions:FlxTypedGroup<Alphabet>;
	private var iconArray:Array<AttachedSprite> = [];
	private var creditsStuff:Array<Array<String>> = [];

	var bg:FlxSprite;
	var descText:FlxText;
	var intendedColor:Int;
	var colorTween:FlxTween;
	var descBox:AttachedSprite;

	var offsetThing:Float = -75;

	var starFG:FlxBackdrop;
	var starBG:FlxBackdrop;

	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Credits Menu", null);
		#end

		var shader:Shaders.ChromaticAberrationEffect = new Shaders.ChromaticAberrationEffect();
		shader.setChrome(0.003);
		FlxG.camera.setFilters([new ShaderFilter(shader.shader)]);

		persistentUpdate = true;
		bg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.screenCenter();

		starFG = new FlxBackdrop(Paths.image('mainmenu/mainmenuV4/starFG'), XY);
		starFG.antialiasing = ClientPrefs.globalAntialiasing;
		add(starFG);

		starBG = new FlxBackdrop(Paths.image('mainmenu/mainmenuV4/starBG'), XY);
		starBG.antialiasing = ClientPrefs.globalAntialiasing;
		add(starBG);
		
		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		#if MODS_ALLOWED
		var path:String = 'modsList.txt';
		if(FileSystem.exists(path))
		{
			var leMods:Array<String> = CoolUtil.coolTextFile(path);
			for (i in 0...leMods.length)
			{
				if(leMods.length > 1 && leMods[0].length > 0) {
					var modSplit:Array<String> = leMods[i].split('|');
					if(!Paths.ignoreModFolders.contains(modSplit[0].toLowerCase()) && !modsAdded.contains(modSplit[0]))
					{
						if(modSplit[1] == '1')
							pushModCreditsToList(modSplit[0]);
						else
							modsAdded.push(modSplit[0]);
					}
				}
			}
		}

		var arrayOfFolders:Array<String> = Paths.getModDirectories();
		arrayOfFolders.push('');
		for (folder in arrayOfFolders)
		{
			pushModCreditsToList(folder);
		}
		#end

		var pisspoop:Array<Array<String>> = [ //Name - Icon name - Description - Link - BG Color
			['VisorX Team'],
			['Egglo',		        'egglo',		    'Director, Main Coder, Chromatic Maker',					    'https://twitter.com/Egglolmao',	    'DF8700'],
			['NewEggrollz',		    'neweggrollz',		'Co-Director, Composer, Artist/Animator',						'https://twitter.com/GoodEggrollz',	    'FFEB6E'],
			['PolyDev',		        'nonoc',		    'Co-Director, Artist',								            'https://twitter.com/pppolydev',	    '545454'],
			['GCrew',		        'gcrew',		    'Second Coder',								                    'https://youtube.com/@GCr3w',	        'FFFA51'],
			['AWHNathan',		    'awhnathan',		'Main Charter',								                    'https://twitter.com/AWHNathan',	    'F1D3FF'],
			['SBMB',		        'sbmb',		        'Charter',								                        'https://www.youtube.com/@SBMB_101',	'846949'],
			['MagMAJESTY',		    'mag',		        'Charter',								                        'https://twitter.com/Dawgidontknow',	'195F1C'],
			['24roomsofdeath',		'rooms',		    'Charter',								                        'https://www.youtube.com/@24roomsofdeath',	'FF4D2C'],
			['Typlayz36',		    'ty',		        'Charter',								                        'https://www.youtube.com/@TyPlayz36',	'FFBC59'],
			['Sai',		            'sai',		        'Main Composer, Artist/Animator',								'https://twitter.com/saiko_gfv',	    'B859FF'],
			['Ayaabu',		        'aya',		        'Composer',								                        'https://twitter.com/ayaabu7',	        '9C00A1'],
			['TheToppo',		    'nonoc',		    'Composer',								                        'https://www.youtube.com/@thetoppo4274',    'FFFFFF'],
			['Jautrey',		        'jautrey',		    'Composer',								                        'https://twitter.com/Jautrey10',	    'A284FF'],
			['Ameshi',		        'ameshi',		    'Composer',								                        'https://twitter.com/Amesh1_',	        'FFFFFF'],
			['Toni',		        'toni',		        'Composer',								                        'https://twitter.com/Tony57Official',	'FFFFFF'],
			['Ayden',		        'ayden',		    'Composer',								                        'https://www.youtube.com/@themostawesomechannelever',	'428DA7'],
			['TheTrueSkeledan',		'skeledan',		    'Composer, Artist/Animator',								    'https://twitter.com/TheRealSkeledan',	'4F3B18'],
			['Agente R',		    'agente',		    'Artist/Animator',								                'https://twitter.com/Agente_R_XD',	    '3F3DA2'],
			['JesseArtistXD',		'jesse',		    'Artist/Animator',								                'https://twitter.com/ARandomHecker',	'3F3DA2'],
			['ShapeMan',		    'nonoc',		    'Artist/Animator, Chromatic Maker',								'https://twitter.com/_MCircleS_',	    '8C4CAE'],
			['MeowMeowBruh10',		'meowmeow',		    'Artist',								                        'https://twitter.com/meowmeowbitch11',	'E23B3B'],
			['Bismuth_Night',		'bismuth',		    'Artist',								                        'https://twitter.com/bismuth_kiwi',	    '595280'],
			['Buruaru',		        'buruaru',		    'Artist',								                        'https://twitter.com/Sussusburuaru2',	'4A5AFF'],
			['West',		        'nonoc',		    'Artist',								                        'https://twitter.com/westdoesart',	    'FFFFFF'],
			['ToastBee',		    'toastbee',		    'Artist',								                        'https://twitter.com/ToastBee_',	    '4F3B18'],
			['IlyasDF',		        'ilyasdf',		    'Artist',								                        'https://twitter.com/IlyasDF8',	        '3A78DE'],
			['DaDinoGuy',		    'dadinoguy',		'Artist',								                        'https://twitter.com/DaDinoGuyDev',	    '420086'],
			['Ocip',		        'nonoc',		    'Artist',								                        'https://youtube.com/@uhocip',	        'FFFFFF'],
			['YaWill',		        'yawill',		    'Artist',								                        'https://youtube.com/@YaWillOrYaWont',	'DF8700'],
		];
		
		for(i in pisspoop){
			creditsStuff.push(i);
		}

		Application.current.window.title = "Novisor Funkin' - Credits Menu";
	
		for (i in 0...creditsStuff.length)
		{
			var isSelectable:Bool = !unselectableCheck(i);
			var optionText:Alphabet = new Alphabet(FlxG.width / 2, 300, creditsStuff[i][0], !isSelectable);
			optionText.isMenuItem = true;
			optionText.targetY = i;
			optionText.changeX = false;
			optionText.snapToPosition();
			grpOptions.add(optionText);

			if(isSelectable) {
				if(creditsStuff[i][5] != null)
				{
					Paths.currentModDirectory = creditsStuff[i][5];
				}

				var icon:AttachedSprite = new AttachedSprite('credits/' + creditsStuff[i][1]);
				icon.xAdd = optionText.width + 10;
				icon.sprTracker = optionText;
	
				// using a FlxGroup is too much fuss!
				iconArray.push(icon);
				add(icon);
				Paths.currentModDirectory = '';

				if(curSelected == -1) curSelected = i;
			}
			else optionText.alignment = CENTERED;
		}
		
		descBox = new AttachedSprite();
		descBox.makeGraphic(1, 1, FlxColor.BLACK);
		descBox.xAdd = -10;
		descBox.yAdd = -10;
		descBox.alphaMult = 0.6;
		descBox.alpha = 0.6;
		add(descBox);

		descText = new FlxText(50, FlxG.height + offsetThing - 25, 1180, "", 32);
		descText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER/*, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK*/);
		descText.scrollFactor.set();
		//descText.borderSize = 2.4;
		descBox.sprTracker = descText;
		add(descText);

		bg.color = getCurrentBGColor();
		intendedColor = bg.color;
		changeSelection();
		super.create();
	}

	var quitting:Bool = false;
	var holdTime:Float = 0;
	override function update(elapsed:Float)
	{
		starFG.x -= 0.03;
		starBG.x -= 0.01;

		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if(!quitting)
		{
			if(creditsStuff.length > 1)
			{
				var shiftMult:Int = 1;
				if(FlxG.keys.pressed.SHIFT) shiftMult = 3;

				var upP = controls.UI_UP_P;
				var downP = controls.UI_DOWN_P;

				if (upP)
				{
					changeSelection(-shiftMult);
					holdTime = 0;
				}
				if (downP)
				{
					changeSelection(shiftMult);
					holdTime = 0;
				}

				if(controls.UI_DOWN || controls.UI_UP)
				{
					var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
					holdTime += elapsed;
					var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);

					if(holdTime > 0.5 && checkNewHold - checkLastHold > 0)
					{
						changeSelection((checkNewHold - checkLastHold) * (controls.UI_UP ? -shiftMult : shiftMult));
					}
				}
			}

			if(controls.ACCEPT && (creditsStuff[curSelected][3] == null || creditsStuff[curSelected][3].length > 4)) {
				CoolUtil.browserLoad(creditsStuff[curSelected][3]);
			}
			if (controls.BACK)
			{
				if(colorTween != null) {
					colorTween.cancel();
				}
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new MainMenuState());
				quitting = true;
			}
		}
		
		for (item in grpOptions.members)
		{
			if(!item.bold)
			{
				var lerpVal:Float = CoolUtil.boundTo(elapsed * 12, 0, 1);
				if(item.targetY == 0)
				{
					var lastX:Float = item.x;
					item.screenCenter(X);
					item.x = FlxMath.lerp(lastX, item.x - 70, lerpVal);
				}
				else
				{
					item.x = FlxMath.lerp(item.x, 200 + -40 * Math.abs(item.targetY), lerpVal);
				}
			}
		}
		super.update(elapsed);
	}

	var moveTween:FlxTween = null;
	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		do {
			curSelected += change;
			if (curSelected < 0)
				curSelected = creditsStuff.length - 1;
			if (curSelected >= creditsStuff.length)
				curSelected = 0;
		} while(unselectableCheck(curSelected));

		var newColor:Int =  getCurrentBGColor();
		if(newColor != intendedColor) {
			if(colorTween != null) {
				colorTween.cancel();
			}
			intendedColor = newColor;
			colorTween = FlxTween.color(bg, 1, bg.color, intendedColor, {
				onComplete: function(twn:FlxTween) {
					colorTween = null;
				}
			});
		}

		var bullShit:Int = 0;

		for (item in grpOptions.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			if(!unselectableCheck(bullShit-1)) {
				item.alpha = 0.6;
				if (item.targetY == 0) {
					item.alpha = 1;
				}
			}
		}

		descText.text = creditsStuff[curSelected][2];
		descText.y = FlxG.height - descText.height + offsetThing - 60;

		if(moveTween != null) moveTween.cancel();
		moveTween = FlxTween.tween(descText, {y : descText.y + 75}, 0.25, {ease: FlxEase.sineOut});

		descBox.setGraphicSize(Std.int(descText.width + 20), Std.int(descText.height + 25));
		descBox.updateHitbox();
	}

	#if MODS_ALLOWED
	private var modsAdded:Array<String> = [];
	function pushModCreditsToList(folder:String)
	{
		if(modsAdded.contains(folder)) return;

		var creditsFile:String = null;
		if(folder != null && folder.trim().length > 0) creditsFile = Paths.mods(folder + '/data/credits.txt');
		else creditsFile = Paths.mods('data/credits.txt');

		if (FileSystem.exists(creditsFile))
		{
			var firstarray:Array<String> = File.getContent(creditsFile).split('\n');
			for(i in firstarray)
			{
				var arr:Array<String> = i.replace('\\n', '\n').split("::");
				if(arr.length >= 5) arr.push(folder);
				creditsStuff.push(arr);
			}
			creditsStuff.push(['']);
		}
		modsAdded.push(folder);
	}
	#end

	function getCurrentBGColor() {
		var bgColor:String = creditsStuff[curSelected][4];
		if(!bgColor.startsWith('0x')) {
			bgColor = '0xFF' + bgColor;
		}
		return Std.parseInt(bgColor);
	}

	private function unselectableCheck(num:Int):Bool {
		return creditsStuff[num].length <= 1;
	}
}