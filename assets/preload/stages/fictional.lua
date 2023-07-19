local allowCountdown = false


local u = false;
local r = 0;
local shot = false;
local agent = 1
local health = 0;
local xx = 510;
local yy = 370;
local xx2 = 510;
local yy2 = 370;
local ofs = 0;
local followchars = true;
local del = 0;
local del2 = 0;

wideScreen = (26 * 6) + 4

local angleshit = 1;
local anglevar = 1;

local allowCountdown = false
function onStartCountdown()
	if not allowCountdown and not seenCutscene then --Block the first countdown
		startVideo('fictional');
		allowCountdown = true;
		return Function_Stop;
	end
	return Function_Continue;
end

function onCreate()

    makeLuaSprite('borderL', 'aspect',0,0)
    addLuaSprite('borderL', false)
    setObjectCamera("borderL", "camother")

    makeLuaSprite('nick', 'nick',0,0)
    addLuaSprite('nick', true)
    setObjectCamera("nick", "camother")

    makeAnimatedLuaSprite('bubble', 'fictional/bubbletext', 0, 0)
    addAnimationByPrefix('bubble', 'talk', 'bubble instance 1', 24, false)
 
    makeAnimatedLuaSprite('fiction3', '3', 420, 80)
    setObjectCamera('fiction3', 'camOther')

    makeAnimatedLuaSprite('fiction2', '2', 330, 80)
    setObjectCamera('fiction2', 'camOther')

    makeAnimatedLuaSprite('fiction1', '1', 150, 80)
    setObjectCamera('fiction1', 'camOther')

    makeAnimatedLuaSprite('fictiongo', 'go', 360, 130)
    setObjectCamera('fictiongo', 'camOther')

    setProperty('timeBar.color', getColorFromHex('000000'))
    setProperty('timeBar.color', getColorFromHex('ffffff'))
end

function onCreatePost()
    
    setProperty('sickTxt.x', 170)
    setProperty('goodTxt.x', 170)
    setProperty('badTxt.x', 170)
    setProperty('shitTxt.x', 170)

    setProperty('songtxt.alpha', 0)
    setProperty('composer.alpha', 0)

    setProperty('camHUD.alpha', 0)

    if not downScroll then
        setProperty('botplayTxt.y', 540)
    end
end

function onBeatHit()
    if curBeat == 32 then
        doTweenAlpha('hicam', 'camHUD', 1, 0.8)
    end
end

function onUpdate()
    if del > 0 then
        del = del - 1
    end
    if del2 > 0 then
        del2 = del2 - 1
    end
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

function onStepHit()

    if curStep == 102 then
        objectPlayAnimation('bubble', 'talk', false)
        addLuaSprite('bubble', true)
    end
    
    if curStep == 117 then
        removeLuaSprite('bubble', true)
    end


end

function onCountdownTick(counter)

    if counter == 0 then
        addLuaSprite('fiction3', true)
        addAnimationByPrefix('fiction3', 'three', '3', 24, false)
    end

    if counter == 1 then
        setProperty('fiction3.visible', false)
        addLuaSprite('fiction2', true)
        addAnimationByPrefix('fiction2', 'two', '2', 24, false)
    end

    if counter == 2 then
        setProperty('fiction2.visible', false)
        addLuaSprite('fiction1', true)
        addAnimationByPrefix('fiction1', 'one', '1', 24, false)
    end

    if counter == 3 then
        setProperty('fiction1.visible', false)
        addLuaSprite('fictiongo', true)
        addAnimationByPrefix('fictiongo', 'go', 'go', 24, false)
    end

    if counter == 4 then
        doTweenAlpha('goalpha', 'fictiongo', 0, 1, 'linear')
    end

end