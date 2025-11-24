use framework "Foundation"
use scripting additions

-- Try to save existing clipboard, skip if it fails
try
    set oldClipboard to the clipboard
on error
    set oldClipboard to missing value
end try

-- Trigger Cmd+C to copy highlighted text
tell application "System Events"
    keystroke "c" using command down
end tell

-- Small delay for clipboard to update
delay 0.05

-- Read pasteboard
set pb to current application's NSPasteboard's generalPasteboard()
set typesList to (pb's types()) as list

-- Only continue if text was copied
if typesList contains (current application's NSPasteboardTypeString) then
    set copiedText to the clipboard as text
    
    -- Ignore empty/whitespace selections
    if copiedText is not "" and copiedText is not space then
        
        -- URL-encode text
        set encoded to do shell script "python3 -c \"import urllib.parse,sys; print(urllib.parse.quote(sys.argv[1]))\" " & quoted form of copiedText
        
        -- Open Google search
        do shell script "open 'https://www.google.com/search?q=" & encoded & "'"
    end if
end if

-- Restore original clipboard only if we successfully saved it
if oldClipboard is not missing value then
    set the clipboard to oldClipboard
end if
