package
{
    import org.flixel.*;

    public class PlayState extends FlxState {
        public var textBox:TextInputBox;

        override public function create():void{
            textBox = new TextInputBox(new FlxPoint(10, 10), 600);
            FlxG.keys = new Inputter(textBox._callback);
        }

        override public function update():void{
            super.update();
            textBox.update();
        }
    }
}
