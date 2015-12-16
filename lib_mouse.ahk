;; this script provides : mouse move / click commands

;; ---------
;; variables
;; ---------

mouse = 0
mouse_mode_hook =               ; configurable

mouse_current_w =
mouse_current_h =
mouse_current_x =
mouse_current_y =
mouse_crosshair_x =
mouse_crosshair_y =

;; ---------
;; functions
;; ---------

mouse_set()
{ Global
    mouse = 1
    GUI, Add, Picture, X0 Y0 Vmouse_crosshair_x H2, lib_mouse_crosshair.png
    GUI, Add, Picture, X0 Y0 Vmouse_crosshair_y W2, lib_mouse_crosshair.png
    GUI, +AlwaysOnTop +LastFound
    GUI, Color, 000000
    WinSet, Transparent, 150
    GUI, -Caption ; this must be done AFTER setting transparency (Why?)
    mouse_update(0, 0, A_ScreenWidth, A_ScreenHeight, 0)
}

mouse_reset()
{ Global
    GUI, Destroy
    mouse = 0
}

mouse_update(newx, newy, neww, newh, nomove)
{ Global
    Local ch_x, ch_y
    If mouse
    {
        mouse_current_x := newx
        mouse_current_y := newy
        mouse_current_w := neww
        mouse_current_h := newh
        ch_y := newh / 2 - 1
        ch_x := neww / 2 - 1
        GUI, Show, NoActivate X%newx% Y%newy% W%neww% H%newh%
        GUIControl, Move, mouse_crosshair_x, W%neww% Y%ch_y%
        GUIControl, Move, mouse_crosshair_y, H%newh% X%ch_x%
        if !nomove
            MouseMove, % newx + (neww / 2), % newy + (newh / 2)
    }
}

mouse_click_command(side, count)
{ Global
    Local x, y, key
    run_hooks("pre_command_hook")
    mouse_reset()
    MouseGetPos, x, y
    count := count * (arg ? arg : 1)
    key = {Click, %side%, %x%, %y%, %count%}
    send(key)
    run_hooks("post_command_hook")
}

;; --------
;; commands
;; --------

mouse_mode()
{
    run_hooks("pre_command_hook")
    mouse_set()
    run_hooks("mouse_mode_hook")
    run_hooks("post_command_hook")
}

mouse_mode_end()
{
    run_hooks("pre_command_hook")
    mouse_reset()
    run_hooks("post_command_hook")
}

mouse_left()
{ Global
    run_hooks("pre_command_hook")
    mouse_update(mouse_current_x, mouse_current_y, mouse_current_w / 2, mouse_current_h, 0)
    run_hooks("post_command_hook")
}

mouse_up()
{ Global
    run_hooks("pre_command_hook")
    mouse_update(mouse_current_x, mouse_current_y, mouse_current_w, mouse_current_h / 2, 0)
    run_hooks("post_command_hook")
}

mouse_down()
{ Global
    Local newy
    run_hooks("pre_command_hook")
    newy := mouse_current_y + mouse_current_h / 2
    mouse_update(mouse_current_x, newy, mouse_current_w, mouse_current_h / 2, 0)
    run_hooks("post_command_hook")
}

mouse_right()
{ Global
    Local newx
    run_hooks("pre_command_hook")
    newx := mouse_current_x + (mouse_current_w / 2)
    mouse_update(newx, mouse_current_y, mouse_current_w / 2, mouse_current_h, 0)
    run_hooks("post_command_hook")
}

mouse_upleft()
{ Global
    run_hooks("pre_command_hook")
    mouse_update(mouse_current_x, mouse_current_y, mouse_current_w / 2, mouse_current_h / 2, 0)
    run_hooks("post_command_hook")
}

mouse_upright()
{ Global
    Local newx
    run_hooks("pre_command_hook")
    newx := mouse_current_x + (mouse_current_w / 2)
    mouse_update(newx, mouse_current_y, mouse_current_w / 2, mouse_current_h / 2, 0)
    run_hooks("post_command_hook")
}

mouse_downleft()
{ Global
    Local newy
    run_hooks("pre_command_hook")
    newy := mouse_current_y + mouse_current_h / 2
    mouse_update(mouse_current_x, newy, mouse_current_w / 2, mouse_current_h / 2, 0)
    run_hooks("post_command_hook")
}

mouse_downright()
{ Global
    Local newx, newy
    run_hooks("pre_command_hook")
    newx := mouse_current_x + mouse_current_w / 2
    newy := mouse_current_y + mouse_current_h / 2
    mouse_update(newx, newy, mouse_current_w / 2, mouse_current_h / 2, 0)
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
