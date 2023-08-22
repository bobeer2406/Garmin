
import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.ActivityMonitor;
import Toybox.Math;
using Toybox.Graphics as Gfx;
using Toybox.Time.Gregorian as Calendar;
using Toybox.Time as Time;
using Toybox.ActivityMonitor as AM;
using Toybox.System as S;
using Toybox.BluetoothLowEnergy as BT;

class GWView extends WatchUi.WatchFace {
  var customLat_85 = true;
  var customLat_20 = true;
  var lowPowerMode = true;
  var customQSand = null;
  var customQSand28 = null;
  var customQSand_100 = null;
  var bt = null;
  var btn = null;
 
  function initialize() { WatchFace.initialize(); }

  // Load your resources here
  function onLayout(dc) {
    customLat_85 = WatchUi.loadResource(Rez.Fonts.Latin_85);
    customLat_20 = WatchUi.loadResource(Rez.Fonts.Latin_20);
    customQSand = WatchUi.loadResource(Rez.Fonts.QSand);
    customQSand28 = WatchUi.loadResource(Rez.Fonts.QSand28);
    customQSand_100 = WatchUi.loadResource(Rez.Fonts.QSand_100);
    bt = WatchUi.loadResource(Rez.Drawables.BT);
    btn = WatchUi.loadResource(Rez.Drawables.BTn);
  }

  // Update the view
  function onUpdate(dc) {
    View.onUpdate(dc);

    // CLOCK
    dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_TRANSPARENT);
    var time = System.getClockTime();
    var tFormatH = time.hour.format("%02d");
    var tFormatM = time.min.format("%02d");

    dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
    dc.drawText(90, 30, customLat_85, tFormatH, Gfx.TEXT_JUSTIFY_CENTER);
    dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_TRANSPARENT);
    dc.drawText(125, 95, customLat_85, tFormatM, Gfx.TEXT_JUSTIFY_CENTER);
    dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_TRANSPARENT);
     // BT
    var mySystem = System.getDeviceSettings();
    if (mySystem.phoneConnected) {
      dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_TRANSPARENT);
    } else {
       dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
    }
    //LINE
    dc.drawLine(38, 105, 130, 105);
    
    dc.drawLine(38, 107, 130, 107);

    //DATE
    dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_TRANSPARENT);
    var dateInfo4 = Calendar.info(Time.now(), Time.FORMAT_MEDIUM);
    var dateInfo = Calendar.info(Time.now(), Time.FORMAT_SHORT);
    var dateformat = dateInfo4.day.format("%02d") + "." +
                      dateInfo.month.format("%02d") ;
     dc.drawText(180, 50, customLat_20, "DT: ", Gfx.TEXT_JUSTIFY_CENTER);
     dc.drawText(180, 70, customLat_20, dateformat, Gfx.TEXT_JUSTIFY_CENTER);

    // STEPS
    dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
    var step = AM.getInfo().steps;
    var stepGoal  = AM.getInfo().stepGoal;
    var step10  = stepGoal * 0.1;
    var step30  = stepGoal * 0.3;
    var step50  = stepGoal * 0.5;
    var step70  = stepGoal * 0.7;
    var step90  = stepGoal * 0.9;
    var step100 = stepGoal * 1;
    
    if(step >= 0 && step <= step10){
      dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
    }else if(step > step10 && step <= step30){
      dc.setColor(Gfx.COLOR_YELLOW, Gfx.COLOR_TRANSPARENT);
    }else if(step > step30 && step <= step50){
      dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_TRANSPARENT);
    }else if(step > step50 && step <= step70){
      dc.setColor(Gfx.COLOR_PURPLE, Gfx.COLOR_TRANSPARENT);
    }else if(step > step70 && step <= step90){
      dc.setColor(Gfx.COLOR_ORANGE, Gfx.COLOR_TRANSPARENT);
    }else if(step > step90 && step < step100){
      dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_TRANSPARENT);
    }

    dc.drawText(115, 10, customLat_20, "ST:" + step,
                Gfx.TEXT_JUSTIFY_CENTER);
    
    dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
    dc.drawCircle(82, 35, 3);
    dc.setColor(Gfx.COLOR_YELLOW, Gfx.COLOR_TRANSPARENT);
    dc.drawCircle(92, 35, 3);
    dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_TRANSPARENT);
    dc.drawCircle(102, 35, 3);
    dc.setColor(Gfx.COLOR_PURPLE, Gfx.COLOR_TRANSPARENT);
    dc.drawCircle(122, 35, 3);
    dc.setColor(Gfx.COLOR_ORANGE, Gfx.COLOR_TRANSPARENT);
    dc.drawCircle(132, 35, 3);
    dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_TRANSPARENT);
    dc.drawCircle(142, 35, 3);

    // FLOORS
    dc.setColor(Gfx.COLOR_WHITE, Gfx.COLOR_TRANSPARENT);
    var floor = AM.getInfo().floorsClimbed;
    var floorGoal =AM.getInfo().floorsClimbedGoal;
    var floorGoal10  = floorGoal * 0.1;
    var floorGoal30  = floorGoal * 0.3;
    var floorGoal50  = floorGoal * 0.5;
    var floorGoal70  = floorGoal * 0.7;
    var floorGoal90  = floorGoal * 0.9;
    var floorGoal100 = floorGoal * 1;
    
    if(floor >= 0 && floor <= floorGoal10){
      dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);

    }else if(floor > floorGoal10 && floor <= floorGoal30){
      dc.setColor(Gfx.COLOR_YELLOW, Gfx.COLOR_TRANSPARENT);

    }else if(floor > floorGoal30 && floor <= floorGoal50){
      dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_TRANSPARENT);

    }else if(floor > floorGoal50 && floor <= floorGoal70){
      dc.setColor(Gfx.COLOR_PURPLE, Gfx.COLOR_TRANSPARENT);

    }else if(floor > floorGoal70 && floor <= floorGoal90){
      dc.setColor(Gfx.COLOR_ORANGE, Gfx.COLOR_TRANSPARENT);

    }else if(floor > floorGoal90 && floor < floorGoal100){
      dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_TRANSPARENT);
    }
    dc.drawText(115, 180, customLat_20, "CL:" + floor, Gfx.TEXT_JUSTIFY_CENTER);

    dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
    dc.drawCircle(82, 205, 3);
    dc.setColor(Gfx.COLOR_YELLOW, Gfx.COLOR_TRANSPARENT);
    dc.drawCircle(92, 205, 3);
    dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_TRANSPARENT);
    dc.drawCircle(102, 205, 3);
    dc.setColor(Gfx.COLOR_PURPLE, Gfx.COLOR_TRANSPARENT);
    dc.drawCircle(122, 205, 3);
    dc.setColor(Gfx.COLOR_ORANGE, Gfx.COLOR_TRANSPARENT);
    dc.drawCircle(132, 205, 3);
    dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_TRANSPARENT);
    dc.drawCircle(142, 205, 3);

    // BATTERY
    var bat = System.getSystemStats().battery;
     var batF = Lang.format( "$1$%", [ bat.format( "%2d" ) ] );
     
    if (bat > 90 ){
      dc.setColor(Gfx.COLOR_GREEN, Gfx.COLOR_TRANSPARENT);
    }else if(bat > 75){
      dc.setColor(Gfx.COLOR_DK_GREEN, Gfx.COLOR_TRANSPARENT);
    }else if(bat > 50){
      dc.setColor(Gfx.COLOR_BLUE, Gfx.COLOR_TRANSPARENT);
    }else if(bat > 35){
      dc.setColor(Gfx.COLOR_PURPLE, Gfx.COLOR_TRANSPARENT);
    }else if(bat > 20){
      dc.setColor(Gfx.COLOR_ORANGE, Gfx.COLOR_TRANSPARENT);
    }else if(bat > 5){
      dc.setColor(Gfx.COLOR_RED, Gfx.COLOR_TRANSPARENT);
    }else if(bat > 0){
      dc.setColor(Gfx.COLOR_DK_RED, Gfx.COLOR_TRANSPARENT);
    }
    dc.drawText(45, 120, customLat_20, "Bat: ", Gfx.TEXT_JUSTIFY_CENTER);
    dc.drawText(40, 140, customLat_20, batF, Gfx.TEXT_JUSTIFY_CENTER);
  }

  function onHide() as Void {}

  function onExitSleep() { lowPowerMode = true; }

  function onEnterSleep() { lowPowerMode = false; }
}
