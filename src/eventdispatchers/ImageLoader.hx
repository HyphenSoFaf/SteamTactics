package eventdispatchers;

import nme.display.Loader;
import nme.events.EventDispatcher;
import nme.display.Bitmap;
import nme.display.LoaderInfo;
import nme.events.Event;
import nme.events.EventDispatcher;
import nme.events.IEventDispatcher;
import nme.events.IOErrorEvent;
import nme.events.SecurityErrorEvent;
import nme.events.ProgressEvent;

import nme.net.URLLoader;
import nme.net.URLRequest;
import nme.net.URLRequestHeader;


/**
 * ...
 * @author loki
 */
class ImageLoader extends EventDispatcher
{
	private var loader:Loader;
	private var images:Hash<Bitmap>;
	private var items:Array<Hash<String>>;
	private var currentItem:Int;
	private var totalItems:Int;
	private var percentLoaded:Int;

	public function new(target:IEventDispatcher=null)
		{
			super(target);
			loader = new Loader();
			items = new Array<Hash<String>>();
			images = new Hash<Bitamp><();
		}

		public function addURL(id:String, url:String):Void
		{
			var object:Hash<String> = new Hash<String>();
			object.set("id", id);
			object.set("url", url);
			items.push(object);
			totalItems = items.length;
		}

		public function Load():Void
		{
			var request:URLRequest;
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loadProgress);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);
			loader.contentLoaderInfo.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityError);

			//--Load xml request
			request = new URLRequest(items[currentItem].url);
			//var header:URLRequestHeader = new URLRequestHeader("pragma", "no-cache");
			//request.requestHeaders.push(header);
			loader.load(request);
		}

		private function loadComplete(e:Event):Void
		{
			images.set([items[currentItem].id],Bitmap(LoaderInfo(e.target).content));
			currentItem ++;
			if (currentItem == totalItems)
			{
				dispatchEvent(new ImageEvent(ImageEvent.IMAGELOADED, images));
				complete();
			}
			else
			{
				this.Load();
			}
		}

		private function loadProgress(e:ProgressEvent):Void
		{
			var temp:int = Math.ceil((((e.target.bytesLoaded / e.target.bytesTotal)*100 * (currentItem + 1)) / totalItems));
			if (temp > percentLoaded) {
				percentLoaded = temp;		// avoid the precentage to drop
			}
			dispatchEvent(new ImageEvent(ImageEvent.IMAGEPROGRESS, images));
		}

		private function ioError(e:IOErrorEvent):Void
		{
			trace( "ImageLoader failed because of IO error: " + e.text);

			complete();
		}

		private function securityError(e:SecurityErrorEvent):Void
		{
			trace( "ImageLoader failed because of security error: " + e.text);

			complete();
		}

		private function complete():Void
		{
			//--Remove listeners
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, loadComplete);
			loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, loadProgress);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
			loader.contentLoaderInfo.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityError);

			//--Destroy
			destroy();
		}

		public function get PercentLoaded():Int { return percentLoaded;}

		private function destroy():Void {
			loader = null;
		}
	
}