
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

class WF2View extends WatchUi.WatchFace {
  var lowPowerMode = true;
  var customQSand = null;
  var customQSand28 = null;
  var customQSand_100 = null;
  var batteryIcon = null;
  var batteryIcon83 = null;
  var batteryIcon66 = null;
  var batteryIcon50 = null;
  var batteryIcon32 = null;
  var batteryIcon15 = null;
  var bt = null;
  var btn = null;
  var tapeta = null;

  function initialize() { WatchFace.initialize(); }

  // Load your resources here
  function onLayout(dc) {
    customQSand = WatchUi.loadResource(Rez.Fonts.QSand);
    customQSand28 = WatchUi.loadResource(Rez.Fonts.QSand28);
    customQSand_100 = WatchUi.loadResource(Rez.Fonts.QSand_100);
    batteryIcon = WatchUi.loadResource(Rez.Drawables.Battery);
    batteryIcon15 = WatchUi.loadResource(Rez.Drawables.Battery15);
    batteryIcon32 = WatchUi.loadResource(Rez.Drawables.Battery32);
    batteryIcon50 = WatchUi.loadResource(Rez.Drawables.Battery50);
    batteryIcon66 = WatchUi.loadResource(Rez.Drawables.Battery66);
    batteryIcon83 = WatchUi.loadResource(Rez.Drawables.Battery83);
    bt = WatchUi.loadResource(Rez.Drawables.BT);
    btn = WatchUi.loadResource(Rez.Drawables.BTn);
    tapeta = WatchUi.loadResource(Rez.Drawables.Tapeta);
  }

  // Update the view
  function onUpdate(dc) {
    View.onUpdate(dc);
    dc.drawBitmap(-23, -28, tapeta);
    // FLOORS
    dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
    var floor = AM.getInfo().floorsClimbed;
    dc.drawText(168, 133, customQSand28, "" + floor, Gfx.TEXT_JUSTIFY_CENTER);

    // DATE
    dc.setColor(Gfx.COLOR_LT_GRAY, Gfx.COLOR_TRANSPARENT);
    var dateInfo4 = Calendar.info(Time.now(), Time.FORMAT_MEDIUM);
    var dateInfo = Calendar.info(Time.now(), Time.FORMAT_SHORT);
    var dateformat = dateInfo4.day.format("%02d") + "." +
                     dateInfo.month.format("%02d") + "." + dateInfo4.year;
    dc.drawText(110, 150, customQSand, dateformat, Gfx.TEXT_JUSTIFY_CENTER);

    // CLOCK
    var time = System.getClockTime();
    var timeformat = time.hour.format("%02d") + ":" + time.min.format("%02d");
    dc.drawText(110, 30, customQSand_100, timeformat, Gfx.TEXT_JUSTIFY_CENTER);

    // STEPS
    var step = AM.getInfo().steps;
    dc.drawText(90, 130, customQSand28, "" + step, Gfx.TEXT_JUSTIFY_CENTER);

    // BATTERY
    var batt = System.getSystemStats().battery;
    if (batt > 95) {
      dc.drawBitmap(89, 195, batteryIcon);
    } else if (batt > 83) {
      dc.drawBitmap(89, 195, batteryIcon83);
    } else if (batt > 66) {
      dc.drawBitmap(89, 195, batteryIcon66);
    } else if (batt > 50) {
      dc.drawBitmap(89, 195, batteryIcon50);
    } else if (batt > 32) {
      dc.drawBitmap(89, 195, batteryIcon32);
    } else if (batt > 15) {
      dc.drawBitmap(89, 195, batteryIcon15);
    }

    // BT
    var mySystem = System.getDeviceSettings();
    if (mySystem.phoneConnected) {
      dc.drawBitmap(98, 0, bt);
    } else {
      dc.drawBitmap(98, 0, btn);
    }
    
  }

  // Called when this View is removed from the screen. Save the
  // state of this View here. This includes freeing resources from
  // memory.
  function onHide() as Void {}

  function onExitSleep() { lowPowerMode = true; }

  function onEnterSleep() { lowPowerMode = false; }
}
