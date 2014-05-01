package
{
    import org.flixel.*;

    public class MenuState extends FlxState{
        [Embed(source="../assets/bg_title.png")] private var ImgBG:Class;
        public var textBox:TextInputBox;

        public var titleText:StaticTextBox;

        override public function create():void
        {
            var bg:FlxSprite = new FlxSprite(0, 0);
            bg.loadGraphic(ImgBG, true, true, 320, 240, true);
            add(bg);

            titleText = new StaticTextBox(new FlxPoint(0, FlxG.height/2), FlxG.width,
                                          "PLEASE ENTER YOUR USERNAME");
            titleText.color = 0xffffffff;
            titleText.alignment = "center";
            add(titleText);

            textBox = new TextInputBox(new FlxPoint(FlxG.width/2-88, FlxG.height/2+33), 200, null);
            textBox.enterCallback = this.enterCallback;
            textBox.erase();
            textBox.allows_linebreaks = false;

            FlxG.keys = new Inputter(textBox.keyPressCallback);

            FlxG.mouse.hide();
        }

        public function enterCallback(content:String):void {

        }

        override public function update():void
        {
            super.update();
            textBox.update();

            if(FlxG.keys.justPressed("ENTER"))
            {
                if (textBox.printed_string == "") {

                } else {
                    FlxG.switchState(new PlayState());
                }
            }
        }
    }
}
