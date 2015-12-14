;; this script provides : mouse move / click commands

;; Usage:
;;

;; ---------
;; variables
;; ---------

mouse = 0
mouse_mode_hook =               ; configurable

mouse_current_w =
mouse_current_h =
mouse_current_x =
mouse_current_y =

;; ---------
;; functions
;; ---------

mouse_set()
{ Global
    mouse = 1
    GUI, +AlwaysOnTop +LastFound
    GUI, Color, 000000, 111111
    WinSet, Transparent, 150
    GUI, -Caption ; this must be done AFTER setting transparency (Why?)
    mouse_update(0, 0, A_ScreenWidth, A_ScreenHeight)
}

mouse_reset()
{ Global
    GUI, Destroy
    mouse = 0
}

mouse_update(newx, newy, neww, newh)
{ Global
    If mouse
    {
        mouse_current_x := newx
        mouse_current_y := newy
        mouse_current_w := neww
        mouse_current_h := newh
        GUI, Show, NoActivate X%newx% Y%newy% W%neww% H%newh%
        MouseMove, % newx + (neww / 2), % newy + (newh / 2)
    }
}

mouse_click_command(side, count)
{ Global
    Local x, y, key
    run_hooks("pre_command_hook")
    mouse_reset()
    MouseGetPos, x, y
    key = {Click, %side%, %x%, %y%, %count%}
    Loop, % arg ? arg : 1
        send(key)
    run_hooks("post_command_hook")
}

;; --------
;; commands
;; --------

mouse_mode()
{ Global
    run_hooks("pre_command_hook")
    mouse_set()
    run_hooks("mouse_mode_hook")
    run_hooks("post_command_hook")
}

mouse_mode_end()
{ Global
    run_hooks("pre_command_hook")
    mouse_reset()
    run_hooks("post_command_hook")
}

mouse_left()
{ Global
    Local newx
    run_hooks("pre_command_hook")
    mouse_update(mouse_current_x, mouse_current_y, mouse_current_w / 2, mouse_current_h)
    run_hooks("post_command_hook")
}

mouse_up()
{ Global
    run_hooks("pre_command_hook")
    mouse_update(mouse_current_x, mouse_current_y, mouse_current_w, mouse_current_h / 2)
    run_hooks("post_command_hook")
}

mouse_down()
{ Global
    Local newy
    run_hooks("pre_command_hook")
    newy := mouse_current_y + mouse_current_h / 2
    mouse_update(mouse_current_x, newy, mouse_current_w, mouse_current_h / 2)
    run_hooks("post_command_hook")
}

mouse_right()
{ Global
    run_hooks("pre_command_hook")
    newx := mouse_current_x + (mouse_current_w / 2)
    mouse_update(newx, mouse_current_y, mouse_current_w / 2, mouse_current_h)
    run_hooks("post_command_hook")
}

mouse_lclick()
{
    mouse_click_command("L", 1)
}

mouse_rclick()
{
    mouse_click_command("R", 1)
}

mouse_ldclick()
{
    mouse_click_command("L", 2)
}

mouse_rdclick()
{
    mouse_click_command("R", 2)
}
