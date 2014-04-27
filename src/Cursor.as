package
{
    import org.flixel.*;

    public class Cursor extends FlxSprite {
        public var frame_lifetime:Number = 0;

        public function Cursor(x:int, y:int) {
            makeGraphic(10, 15, 0xffffffff);
        }

        override public function update():void {
            frame_lifetime += 1;
            if (frame_lifetime % 30 == 0) {
                if (alpha == 1) {
                    alpha = 0;
                } else {
                    alpha = 1;
                }
            }
        }
    }
}
