package ganalytics;

/** Google Analytics */
class GAnalytics 
{
	/**
	Various event IDs
	*/

	private static inline var AUTH_SUCCEEDED:Int=1;
	private static inline var AUTH_FAILED:Int=2;
	
	/** On Ready Callback */
	private static var _onAuthCallback:Dynamic;
	
	/** Initialization State */
	private static var initState:Bool = false;



	//
	// Public Methods
	//

	/**
	Set debug mode
	*/

	public static function debuggerMode(deb:Bool)
	{
		if(deb == false)
			ganalytics_debug_mode(0);
		else
			ganalytics_debug_mode(1);
	}


	/**
	 *  startTracker
	 */

	public static function startTracker(acountID:String,disPatchPeriod:Int = -1):Void{
		ganalytics_start_tracker(acountID,disPatchPeriod);
		initState = true;
	}

	/**
 	*  trackEvent
 	*/

	public static function trackEvent(category:String,action:String,label:String,value:Int):Void{
		assertInit();
		ganalytics_track_event(category,action,label,value);
	}

	/**
 	*  trackPage
 	*/	

	public static function trackPage(pageName:String):Void{
		assertInit();
		ganalytics_track_page(pageName);
	}

	/**
 	*  dispatchTracker
 	*/

	public static function dispatchTracker():Void{
		assertInit();
		ganalytics_dispatch_tracker();
	}
	
	/**
 	*  stopTracker
 	*/

	public static function stopTracker():Void{
		assertInit();
		ganalytics_stop_tracker();
		initState = false;
	}
	
	static var ganalytics_debug_mode = nme.Loader.load("ganalytics_debug_mode",1);
	static var ganalytics_start_tracker = nme.Loader.load("ganalytics_start_tracker",2);
	static var ganalytics_track_event = nme.Loader.load("ganalytics_track_event",4);
	static var ganalytics_track_page = nme.Loader.load("ganalytics_track_page",1);
	static var ganalytics_dispatch_tracker = nme.Loader.load("ganalytics_dispatch_tracker",0);
	static var ganalytics_stop_tracker = nme.Loader.load("ganalytics_stop_tracker",0);

	//
	// Implementation
	//

	/** Callback from CFFI */
	private static function ganalytics_event_callback(eventId:Int):Void
	{
		trace("GAnalytics :: received event: "+eventId);
		// TODO: dispatch other events, and callbacks success/failure

	}
	
	/** Ensure Initialization state */
	private static function assertInit():Void
	{
		if (initState==false)
		{
			throw "Initialize GAnalytics with GAnalytics.startTracker() first.";
		}
	}
}

