set clip to (the clipboard as text)
set clip to clip's text from 1 to (length of clip) -- coercion ensures it's text

-- Trim leading/trailing spaces via shell
set clip to do shell script "printf \"%s\" " & quoted form of clip & " | awk '{$1=$1;print}'"

if clip is "" then return

set encodedClip to do shell script "python3 -c \"import urllib.parse,sys; print(urllib.parse.quote(sys.argv[1]))\" " & quoted form of clip
do shell script "open 'https://www.google.com/search?q=" & encodedClip & "'"
