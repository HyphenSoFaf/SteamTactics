package eventdispatchers;

import events.APIEvents;
import haxe.Json;
import nme.events.Event;
import nme.events.IOErrorEvent;
import nme.net.URLLoader;
import nme.net.URLRequest;
import nme.net.URLLoaderDataFormat;
import nme.net.URLRequestMethod;
import nme.net.URLVariables;
import nme.events.EventDispatcher;
/**
 * ...
 * @author loki
 */
class APIHandler extends EventDispatcher
{
	private var baseURL:String = "http://leftbrainrightbra.in/steamtactics_api/";
	//private var baseURL:String = "http://leftbrainrightbra.in/api/steamtactics/v1/";
	
	public function new() 
	{
		super();
	}
	
	public function POST(method:String, params:Dynamic):Void
	{
		var data:String = Json.stringify(params);
		
		var variables:URLVariables = new URLVariables();
		variables.data = data;
		
		var request:URLRequest = new URLRequest(baseURL + method);
		request.method = URLRequestMethod.POST;
		request.data = variables;
		
		var urlLoader:URLLoader = new URLLoader();
		urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
		urlLoader.addEventListener(Event.COMPLETE, onComplete);
		urlLoader.addEventListener(IOErrorEvent.IO_ERROR, urlLoaderTestIoError);
		urlLoader.load(request);
	}
	
	public function GET(method:String, params:Dynamic):Void
	{
		var data:String = Json.stringify(params);
		
		var variables:URLVariables = new URLVariables();
		variables.data = data;
		
		var request:URLRequest = new URLRequest(baseURL + method);
		request.method = URLRequestMethod.GET;
		request.data = variables;
		
		var urlLoader:URLLoader = new URLLoader();
		urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
		urlLoader.addEventListener(Event.COMPLETE, onComplete);
		urlLoader.addEventListener(IOErrorEvent.IO_ERROR, urlLoaderTestIoError);
		urlLoader.load(request);
	}
	
	public function PUT(method:String,  params:Dynamic):Void
	{
		var data:String = Json.stringify(params);
		
		var variables:URLVariables = new URLVariables();
		variables.data = data;
		
		var request:URLRequest = new URLRequest(baseURL + method);
		request.method = URLRequestMethod.PUT;
		request.data = variables;
		
		var urlLoader:URLLoader = new URLLoader();
		urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
		urlLoader.addEventListener(Event.COMPLETE, onComplete);
		urlLoader.addEventListener(IOErrorEvent.IO_ERROR, urlLoaderTestIoError);
		urlLoader.load(request);
	}
	
	public function DELETE(method:String, params:Dynamic):Void
	{
		var data:String = Json.stringify(params);
		
		var variables:URLVariables = new URLVariables();
		variables.data = data;
		
		var request:URLRequest = new URLRequest(baseURL + method);
		request.method = URLRequestMethod.DELETE;
		request.data = variables;
		
		var urlLoader:URLLoader = new URLLoader();
		urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
		urlLoader.addEventListener(Event.COMPLETE, onComplete);
		urlLoader.addEventListener(IOErrorEvent.IO_ERROR, urlLoaderTestIoError);
		urlLoader.load(request);
	}
	
	private function onComplete(e:Event):Void
	{
		var urlLoader:URLLoader = cast(e.target, URLLoader);
		var resultData:Dynamic = Json.parse(cast(urlLoader.data, String));
		this.dispatchEvent(new APIEvents(APIEvents.RESPONSE, resultData));
	}
	
	private function urlLoaderTestIoError(event:IOErrorEvent):Void {
			trace("urlLoaderTestIoError: " + event);
		}
	
}