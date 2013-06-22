package utils;

import nme.display.Sprite;
import nme.display.Shape;
import nme.events.MouseEvent;
import nme.events.Event;
import nme.geom.Rectangle;
import com.eclecticdesignstudio.motion.Actuate;
/**
 * ...
 * @author loki
 */
class Scrollbar extends Sprite
{
	private var track:Sprite;
	private var container:Sprite;
	private var masks:Shape;
	private var handler:Sprite;

	private var offset:Float;
	private var dragging:Bool;
	private var isHorizontal:Bool;
	private var trackWidth:Float;
	private var trackHeight:Float;
	private var masksLength:Float;
	private var maxScroll:Float;
	private var _x:Float;
	private var _y:Float;
	private var handlerWidth:Float;
	private var handlerHeight:Float;

	private var bounds:Rectangle;

	private var trackFillerColor:UInt = 0xD8D8D8;
	private var trackBorderColer:UInt = 0x939393;
	private var handlerFillerColor:UInt = 0x000000;
	private var DEFAULT_SIZE:Int = 15;
	private var MIN_HANDLE_SIZE:Int = 25;

	private var game:Game;

	public function new(game:Game, container:Sprite, mask:Shape, horizontal:Bool = true) 
	{
		super();
		this.game = game;
		this.container = container;
		this.masks = mask;
		this.isHorizontal = horizontal;

		if (horizontal) { horizontalSetup(); } else { verticalSetup(); }

		track = new Sprite();
		track.x = _x;
		track.y = _y;
		handler = new Sprite();
		drawTrack();
	}

	private function drawTrack():Void 
	{
		track.graphics.clear();
		track.graphics.lineStyle(1, trackBorderColer);
		track.graphics.beginFill(trackFillerColor);
		track.graphics.drawRect(0, 0, trackWidth, trackHeight);
		track.graphics.endFill();
		track.addEventListener(MouseEvent.CLICK, slideJump);
		addChild(track);

		handlerWidth = (masks.width * trackWidth)/container.width;
		handlerWidth = handlerWidth < MIN_HANDLE_SIZE ? MIN_HANDLE_SIZE : handlerWidth;
		handlerWidth = handlerWidth > trackWidth ? trackWidth : handlerWidth;

		handlerHeight = (masks.height * trackHeight)/container.height;
		handlerHeight = handlerHeight < MIN_HANDLE_SIZE ? MIN_HANDLE_SIZE : handlerHeight;
		handlerHeight = handlerHeight > trackHeight ? trackHeight : handlerHeight;

		handler.graphics.clear();
		handler.graphics.beginFill(handlerFillerColor);
		if (isHorizontal) { handler.graphics.drawRoundRect(1, 1, handlerWidth, track.height -2, 15); } else { handler.graphics.drawRoundRect(0, 0, track.width, handlerHeight, 15); }
		handler.graphics.endFill();

		handler.graphics.beginFill(0xFFFFFF, .2);
		if (isHorizontal) { handler.graphics.drawRoundRect(3.2, 0.7, handler.width - 5, handler.height * .45, 9); } else { handler.graphics.drawRoundRect((handler.width/2) +1, 2.3, handler.width *.45, handler.height - 5, 15); }
		handler.graphics.endFill();

		track.addChild(handler);
		if (isHorizontal) { maxScroll = track.width - handler.width; bounds = new Rectangle(handler.x, handler.y, maxScroll - 1, 0); } else { maxScroll = track.height - handler.height; bounds = new Rectangle(handler.x, handler.y, 0, maxScroll);}
		handler.addEventListener(MouseEvent.MOUSE_DOWN, beginSlide);
	}

	private function beginSlide(e:MouseEvent):Void 
	{
		handler.startDrag(false, bounds);
		dragging = true;
		game.stage.addEventListener(MouseEvent.MOUSE_UP, endSlide);
		game.stage.addEventListener(Event.MOUSE_LEAVE, endSlide);
	}

	public function Update(deltaTime:Int):Void
	{
		if (dragging)
		{
			if (isHorizontal)
			{
				Actuate.tween(container, .5, { x:offset - (handler.x / maxScroll) * (container.width - masksLength) } );
			}
			else
			{
				Actuate.tween(container, .5, { y:offset - (handler.y / maxScroll) * (container.height - masksLength) } );
			}
		}
	}


	private function endSlide(e:Event):Void 
	{
		handler.stopDrag();
		dragging = false;
	}

	private function slideJump(e:MouseEvent):Void 
	{
		if (e.target == e.currentTarget)
		{
			if (isHorizontal)
			{
				if ((e.currentTarget.mouseX - _x) > maxScroll)
				{
					handler.x = maxScroll;
				}else
				{
					handler.x = e.currentTarget.mouseX - _x;
				}
				Actuate.tween(container, .5, {x:offset - (handler.x/maxScroll) * (container.width - masksLength) } );
			}
			else
			{
				if ((e.currentTarget.mouseY - _y) > maxScroll)
				{
					handler.y = maxScroll;
				}else
				{
					handler.y = e.currentTarget.mouseY - _y;
				}
				Actuate.tween(container, .5, {y:offset - (handler.y/maxScroll) * (container.height - masksLength) } );
			}
		}
	}

	private function verticalSetup():Void 
	{
		this._y = masks.y;
		this._x = container.x + masks.width + DEFAULT_SIZE;

		trackWidth = DEFAULT_SIZE;
		trackHeight = masks.height;

		masksLength = masks.height - 3;

		offset = container.y;
	}

	private function horizontalSetup():Void 
	{
		this._x = masks.x;
		this._y = container.y + masks.height + DEFAULT_SIZE;

		trackWidth = masks.width;
		trackHeight = DEFAULT_SIZE;

		masksLength = masks.width - 3;

		offset = container.x;
	}
}