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
mouse_crosshair_hu =
mouse_crosshair_h =
mouse_crosshair_hd =
mouse_crosshair_vl =
mouse_crosshair_v =
mouse_crosshair_vr =

;; ---------
;; functions
;; ---------

mouse_set()
{ Global
    Local window_x, window_y, window_h, window_w

    mouse = 1
    GUI, Add, Picture, X0 Y0 Vmouse_crosshair_huu H2, lib_mouse_crosshair_3rd.png
    GUI, Add, Picture, X0 Y0 Vmouse_crosshair_hu  H2, lib_mouse_crosshair_2nd.png
    GUI, Add, Picture, X0 Y0 Vmouse_crosshair_hud H2, lib_mouse_crosshair_3rd.png
    GUI, Add, Picture, X0 Y0 Vmouse_crosshair_h   H2, lib_mouse_crosshair.png
    GUI, Add, Picture, X0 Y0 Vmouse_crosshair_hdu H2, lib_mouse_crosshair_3rd.png
    GUI, Add, Picture, X0 Y0 Vmouse_crosshair_hd  H2, lib_mouse_crosshair_2nd.png
    GUI, Add, Picture, X0 Y0 Vmouse_crosshair_hdd H2, lib_mouse_crosshair_3rd.png
    GUI, Add, Picture, X0 Y0 Vmouse_crosshair_vll W2, lib_mouse_crosshair_3rd.png
    GUI, Add, Picture, X0 Y0 Vmouse_crosshair_vl  W2, lib_mouse_crosshair_2nd.png
    GUI, Add, Picture, X0 Y0 Vmouse_crosshair_vlr W2, lib_mouse_crosshair_3rd.png
    GUI, Add, Picture, X0 Y0 Vmouse_crosshair_v   W2, lib_mouse_crosshair.png
    GUI, Add, Picture, X0 Y0 Vmouse_crosshair_vrl W2, lib_mouse_crosshair_3rd.png
    GUI, Add, Picture, X0 Y0 Vmouse_crosshair_vr  W2, lib_mouse_crosshair_2nd.png
    GUI, Add, Picture, X0 Y0 Vmouse_crosshair_vrr W2, lib_mouse_crosshair_3rd.png
    GUI, +AlwaysOnTop +LastFound
    GUI, Color, 000000
    WinSet, Transparent, 150
    GUI, -Caption ; this must be done AFTER setting transparency (Why?)

    WinGetPos, window_x, window_y, window_w, window_h, A
    mouse_update(window_x, window_y, window_w, window_h, 0)
}

mouse_reset()
{ Global
    GUI, Destroy
    mouse = 0
}

mouse_update(newx, newy, neww, newh, nomove)
{ Global
    Local ch_huu_y, ch_hu_y, ch_hud_y, ch_h_y, ch_hdu_y, ch_hd_y, ch_hdd_y
    Local ch_vll_x, ch_vl_x, ch_vlr_x, ch_v_x, ch_vrl_x, ch_vr_x, ch_vrr_x
    If mouse
    {
        mouse_current_x := newx
        mouse_current_y := newy
        mouse_current_w := neww
        mouse_current_h := newh
        ch_huu_y := newh * 1 / 8 - 1
        ch_hu_y  := newh * 2 / 8 - 1
        ch_hud_y := newh * 3 / 8 - 1
        ch_h_y   := newh * 4 / 8 - 1
        ch_hdu_y := newh * 5 / 8 - 1
        ch_hd_y  := newh * 6 / 8 - 1
        ch_hdd_y := newh * 7 / 8 - 1
        ch_vll_x := neww * 1 / 8 - 1
        ch_vl_x  := neww * 2 / 8 - 1
        ch_vlr_x := neww * 3 / 8 - 1
        ch_v_x   := neww * 4 / 8 - 1
        ch_vrl_x := neww * 5 / 8 - 1
        ch_vr_x  := neww * 6 / 8 - 1
        ch_vrr_x := neww * 7 / 8 - 1
        GUI, Show, NoActivate X%newx% Y%newy% W%neww% H%newh%
        GUIControl, Move, mouse_crosshair_huu, W%neww% Y%ch_huu_y%
        GUIControl, Move, mouse_crosshair_hu,  W%neww% Y%ch_hu_y%
        GUIControl, Move, mouse_crosshair_hud, W%neww% Y%ch_hud_y%
        GUIControl, Move, mouse_crosshair_h,   W%neww% Y%ch_h_y%
        GUIControl, Move, mouse_crosshair_hdu, W%neww% Y%ch_hdu_y%
        GUIControl, Move, mouse_crosshair_hd,  W%neww% Y%ch_hd_y%
        GUIControl, Move, mouse_crosshair_hdd, W%neww% Y%ch_hdd_y%
        GUIControl, Move, mouse_crosshair_vll, H%newh% X%ch_vll_x%
        GUIControl, Move, mouse_crosshair_vl,  H%newh% X%ch_vl_x%
        GUIControl, Move, mouse_crosshair_vlr, H%newh% X%ch_vlr_x%
        GUIControl, Move, mouse_crosshair_v,   H%newh% X%ch_v_x%
        GUIControl, Move, mouse_crosshair_vrl, H%newh% X%ch_vrl_x%
        GUIControl, Move, mouse_crosshair_vr,  H%newh% X%ch_vr_x%
        GUIControl, Move, mouse_crosshair_vrr, H%newh% X%ch_vrr_x%
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
