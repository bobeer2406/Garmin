
import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;

import Toybox.ActivityMonitor;
import Toybox.Math;
using Toybox.Graphics as Gfx;
using Toybox.Time.Gregorian as Calendar;
using Toybox.Time as Time;



class WF2View extends WatchUi.WatchFace {
    var lowPowerMode = true;	
    var customFont   = null;
    var customFont65 = null;
    var customFont75 = null;
    var heart80   = null;

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        customFont   = WatchUi.loadResource(Rez.Fonts.trebuchetMS_50);  
    	customFont65 = WatchUi.loadResource(Rez.Fonts.trebuchetMS_65);
    	customFont75 = WatchUi.loadResource(Rez.Fonts.trebuchetMS_75); 
    	
    }

    // Update the view
    function onUpdate(dc) {
        View.onUpdate(dc);  
        var width      = dc.getWidth();
        var height     = dc.getHeight();
            
       
    
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        var dateInfo = Calendar.info(Time.now(), Time.FORMAT_MEDIUM);
        dc.drawText(80, 20 , customFont, ""+dateInfo.day, Gfx.TEXT_JUSTIFY_CENTER); 

        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        var dateInfo2 = Calendar.info(Time.now(), Time.FORMAT_MEDIUM);
        dc.drawText(90, 40 , customFont65, ""+dateInfo2.day, Gfx.TEXT_JUSTIFY_CENTER); 
        
        dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
        var dateInfo3 = Calendar.info(Time.now(), Time.FORMAT_MEDIUM);
        dc.drawText(80, 100 , customFont75, ""+dateInfo3.day, Gfx.TEXT_JUSTIFY_CENTER); 

        
      


    
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    function onExitSleep() {
    lowPowerMode = true;
      
    }

    function onEnterSleep() {
    lowPowerMode = false;
         
    }
}
