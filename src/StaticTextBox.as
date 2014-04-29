package
{
    import org.flixel.*;

    public class StaticTextBox extends FlxText {
        [Embed(source="../assets/Perfect DOS VGA 437.ttf", fontFamily="Perfect DOS VGA 437", embedAsCFF="false")] public var FontDOS:Class;

        public function StaticTextBox(origin:FlxPoint, width:Number, txt:String) {
            super(origin.x, origin.y, width, txt);
            this.setFormat("Perfect DOS VGA 437",14,0xffffffff,"left");
        }
    }
}
