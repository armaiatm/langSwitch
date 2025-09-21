^+l:: {  ; Ctrl + Shift + L to flip layout
    ; Save original clipboard
    origClip := A_Clipboard
    A_Clipboard := ""
    Send "^c"
    ClipWait(1)
    text := A_Clipboard

    ; Hebrew-English layout map
    layoutMap := Map(
        "a", "ש", "b", "נ", "c", "ב", "d", "ג", "e", "ק", "f", "כ",
        "g", "ע", "h", "י", "i", "ן", "j", "ח", "k", "ל", "l", "ך",
        "m", "צ", "n", "מ", "o", "ם", "p", "פ", "q", "/", "r", "ר",
        "s", "ד", "t", "א", "u", "ו", "v", "ה", "w", "'", "x", "ס",
        "y", "ט", "z", "ז",
		",", "ת"
    )

    ; Build reverse map
    reverseMap := Map()
    for k, v in layoutMap
        reverseMap[v] := k

    ; Detect direction
    isHebrew := RegExMatch(text, "[א-ת]")
    mapToUse := isHebrew ? reverseMap : layoutMap

    ; Flip layout
    flipped := ""
    for char in StrSplit(text) {
        lower := StrLower(char)
        flipped .= mapToUse.Has(lower) ? mapToUse[lower] : char
    }

    ; Replace selection
    A_Clipboard := flipped
    Send "^v"
    Sleep 100
    A_Clipboard := origClip
}
