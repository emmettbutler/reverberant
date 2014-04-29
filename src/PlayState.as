package
{
    import org.flixel.*;

    public class PlayState extends FlxState {
        public var textBox:TextInputBox;
        public var autoBox:AutoTypeTextBox;

        public var titleText:StaticTextBox;

        override public function create():void{
            FlxG.bgColor = 0xffbbbbbb;

            textBox = new TextInputBox(new FlxPoint(10, 40), 600);
            FlxG.keys = new Inputter(textBox._callback);

            autoBox = new AutoTypeTextBox(new FlxPoint(10, 30), 600, "THIS IS A TEST");

            titleText = new StaticTextBox(new FlxPoint(10, 10), FlxG.width, "PANIC OPERATING SYSTEM v1.1.3");
            titleText.color = 0xff000000;
            add(titleText);
        }

        override public function update():void{
            super.update();
            textBox.update();
            autoBox.update();
        }
    }
}
