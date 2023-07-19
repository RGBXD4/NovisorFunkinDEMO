local followchars = true
local modchart = true
local xx = -390;
local yy = 110;
local xx2 = -100;
local yy2 = 150;
local ofs = 10;
local del = 0
local del2 = 0

function onCreate()

    makeLuaSprite('borderL', 'aspect',0,0)
    addLuaSprite('borderL', true)
    setObjectCamera("borderL", "camother")

end

function onCreatePost()
    
    setProperty('sickTxt.x', 170)
    setProperty('goodTxt.x', 170)
    setProperty('badTxt.x', 170)
    setProperty('shitTxt.x', 170)

    setProperty('songtxt.alpha', 0)
    setProperty('composer.alpha', 0)

    if not downScroll then
        setProperty('botplayTxt.y', 540)
    end
end

function onUpdate(elapsed)
	if followchars == true then
		if mustHitSection == false then
		  if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
			triggerEvent('Camera Follow Pos',xx-ofs,yy)
		  end
		  if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
			triggerEvent('Camera Follow Pos',xx+ofs,yy)
		  end
		  if getProperty('dad.animation.curAnim.name') == 'singUP' then
			triggerEvent('Camera Follow Pos',xx,yy-ofs)
		  end
		  if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
			triggerEvent('Camera Follow Pos',xx,yy+ofs)
		  end
		  if getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' then
			triggerEvent('Camera Follow Pos',xx-ofs,yy)
		  end
		  if getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' then
			triggerEvent('Camera Follow Pos',xx+ofs,yy)
		  end
		  if getProperty('dad.animation.curAnim.name') == 'singUP-alt' then
			triggerEvent('Camera Follow Pos',xx,yy-ofs)
		  end
		  if getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' then
			triggerEvent('Camera Follow Pos',xx,yy+ofs)
		  end
		  if getProperty('dad.animation.curAnim.name') == 'idle-alt' then
			triggerEvent('Camera Follow Pos',xx,yy)
		  end
		  if getProperty('dad.animation.curAnim.name') == 'idle' then
			triggerEvent('Camera Follow Pos',xx,yy)
		  end
		else
		  if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
			triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
		  end
		  if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
			triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
		  end
		  if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
			triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
		  end
		  if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
			triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
		  end
		  if getProperty('boyfriend.animation.curAnim.name') == 'idle-alt' then
			triggerEvent('Camera Follow Pos',xx2,yy2)
		  end
		  if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
			triggerEvent('Camera Follow Pos',xx2,yy2)
		  end
		end
	else
		triggerEvent('Camera Follow Pos','','')
	end

	noteTweenX('square4', 4, 666, 0.1)
    noteTweenX('square5', 5, 778, 0.1)
    noteTweenX('square6', 6, 890, 0.1)
    noteTweenX('square7', 7, 1002, 0.1)

    noteTweenX('square0', 0, 171, 0.1)
    noteTweenX('square1', 1, 283, 0.1)
    noteTweenX('square2', 2, 395, 0.1)
    noteTweenX('square3', 3, 507, 0.1)
end

function onBeatHit()
	if curBeat == 63 then

		followchars = true;
		xx2 = 50;
        yy2 = 180;

	end

	if curBeat == 64 then

		followchars = true;
		xx2 = -100;
        yy2 = 150;

	end

	if curBeat == 95 then

		followchars = true;
		xx2 = 50;
        yy2 = 180;

	end

	if curBeat == 96 then

		followchars = true;
		xx2 = -100;
        yy2 = 150;

	end

	if curBeat == 160 then

		followchars = true;
		xx2 = 50;
        yy2 = 180;

	end

	if curBeat == 164 then

		followchars = true;
		xx2 = -100;
        yy2 = 150;

	end

	if curBeat == 228 then

		followchars = true;
		xx2 = 50;
        yy2 = 180;

	end

	if curBeat == 232 then

		followchars = true;
		xx2 = -100;
        yy2 = 150;

	end

	if curBeat == 263 then

		followchars = true;
		xx2 = 50;
        yy2 = 180;

	end

	if curBeat == 264 then

		followchars = true;
		xx2 = -100;
        yy2 = 150;

	end
end