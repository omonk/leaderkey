try
    set userInput to text returned of (display dialog "Enter search term:" default answer "")
on error number -128
    -- user cancelled, exit silently
    return
end try

-- URL-encode
set encodedInput to do shell script "python3 -c \"import urllib.parse,sys; print(urllib.parse.quote(sys.argv[1]))\" " & quoted form of userInput

-- Open in default browser
do shell script "open 'https://www.google.com/search?q=" & encodedInput & "'"
