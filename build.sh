rm game.zip
rm -rf html
npx love.js -c src html
cp index.html html/index.html
zip -r game.zip html/*