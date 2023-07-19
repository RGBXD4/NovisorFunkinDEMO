local allowCountdown = false

local u = false;
local r = 0;
local shot = false;
local agent = 1
local health = 0;
local xx = 170;
local yy = 420;
local xx2 = 600;
local yy2 = 420;
local ofs = 0;
local followchars = true;
local del = 0;
local del2 = 0;

local angleshit = 1;
local anglevar = 1;

function onCreatePost()

    setProperty('deadies.alpha', 0)
    setProperty('deadfront.alpha', 0)

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
    
end

function onBeatHit()

    if curBeat == 4 then
        setProperty('defaultCamZoom', 1)
        followchars = true;
        xx = 100;
    end

    if curBeat == 8 then
        setProperty('defaultCamZoom', 1.2)
        followchars = true;
        xx = 50;
    end

    if curBeat == 11 then
        setProperty('defaultCamZoom', 1.3)
        followchars = true;
        xx = 0;
    end

    if curBeat == 12 then
        setProperty('defaultCamZoom', 1.2)
        followchars = true;
        xx = 50;
    end

    if curBeat == 14 then
        setProperty('defaultCamZoom', 1)
        followchars = true;
        xx = 100;
    end

    if curBeat == 16 then
        setProperty('defaultCamZoom', 0.92)
        followchars = true;
        xx = 170;
    end

    if curBeat == 20 then
        setProperty('defaultCamZoom', 1)
        xx2 = 700;
        followchars = true;
    end

    if curBeat == 24 then
        setProperty('defaultCamZoom', 1.2)
        xx2 = 750;
        followchars = true;
    end

    if curBeat == 27 then
        setProperty('defaultCamZoom', 1.3)
        xx2 = 800;
        followchars = true;
    end

    if curBeat == 28 then
        setProperty('defaultCamZoom', 1.2)
        xx2 = 750;
        followchars = true;
    end

    if curBeat == 30 then
        setProperty('defaultCamZoom', 1)
        xx2 = 700;
        followchars = true;
    end

    if curBeat == 32 then
        setProperty('defaultCamZoom', 0.92)
        xx2 = 600;
        followchars = true;
    end

    if curBeat == 64 then
        followchars = true;
        xx = 0;
        setProperty('defaultCamZoom', 0.75)
    end

    if curBeat == 66 then
        setProperty('defaultCamZoom', 1)
    end

    if curBeat == 68 then
        followchars = true;
        xx = 170;
        setProperty('defaultCamZoom', 0.92)
        setProperty('deadies.alpha', 1)
        setProperty('deadfront.alpha', 1)
    end

    if curBeat == 193 then
        setProperty('defaultCamZoom', 1.3)
        xx2 = 700;
        followchars = true;
    end

    if curBeat == 196 then
        setProperty('defaultCamZoom', 0.75)
        followchars = true;
        xx = 400;
        xx2 = 400;
        yy = 400;
        yy2 = 400;
    end

    if curBeat == 232 then
        setProperty('defaultCamZoom', 0.8)
    end

    if curBeat == 236 then
        setProperty('defaultCamZoom', 0.9)
    end

    if curBeat == 240 then
        setProperty('defaultCamZoom', 1)
    end

    if curBeat == 244 then
        setProperty('defaultCamZoom', 0.75)
    end

    if curBeat == 248 then
        setProperty('defaultCamZoom', 0.8)
    end

    if curBeat == 252 then
        setProperty('defaultCamZoom', 0.9)
    end

    if curBeat == 256 then
        setProperty('defaultCamZoom', 1)
    end

    if curBeat == 260 then
        setProperty('defaultCamZoom', 0.75)
    end

    if curBeat == 292 then
        xx = 170;
        yy = 420;
        xx2 = 600;
        yy2 = 420;
        followchars = true;
        setProperty('defaultCamZoom', 0.92)
        setProperty('deadies.alpha', 0)
        setProperty('deadfront.alpha', 0)
        setProperty('lightcone.alpha', 0)
        setProperty('blend.alpha', 0)
    end

    if curBeat == 356 then
        setProperty('defaultCamZoom', 1.3)
        xx2 = 700;
        followchars = true;
    end

    if curBeat == 356 then
        setProperty('defaultCamZoom', 0.92)
        xx2 = 600;
        followchars = true;
    end

    if curBeat == 360 then
        setProperty('deadies.alpha', 1)
        setProperty('deadfront.alpha', 1)
        setProperty('lightcone.alpha', 1)
        setProperty('blend.alpha', 1)
    end

    if curBeat == 424 then
        setProperty('defaultCamZoom', 0.92)
        xx2 = 600;
        followchars = true;
    end

    if curBeat == 456 then
        setProperty('defaultCamZoom', 0.75)
        followchars = true;
        xx = 420;
        xx2 = 420;
        yy = 400;
        yy2 = 400;
    end

    if curBeat == 460 then
        setProperty('defaultCamZoom', 0.8)
    end

    if curBeat == 464 then
        setProperty('defaultCamZoom', 0.9)
    end

    if curBeat == 468 then
        setProperty('defaultCamZoom', 1)
    end

    if curBeat == 472 then
        setProperty('defaultCamZoom', 0.75)
    end

    if curBeat == 476 then
        setProperty('defaultCamZoom', 0.8)
    end

    if curBeat == 480 then
        setProperty('defaultCamZoom', 0.9)
    end

    if curBeat == 484 then
        setProperty('defaultCamZoom', 1)
    end

    if curBeat == 488 then
        xx = 170;
        yy = 420;
        xx2 = 600;
        yy2 = 420;
        followchars = true;
        setProperty('defaultCamZoom', 0.92)
        setProperty('deadies.alpha', 0)
        setProperty('deadfront.alpha', 0)
    end

    if curBeat == 492 then
        setProperty('defaultCamZoom', 1)
        followchars = true;
        xx = 100;
    end

    if curBeat == 496 then
        setProperty('defaultCamZoom', 1.2)
        followchars = true;
        xx = 50;
    end

    if curBeat == 499 then
        setProperty('defaultCamZoom', 1.3)
        followchars = true;
        xx = 0;
    end

    if curBeat == 500 then
        setProperty('defaultCamZoom', 1.2)
        followchars = true;
        xx = 50;
    end

    if curBeat == 502 then
        setProperty('defaultCamZoom', 1)
        followchars = true;
        xx = 100;
    end

    if curBeat == 504 then
        setProperty('defaultCamZoom', 0.92)
        followchars = true;
        xx = 170;
    end

    if curBeat == 508 then
        setProperty('defaultCamZoom', 1)
        xx2 = 700;
        followchars = true;
    end

    if curBeat == 512 then
        setProperty('defaultCamZoom', 1.2)
        xx2 = 750;
        followchars = true;
    end

    if curBeat == 515 then
        setProperty('defaultCamZoom', 1.3)
        xx2 = 800;
        followchars = true;
    end

    if curBeat == 516 then
        setProperty('defaultCamZoom', 1.2)
        xx2 = 750;
        followchars = true;
    end

    if curBeat == 518 then
        setProperty('defaultCamZoom', 1)
        xx2 = 700;
        followchars = true;
    end

    if curBeat == 520 then
        setProperty('defaultCamZoom', 0.92)
        xx2 = 600;
        followchars = true;
    end

end

function onStepHit()

    if curStep == 1688 then
        setProperty('defaultCamZoom', 1)
        xx2 = 700;
        followchars = true;
    end

    if curStep == 1691 then
        setProperty('defaultCamZoom', 1.1)
        xx2 = 750;
        followchars = true;
    end

    if curStep == 1694 then
        setProperty('defaultCamZoom', 1.2)
        xx2 = 800;
        followchars = true;
    end

end