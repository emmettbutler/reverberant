package
{
    import org.flixel.*;

    public class MenuState extends FlxState{
        public var notification:Notification;
        public var textBox:TextInputBox;

        public var titleText:StaticTextBox;

        override public function create():void
        {
            FlxG.bgColor = 0xff0000ff;

            var _frame:FlxSprite = new FlxSprite(5, 5);
            _frame.makeGraphic(320-10, 240-10, 0xff999999);
            add(_frame);

            var bg:FlxSprite = new FlxSprite(7, 7);
            bg.makeGraphic(320-14, 240-14, 0xff0000ff);
            add(bg);

            notification = new Notification(new FlxPoint(0, FlxG.height-40), "");
            add(notification);

            titleText = new StaticTextBox(new FlxPoint(0, FlxG.height/2), FlxG.width,
                                          "PLEASE ENTER YOUR USERNAME");
            titleText.color = 0xffffffff;
            titleText.alignment = "center";
            add(titleText);

            var textFrame:FlxSprite = new FlxSprite(FlxG.width/2-98, FlxG.height/2+30);
            textFrame.makeGraphic(200, 23, 0xff999999);
            add(textFrame);

            var textInner:FlxSprite = new FlxSprite((FlxG.width/2-98)+3, (FlxG.height/2+30)+3);
            textInner.makeGraphic(200-6, 23-6, 0xff0000ff);
            add(textInner);

            textBox = new TextInputBox(new FlxPoint(FlxG.width/2-88, FlxG.height/2+33), 260, null);
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
                    notification.set_note("TYPE SOMETHING AND ENTER", 0xffffffff);
                } else {
                    FlxG.switchState(new PlayState(textBox.printed_string));
                }
            }
        }
    }
}
