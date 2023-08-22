import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.WatchUi;
using Toybox.Time.Gregorian;
using Toybox.Time as T;
using Toybox.System as S;
using Toybox.ActivityMonitor as AM;

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
        //var timeFormat = "$1$:$2$";
        var timeFormatH = "$1$";
        var timeFormatM = "$2$";
        var clockTime = S.getClockTime();
        var hours = clockTime.hour;
        if (!S.getDeviceSettings().is24Hour) {
            if (hours > 24) {
                hours = hours - 24;
            }
        } else {
            if (getApp().getProperty("UseMilitaryFormat")) {
                hours = hours.format("%02d");
            }
        }
        var timeStringH = Lang.format(timeFormatH, [hours, clockTime.min.format("%02d")]);
        var timeStringM = Lang.format(timeFormatM, [hours, clockTime.min.format("%02d")]);
    
        // var timeStringM = Lang.format(timeFormat, [hours]);
        // Update the view
        var viewH = View.findDrawableById("HLabel") as Text;
        viewH.setText(timeStringH);

        var viewM = View.findDrawableById("MLabel") as Text;
        viewM.setText(timeStringM);

        //DayOfWeek 
        var day = Gregorian.info(T.now(), T.FORMAT_SHORT);
        var dayOfWeek = View.findDrawableById("DayOfWeek") as Text;
        dayOfWeek.setText(["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"][day.day_of_week - 1]);

        var date = Gregorian.info(T.now(), T.FORMAT_SHORT);
        var formatedDate = date.day.format("%02d") + "." + date.month.format("%02d");
        var fullDate = View.findDrawableById("Date") as Text;
        fullDate.setText(formatedDate);
        
        //BATTERY
        var stats = S.getSystemStats();
        var pwr = stats.battery;
        var batStr = Lang.format( "$1$%", [ pwr.format( "%2d" ) ] );
        var viewbateria = View.findDrawableById("Bat") as Text;
        viewbateria.setText("Battery");

        var viewbaterianr = View.findDrawableById("BatN") as Text;
        viewbaterianr.setText(batStr);

        //STEPS
        var step = AM.getInfo().steps;
        var stepsString = step.format("%d");
        var viewStep = View.findDrawableById("Step") as Text;
        //viewStep.setColor(getApp().getProperty("ForegroundColor") as Number);
        viewStep.setText("Steps");

        var viewStepN = View.findDrawableById("StepN") as Text;
        viewStepN.setText(stepsString);
        
        //Floors
        var floors = AM.getInfo().floorsClimbed;
        var floorsString = floors.format("%d");
        var viewpietra = View.findDrawableById("Floor") as Text;
        viewpietra.setText("Floors");

        var viewpietranr = View.findDrawableById("FloorN") as Text;
        viewpietranr.setText(floorsString);

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
