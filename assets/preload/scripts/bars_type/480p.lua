function onCreate()

    makeLuaSprite('barbg2', nil, -600, 200)
    makeGraphic('barbg2', getTextFromFile('data/'..string.lower(songName)..'/songinfo480p/width.txt'), 80, getTextFromFile('data/'..string.lower(songName)..'/songinfo480p/color.txt'))
    setObjectCamera('barbg2', 'other')
    setProperty('barbg2.alpha', 0.7)
    addLuaSprite('barbg2', false)

    makeLuaText('songtxt2', getTextFromFile('data/'..string.lower(songName)..'/songinfo480p/songname.txt'), widthtext, 0, 0)
    setProperty('songtxt2.x', getProperty('barbg2.x') + 3);
    setProperty('songtxt2.y', getProperty('barbg2.y') + 4);
    setObjectCamera('songtxt2', 'other')
    setTextAlignment('songtxt2', 'left')
    setTextFont('songtxt2', 'arial.ttf')
    setTextSize('songtxt2', 30)
    addLuaText('songtxt2')

    makeLuaText('composer2', getTextFromFile('data/'..string.lower(songName)..'/songinfo480p/composer.txt'), widthtext, 0, 0)
    setProperty('composer2.x', getProperty('songtxt2.x'));
    setProperty('composer2.y', getProperty('songtxt2.y') + 30);
    setObjectCamera('composer2', 'other')
    setTextAlignment('composer2', 'left')
    setTextFont('composer2', 'arial.ttf')
    setTextSize('composer2', 30)
    addLuaText('composer2')

end

function onUpdate()
    setProperty('songtxt2.x', getProperty('barbg2.x') + 3);
    setProperty('songtxt2.y', getProperty('barbg2.y') + 4);
    setProperty('composer2.x', getProperty('songtxt2.x'));
    setProperty('composer2.y', getProperty('songtxt2.y') + 30);
end

function onSongStart()
    doTweenX('sidebarin2', 'barbg2', 159, 1, 'quintOut')
end

function onTweenCompleted(tag)
    if tag == 'sidebarin2' then
        runTimer('tweentimer1', 2)
    end
    if tag == 'sidebarout2' then
        removeLuaSprite('barbg2')
        removeLuaSprite('songtxt2')
        removeLuaSprite('composer2')
    end
end

function onTimerCompleted(tag)
    if tag == 'tweentimer1' then
        doTweenX('songtweenout2','barbg2', -600, 1,'quintIn')
    end
end