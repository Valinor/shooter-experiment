7z a -tzip Promo.love main.lua drone.lua baddrone.lua conf.lua ressources
mkdir build
mkdir dist
copy /b C:\scoop\apps\love\current\love.exe+Promo.love build\AffectusMiniGame1.exe
love.js.cmd Promo.love ./dist --title "Affectus Promo Game 1"