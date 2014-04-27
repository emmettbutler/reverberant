package
{
    import org.flixel.*;

    public class PlayState extends FlxState {
        public var textBox:TextInputBox;
        public var autoBox:AutoTypeTextBox;

        override public function create():void{
            textBox = new TextInputBox(new FlxPoint(10, 10), 600);
            FlxG.keys = new Inputter(textBox._callback);

            autoBox = new AutoTypeTextBox(new FlxPoint(10, 30), 600, "THIS IS A TEST");
        }

        override public function update():void{
            super.update();
            textBox.update();
            autoBox.update();
        }
    }
}
