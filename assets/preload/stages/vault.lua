local u = false;
local r = 0;
local shot = false;
local agent = 1
local health = 0;
local xx = -100;
local yy = 1450;
local xx2 = 400;
local yy2 = 1450;
local ofs = 10;
local followchars = true;
local del = 0;
local del2 = 0;
local angleshit = 1;
local anglevar = 1;

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

    if curBeat == 63 then
        setProperty('defaultCamZoom', 1)
    end

    if curBeat == 64 then
        setProperty('defaultCamZoom', 0.8)
    end

    if curBeat == 95 then
        setProperty('defaultCamZoom', 1)
    end

    if curBeat == 96 then
        setProperty('defaultCamZoom', 0.8)
    end

    if curBeat == 102 then
        setProperty('defaultCamZoom', 0.9)
    end

    if curBeat == 103 then
        setProperty('defaultCamZoom', 1)
    end

    if curBeat == 104 then
        setProperty('defaultCamZoom', 0.8)
    end

    if curBeat == 110 then
        setProperty('defaultCamZoom', 0.9)
    end

    if curBeat == 111 then
        setProperty('defaultCamZoom', 1)
    end

    if curBeat == 112 then
        setProperty('defaultCamZoom', 0.8)
    end

    if curBeat == 116 then
        setProperty('defaultCamZoom', 1)
    end

    if curBeat == 118 then
        setProperty('defaultCamZoom', 1.2)
    end

    if curBeat == 120 then
        setProperty('defaultCamZoom', 0.8)
    end

    if curBeat == 124 then
        setProperty('defaultCamZoom', 1)
    end

    if curBeat == 126 then
        setProperty('defaultCamZoom', 1.2)
    end

    if curBeat == 127 then
        setProperty('defaultCamZoom', 1.3)
    end

    if curBeat == 128 then
        setProperty('defaultCamZoom', 0.8)
    end

    if curBeat == 140 then
        setProperty('defaultCamZoom', 1)
    end

    if curBeat == 142 then
        setProperty('defaultCamZoom', 1.2)
    end

    if curBeat == 144 then
        setProperty('defaultCamZoom', 0.8)
    end

    if curBeat == 156 then
        setProperty('defaultCamZoom', 1)
    end

    if curBeat == 160 then
        setProperty('defaultCamZoom', 0.8)
    end

    if curBeat == 191 then
        setProperty('defaultCamZoom', 1)
    end

    if curBeat == 192 then
        setProperty('defaultCamZoom', 0.8)
    end

    if curBeat == 223 then
        setProperty('defaultCamZoom', 1)
    end

    if curBeat == 224 then
        setProperty('defaultCamZoom', 0.8)
    end

    if curBeat == 255 then
        setProperty('defaultCamZoom', 1)
    end

    if curBeat == 256 then
        setProperty('defaultCamZoom', 0.8)
    end

    if curBeat == 260 then
        setProperty('defaultCamZoom', 1)
    end

    if curBeat == 262 then
        setProperty('defaultCamZoom', 1.2)
    end

    if curBeat == 264 then
        setProperty('defaultCamZoom', 0.8)
    end

    if curBeat == 268 then
        setProperty('defaultCamZoom', 1)
    end

    if curBeat == 270 then
        setProperty('defaultCamZoom', 1.2)
    end

    if curBeat == 272 then
        setProperty('defaultCamZoom', 0.8)
    end

    if curBeat == 300 then
        setProperty('defaultCamZoom', 1)
    end

    if curBeat == 302 then
        setProperty('defaultCamZoom', 1.2)
    end

    if curBeat == 304 then
        setProperty('defaultCamZoom', 0.8)
    end

    if curBeat == 316 then
        setProperty('defaultCamZoom', 1)
    end

    if curBeat == 320 then
        setProperty('defaultCamZoom', 1.1)
    end

    if curBeat == 324 then
        setProperty('defaultCamZoom', 0.8)
    end

    if curBeat == 326 then
        setProperty('defaultCamZoom', 0.9)
    end

    if curBeat == 327 then
        setProperty('defaultCamZoom', 1)
    end

    if curBeat == 328 then
        setProperty('defaultCamZoom', 0.8)
    end

    if curBeat == 334 then
        setProperty('defaultCamZoom', 0.9)
    end

    if curBeat == 335 then
        setProperty('defaultCamZoom', 1)
    end

    if curBeat == 336 then
        setProperty('defaultCamZoom', 0.8)
    end

    if curBeat == 340 then
        setProperty('defaultCamZoom', 1)
    end

    if curBeat == 342 then
        setProperty('defaultCamZoom', 1.2)
    end

    if curBeat == 344 then
        setProperty('defaultCamZoom', 0.8)
    end

    if curBeat == 348 then
        setProperty('defaultCamZoom', 1)
    end

    if curBeat == 350 then
        setProperty('defaultCamZoom', 1.2)
    end

    if curBeat == 351 then
        setProperty('defaultCamZoom', 1.3)
    end

    if curBeat == 352 then
        setProperty('defaultCamZoom', 0.8)
    end

    if curBeat == 386 then
        setProperty('defaultCamZoom', 1)
    end

    if curBeat == 387 then
        setProperty('defaultCamZoom', 1.2)
    end

    if curBeat == 388 then
        setProperty('defaultCamZoom', 0.8)
    end

    if curBeat == 415 then
        setProperty('defaultCamZoom', 1)
    end

    if curBeat == 416 then
        setProperty('defaultCamZoom', 0.8)
    end

    if curBeat == 428 then
        setProperty('defaultCamZoom', 1)
    end

    if curBeat == 430 then
        setProperty('defaultCamZoom', 1.2)
    end

    if curBeat == 432 then
        setProperty('defaultCamZoom', 0.8)
    end

    if curBeat == 444 then
        setProperty('defaultCamZoom', 1)
    end

    if curBeat == 448 then
        setProperty('defaultCamZoom', 0.9)
    end

    if curBeat == 452 then
        setProperty('defaultCamZoom', 0.8)
    end

    if curBeat == 479 then
        setProperty('defaultCamZoom', 1)
    end

    if curBeat == 480 then
        setProperty('defaultCamZoom', 0.8)
    end

    if curBeat == 484 then
        setProperty('defaultCamZoom', 1)
    end

    if curBeat == 486 then
        setProperty('defaultCamZoom', 1.2)
    end

    if curBeat == 488 then
        setProperty('defaultCamZoom', 0.8)
    end

    if curBeat == 492 then
        setProperty('defaultCamZoom', 1)
    end

    if curBeat == 494 then
        setProperty('defaultCamZoom', 1.2)
    end

    if curBeat == 496 then
        setProperty('defaultCamZoom', 0.8)
    end

    if curBeat == 508 then
        setProperty('defaultCamZoom', 1)
    end

    if curBeat == 510 then
        setProperty('defaultCamZoom', 1.2)
    end

    if curBeat == 512 then
        setProperty('defaultCamZoom', 0.8)
    end

end