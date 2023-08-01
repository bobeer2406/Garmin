import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.Time.Gregorian;
import Toybox.Time;

class gw1View extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        //TIME  CENTER

        // Get the current time and format it correctly
        var timeFormat = "$1$:$2$";
        var timeFormatH = "$1$";
        var timeFormatM = "$2$";
        var clockTime = System.getClockTime();
        var hours = clockTime.hour;
        if (!System.getDeviceSettings().is24Hour) {
            if (hours > 24) {
                hours = hours - 24;
            }
        } else {
            if (getApp().getProperty("UseMilitaryFormat")) {
                timeFormat = "$1$$2$";
                hours = hours.format("%02d");
            }
        }
        var timeStringH = Lang.format(timeFormatH, [hours, clockTime.min.format("%02d")]);
        var timeStringM = Lang.format(timeFormatM, [hours, clockTime.min.format("%02d")]);
    
        // var timeStringM = Lang.format(timeFormat, [hours]);
        // Update the view
        var viewH = View.findDrawableById("HLabel") as Text;
        viewH.setColor(getApp().getProperty("ForegroundColor") as Number);
        viewH.setText(timeStringH);

        var viewM = View.findDrawableById("MLabel") as Text;
        viewM.setColor(getApp().getProperty("ForegroundColor") as Number);
        viewM.setText(timeStringM);

        //BUTTON TOP DATE
        //

        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() as Void {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() as Void {
    }

}
