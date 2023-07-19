function onCreate()

    makeLuaSprite('barbg', nil, -600, 200)
    makeGraphic('barbg', getTextFromFile('data/'..string.lower(songName)..'/songinfo/width.txt'), 80, getTextFromFile('data/'..string.lower(songName)..'/songinfo/color.txt'))
    setObjectCamera('barbg', 'other')
    setProperty('barbg.alpha', 0.7)
    addLuaSprite('barbg', false)

    makeLuaText('songtxt', getTextFromFile('data/'..string.lower(songName)..'/songinfo/songname.txt'), widthtext, 0, 0)
    setProperty('songtxt.x', getProperty('barbg.x') + 3);
    setProperty('songtxt.y', getProperty('barbg.y') + 4);
    setObjectCamera('songtxt', 'other')
    setTextAlignment('songtxt', 'left')
    setTextFont('songtxt', 'arial.ttf')
    setTextSize('songtxt', 30)
    addLuaText('songtxt')

    makeLuaText('composer', getTextFromFile('data/'..string.lower(songName)..'/songinfo/composer.txt'), widthtext, 0, 0)
    setProperty('composer.x', getProperty('songtxt.x'));
    setProperty('composer.y', getProperty('songtxt.y') + 30);
    setObjectCamera('composer', 'other')
    setTextAlignment('composer', 'left')
    setTextFont('composer', 'arial.ttf')
    setTextSize('composer', 30)
    addLuaText('composer')
end

function onUpdate()
    setProperty('songtxt.x', getProperty('barbg.x') + 3);
    setProperty('songtxt.y', getProperty('barbg.y') + 4);
    setProperty('composer.x', getProperty('songtxt.x'));
    setProperty('composer.y', getProperty('songtxt.y') + 30);
end

function onSongStart()
    doTweenX('sidebarin', 'barbg', 0, 1, 'quintOut')
end

function onTweenCompleted(tag)
    if tag == 'sidebarin' then
        runTimer('tweentimer', 2)
    end
    if tag == 'sidebarout' then
        removeLuaSprite('barbg')
        removeLuaSprite('songtxt')
        removeLuaSprite('composer')
    end
end

function onTimerCompleted(tag)
    if tag == 'tweentimer' then
        doTweenX('songtweenout','barbg', -600, 1,'quintIn')
    end
end