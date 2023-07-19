function onCreate()

    makeLuaSprite('barbg3', nil, -600, 200)
    makeGraphic('barbg3', getTextFromFile('data/'..string.lower(songName)..'/songinfocover/width.txt'), 110, getTextFromFile('data/'..string.lower(songName)..'/songinfocover/color.txt'))
    setObjectCamera('barbg3', 'other')
    setProperty('barbg3.alpha', 0.7)
    addLuaSprite('barbg3', false)

    makeLuaText('songtxt3', getTextFromFile('data/'..string.lower(songName)..'/songinfocover/songname.txt'), widthtext, 0, 0)
    setProperty('songtxt3.x', getProperty('barbg3.x') + 3);
    setProperty('songtxt3.y', getProperty('barbg3.y') + 4);
    setObjectCamera('songtxt3', 'other')
    setTextAlignment('songtxt3', 'left')
    setTextFont('songtxt3', 'arial.ttf')
    setTextSize('songtxt3', 30)
    addLuaText('songtxt3')

    makeLuaText('composer3', getTextFromFile('data/'..string.lower(songName)..'/songinfocover/composer.txt'), widthtext, 0, 0)
    setProperty('composer3.x', getProperty('songtxt3.x'));
    setProperty('composer3.y', getProperty('songtxt3.y') + 30);
    setObjectCamera('composer3', 'other')
    setTextAlignment('composer3', 'left')
    setTextFont('composer3', 'arial.ttf')
    setTextSize('composer3', 30)
    addLuaText('composer3')

    makeLuaText('original', getTextFromFile('data/'..string.lower(songName)..'/songinfocover/original.txt'), widthtext, 0, 0)
    setProperty('original.x', getProperty('songtxt3.x'));
    setProperty('original.y', getProperty('songtxt3.y') + 30);
    setObjectCamera('original', 'other')
    setTextAlignment('original', 'left')
    setTextFont('original', 'arial.ttf')
    setTextSize('original', 30)
    addLuaText('original')

end

function onUpdate()
    setProperty('songtxt3.x', getProperty('barbg3.x') + 3);
    setProperty('songtxt3.y', getProperty('barbg3.y') + 4);
    setProperty('composer3.x', getProperty('songtxt3.x'));
    setProperty('composer3.y', getProperty('songtxt3.y') + 30);
    setProperty('original.x', getProperty('songtxt3.x'));
    setProperty('original.y', getProperty('songtxt3.y') + 60);
end

function onSongStart()
    doTweenX('sidebarin3', 'barbg3', 0, 1, 'quintOut')
end

function onTweenCompleted(tag)
    if tag == 'sidebarin3' then
        runTimer('tweentimer2', 2)
    end
    if tag == 'sidebarout3' then
        removeLuaSprite('barbg3')
        removeLuaSprite('songtxt3')
        removeLuaSprite('composer3')
        removeLuaSprite('original')
    end
end

function onTimerCompleted(tag)
    if tag == 'tweentimer2' then
        doTweenX('songtweenout3','barbg3', -600, 1,'quintIn')
    end
end