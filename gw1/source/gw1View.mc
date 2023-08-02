import Toybox.Application;
import Toybox.Graphics;
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
using Toybox.Time.Gregorian;
using Toybox.Time;
using Toybox.System;
using Toybox.ActivityMonitor as act;

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

        //DayOfWeek 
        var date = Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        var dayOfWeek = View.findDrawableById("DayOfWeek") as Text;
        dayOfWeek.setText(["Nie", "Pon", "Wto", "Śro", "Czw", "Pią", "Sob"][date.day_of_week - 1]);

        
        //Connected


        
        //BUTTON Battery
        //
        var stats = System.getSystemStats();
        var pwr = stats.battery;
        var batStr = Lang.format( "$1$%", [ pwr.format( "%2d" ) ] );


        //STEPS
        var step = ActivityMonitor.getInfo().steps;
        var stepsString = step.format("%d");
        var viewStep = View.findDrawableById("Steps") as Text;
        viewStep.setColor(getApp().getProperty("ForegroundColor") as Number);
        viewStep.setText("Kroki");

        var viewStepN = View.findDrawableById("StepsNumber") as Text;
        viewStepN.setColor(getApp().getProperty("ForegroundColor") as Number);
        viewStepN.setText(stepsString);
        
        
        //Piętra
        var floors = ActivityMonitor.getInfo().floorsClimbed;
        var floorsString = floors.format("%d");
        var viewpietra = View.findDrawableById("pietra") as Text;
        viewpietra.setColor(getApp().getProperty("ForegroundColor") as Number);
        viewpietra.setText("Piętra");

        var viewpietranr = View.findDrawableById("pietranr") as Text;
        viewpietranr.setColor(getApp().getProperty("ForegroundColor") as Number);
        viewpietranr.setText(floorsString);

        //Bateria
        var viewbateria = View.findDrawableById("bateria") as Text;
        viewbateria.setColor(getApp().getProperty("ForegroundColor") as Number);
        viewbateria.setText("Bateria");

        var viewbaterianr = View.findDrawableById("baterianr") as Text;
        viewbaterianr.setColor(getApp().getProperty("ForegroundColor") as Number);
        viewbaterianr.setText(batStr);

        //polaczenie
        var viewBattery = View.findDrawableById("Battery") as Text;
        viewBattery.setColor(getApp().getProperty("ForegroundColor") as Number);
        viewBattery.setText("Connected");




        
        // var date = Gregorian.info(Time.now(),Time.FORMAT_SHORT);
        // var systemStats =System.getSystemStats();
        // var viewDate = View.findDrawableById("Date").setText(
        //     date.year.format("%4") + "-" + date.month.format("%02d") + "-" + date.day.format("%02d"));
        //     viewDate.setColor(getApp().getProperty("ForegroundColor") as Number);

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
