types = { 'normal', '480p', 'cover' }

function onCreate()
	for i = 1, #types do
		if pcall(function() getTextFromFile('data/'..string.lower(songName)..'/songinfo'..(types[i] == 'normal' and '' or types[i])..'/songname.txt') end) then
			addLuaScript('scripts/bars_type/'..types[i])
			break
		end
	end
end