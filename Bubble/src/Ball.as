package
{
	import flash.display.Sprite;
	public class Ball extends Sprite
	{
		private var radians:Number ;
		private var color:uint ;
		public function Ball(radius:Number = 40,color:uint = 0xff0000)
		{
			this.radians = radius ;
			this.color = color ;
			init() ;
		}
		private function init():void
		{
			graphics.beginFill(color) ;
			graphics.drawCircle(0,0,this.radians) ;
			graphics.endFill() ;
		}
         
	}
}