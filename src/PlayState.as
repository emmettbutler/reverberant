package
{
    import org.flixel.*;

    public class PlayState extends FlxState {
        public var textBox:TextInputBox;
        public var autoBox:AutoTypeTextBox;
        public var lines:LineGenerator;

        public var time_bar:TimeCounter;

        public var titleText:StaticTextBox;

        public var cur_timelimit:Number = 30 * 20;

        public var frame_lifetime:Number = 0;

        public var dbgText:FlxText;

        override public function create():void{
            FlxG.bgColor = 0xffbbbbbb;

            textBox = new TextInputBox(new FlxPoint(10, 40), 600);
            textBox.enterCallback = this.enterCallback;
            FlxG.keys = new Inputter(textBox.keyPressCallback);

            lines = new LineGenerator();

            autoBox = new AutoTypeTextBox(new FlxPoint(10, 30), 600, "TYPE '1' TO START YOUR DAY");
            autoBox.speed = 3;

            titleText = new StaticTextBox(new FlxPoint(10, 10), FlxG.width, "PANIC OPERATING SYSTEM v1.1.3");
            titleText.color = 0xff000000;
            add(titleText);

            time_bar = new TimeCounter(new FlxPoint(FlxG.width/2 - 100, FlxG.height - 50), 200);
            time_bar.set_time(cur_timelimit);

            dbgText = new FlxText(200, 200, FlxG.width, "");
            add(dbgText);
        }

        public function enterCallback(content:String):void {
            textBox.erase();
            //dbgText.text = "content: " + content + "\nprinted: " + autoBox.printed_string;
            if (content == autoBox.printed_string) {
                autoBox.typeString("   CORRECT");
            } else {
                autoBox.typeString("   WRONG");
            }
            this.advance();
        }

        override public function update():void{
            this.frame_lifetime++;
            super.update();
            textBox.update();
            autoBox.update();
            time_bar.update();

            if (time_bar.frames_remaining == 0) {
                this.advance();
            }
        }

        public function advance():void {
            autoBox.erase();
            autoBox.typeString(lines.get_next());
            time_bar.set_time(cur_timelimit - 20);
        }
    }
}
