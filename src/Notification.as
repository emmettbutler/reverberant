package
{
    import org.flixel.*;

    public class Notification extends StaticTextBox {
        public var frame_lifetime:Number = 0;
        public var is_disappearing:Boolean = false;
        public var _origin:FlxPoint;

        public function Notification(txt:String) {
            this._origin = new FlxPoint(FlxG.width-50, 10);
            super(this._origin, FlxG.width, txt);
        }

        override public function update():void {
            this.frame_lifetime++;
            super.update();

            if (this.frame_lifetime == 40) {
                this.is_disappearing = true;
            }

            if (this.is_disappearing) {
                this.y += 1;
                this.alpha -= .05;
            }
        }

        public function set_note(txt:String, color:int):void {
            this.is_disappearing = false;
            this.x = this._origin.x;
            this.y = this._origin.y;
            this.alpha = 1;
            this.frame_lifetime = 0;
            this.text = txt;
            this.color = color;
        }
    }
}
