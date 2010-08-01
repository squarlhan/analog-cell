package {
	import flash.display.*;
	import flash.events.Event;
    
	public class Bubble extends Sprite
	{
		private var ball:Ball ;
		private var otherball:Ball ;
		private var distance:Number ;
		private var line:Sprite ;
		private var frame:Sprite ;
		private var frameSize:int = 350 ;
		//判断是否已经画线
		private var flag:Boolean = true ;
		//小球半径
		private var radius:Number = 10 ;
		//一串小球
		private var balls:Array ;
		private var numBalls:Number = 10 ;
		
		public function Bubble()
		{
			setFrame() ;
			init() ;
			init1() ;
		}
		
		//设置一下边框
		private function setFrame():void
		{
			frame = new Sprite () ;
			addChild(frame) ;
			frame.graphics.beginFill(0x000035) ;
			frame.graphics.lineStyle(null,0x00ff00,1) ;
			frame.graphics.moveTo(0,0) ;
			frame.graphics.lineTo(0,frameSize) ;
			frame.graphics.lineTo(frameSize,frameSize) ;
			frame.graphics.lineTo(frameSize,0) ;
			frame.graphics.lineTo(0,0) ;
			frame.graphics.endFill() ;
			
		}
		//两个小球的相撞运动
		private function init ():void
		{
			ball = new Ball(radius,0xff00ff) ;
			addChild(ball) ;
			ball.x = 100 ;
			ball.y = 100 ;//stage.stageHeight ;
			
			otherball = new Ball(radius,0x00ff00) ;
			addChild(otherball) ;
			otherball.x = 170 ;
			otherball.y = 170 ;
			
			addEventListener(Event.ENTER_FRAME,onEnterFrame) ;
		}
		
		private function onEnterFrame(event:Event):void
		{
			if(flag)
			{
			ball.x += Math.random()* 3 ;
			ball.y += Math.random()* 3 ;
			otherball.x -= Math.random()* 3 ;
			otherball.y -= Math.random()* 3 ;
			var x1:Number = ball.x - otherball.x ;
			var x2:Number = ball.y - otherball.y ;
			distance = Math.sqrt ( x1*x1 + x2*x2 ) ;
			}
			else
			{
				x1 = ball.x - otherball.x ;
		    	x2 = ball.y - otherball.y ;
		    	distance = Math.sqrt ( x1*x1 + x2*x2 ) ;
				if (distance >= 3*radius)
				{
					removeChild(line) ;
					flag = true ;
					line = null;
					
					ball.x += Math.random()* 3 ;
		        	ball.y += Math.random()* 3 ;
		        	otherball.x -= Math.random()* 3 ;
		        	otherball.y -= Math.random()* 3 ;
				}
	         	if(distance>=2*radius && distance<3*radius)
	         	{
	         		ball.x += Math.random()* 3 ;
	        		ball.y += Math.random()* 3 ;
		        	otherball.x -= Math.random()* 3 ;
		        	otherball.y -= Math.random()* 3 ;
		        	var x1:Number = ball.x - otherball.x ;
		        	var x2:Number = ball.y - otherball.y ;
		        	distance = Math.sqrt ( x1*x1 + x2*x2 ) ;
	         	}
	         	
	     		if (distance < 2*radius)
		    	{
	     	    	ball.x += Math.random()* 3 ;
	     	     	ball.y += Math.random()* 3 ;
	     	    	otherball.x += Math.random()* 3 ;
	         		otherball.y += Math.random()* 3 ;
		    	}
			}
			
			if (ball.x - radius>frameSize || ball.y -radius >frameSize||
			    ball.x+radius<0||ball.y+radius<0)
			    {
			    	ball.x = Math.random()*frameSize ;
			    	ball.y = Math.random()*frameSize ;
			    }
			if (otherball.x - radius>frameSize || otherball.y -radius >frameSize||
			    otherball.x+radius<0||otherball.y+radius<0)
			    {
			    	otherball.x = Math.random()*frameSize ;
			    	otherball.y = Math.random()*frameSize ;
			    }
			if (line != null)
			{
				removeChild(line) ;
				line = new Sprite() ;
		        addChild(line) ;
		        line.graphics.lineStyle(1,0) ;
		        line.graphics.moveTo(ball.x,ball.y) ;
		        line.graphics.lineTo(otherball.x,otherball.y) ;
			}
		    if (distance < 2*radius && flag)
		    {
		        	line = new Sprite() ;
		         	addChild(line) ;
		        	line.graphics.lineStyle(1,0xffffff) ;
		        	line.graphics.moveTo(ball.x,ball.y) ;
		        	line.graphics.lineTo(otherball.x,otherball.y) ;
		        	flag = false ;
		        
		    }
		}
		
		//一串小球
		private var tempR:Number = 0 ;
		private var lines:Array ;
//		private var line1:Sprite = new Sprite() ;
		private function init1():void
		{
			balls = new Array() ;
			for (var i:uint=0;i<numBalls;i++)
			{
				var aball:Ball = new Ball(10) ;
				var temp:Number = tempR*Math.PI/180 ;
				aball.x = frameSize/2 + (frameSize/4)*Math.cos(temp) ;
				aball.y = frameSize/2 + (frameSize/4)*Math.sin(temp) ;
				addChild(aball) ;
				balls.push(aball) ;
				//逐次增大
				tempR += 36 ;
			}
			
			lines = new Array() ;
			for ( i=1;i<=numBalls;i++)
			{
				var aline:Sprite = new Sprite() ;
				addChild(aline) ;
				
				var ballA:Ball = balls[i-1] ;
				if(i==numBalls) var ballB:Ball = balls[0] ;
				else var ballB:Ball = balls[i] ;
				aline.graphics.lineStyle(1,0xffffff);
				aline.graphics.moveTo(ballA.x,ballA.y) ;
				aline.graphics.lineTo(ballB.x,ballB.y) ;
				
				lines.push(aline) ;
			} 
			
			addEventListener(Event.ENTER_FRAME,onEnterFrame1) ;
		}
		private function onEnterFrame1 (event:Event):void
		{
			var m:Number ;
			var n:Number ;
			for (var i:uint=0;i<numBalls;i++)
			{
				balls[i].x += m = Math.random() ;
				balls[i].y += n = Math.random() ;
			} 
			for (i=0;i<numBalls;i++)
			{
				balls[i].x -= m ;
				balls[i].y -= n;
			} 
		}
	}
}
