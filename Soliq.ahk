; ============================================================
;  NumPad Auto-Typer (0000–9999)
; ============================================================

; --- SOZLAMALAR ---
OFFSET_X  := 0      ; klaviatura chap chegarasining ekrandagi X koordinatasi
OFFSET_Y  := 0      ; klaviatura yuqori chegarasining ekrandagi Y koordinatasi
DELAY_MS  := 420     ; 120 har bir bosish orasidagi kutish (ms)
START_NUM := 0   ; boshlang'ich son
END_NUM   := 9999   ; oxirgi son
CLICK_DUR := 70     ; 30 klik ushlab turish vaqti (ms)

; Tasdiqlash tugmasi koordinatasi
CONFIRM_X := 800
CONFIRM_Y := 400

; Raqam tugmalarining koordinatalari
;   1      2      3      4      5      6      7      8      9      0
NX := [800, 950, 1080,  800, 950, 1080,  800, 950, 1080,  940]
NY := [600, 600,  600,  720, 720,  720,  840, 840,  840,  970]

; --- BOSHQARUV ---
running := false
startNum := START_NUM

; Win+R → ishga tushirish
#r::
    if (running)
        return

    running := true
    SetTimer, TypeNumbers, -1
return

; Win+S → to'xtatish
#s::
    running := false
return

TypeNumbers:
    Loop, % (END_NUM - startNum + 1)
    {
        if (!running)
            return

        num := startNum + A_Index - 1

        ; Har doim 4 xonali ko'rinish: 0000, 0001, ...
        numStr := Format("{:04d}", num)

        ; 4 ta raqamni bosish
        Loop, 4
        {
            digit := SubStr(numStr, A_Index, 1)

            if (digit = "0")
                idx := 10
            else
                idx := digit + 0

            cx := OFFSET_X + NX[idx]
            cy := OFFSET_Y + NY[idx]

            MouseMove, %cx%, %cy%, 0
            Click

            Sleep, DELAY_MS
        }

        ; Tasdiqlash tugmasi
        Sleep, DELAY_MS
        MouseMove, %CONFIRM_X%, %CONFIRM_Y%, 0
        Click

        Sleep, DELAY_MS * 2
    }

    running := false
return