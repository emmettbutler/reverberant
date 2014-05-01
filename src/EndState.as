package
{
    import org.flixel.*;

    public class EndState extends FlxState{
        public var bugs:Number;
        public var player_name:String;

        public var titleText:StaticTextBox;

        public function EndState(bugs:Number, player_name:String) {
            this.bugs = bugs;
            this.player_name = player_name;
        }

        override public function create():void
        {
            FlxG.bgColor = 0xff0000ff;

            var _frame:FlxSprite = new FlxSprite(5, 5);
            _frame.makeGraphic(320-10, 240-10, 0xff999999);
            add(_frame);

            var bg:FlxSprite = new FlxSprite(7, 7);
            bg.makeGraphic(320-14, 240-14, 0xff0000ff);
            add(bg);

            var comments:Array = new Array(
                "A PRODUCTIVE DAY",
                "TRY HARDER",
                "YOUR PINK SLIP IS COMING",
                "YOU ARE ALONE",
                "THE THINGS YOU FEAR ARE REAL",
                "UNACCEPTABLE",
                "YOU NEED TO WORK ON YOUR FOCUS"
            );
            var commentString:String = comments[Math.floor(Math.random() * comments.length)];

            titleText = new StaticTextBox(new FlxPoint(0, FlxG.height/2), FlxG.width,
                                          player_name + "\nYOU WROTE " + this.bugs + " BUGS TODAY\n" + commentString + "\n\nENTER TO TYPE MORE");
            titleText.color = 0xffffffff;
            titleText.alignment = "center";
            add(titleText);

            FlxG.mouse.hide();
        }

        public function enterCallback(content:String):void {

        }

        override public function update():void
        {
            super.update();

            if(FlxG.keys.justPressed("ENTER"))
            {
                FlxG.switchState(new PlayState(player_name));
            }
        }
    }
}
