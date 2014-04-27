package
{
    import org.flixel.*;

    public class MenuState extends FlxState{
        public var t1:FlxText;

        override public function create():void
        {
            t1 = new FlxText(FlxG.width/2-50,FlxG.height-20,100,"ENTER to start");
            t1.alignment = "center";
            add(t1);

            FlxG.mouse.hide();
        }

        override public function update():void
        {
            super.update();

            if(FlxG.keys.justPressed("ENTER"))
            {
                FlxG.mouse.hide();
                FlxG.switchState(new PlayState());
            }
        }
    }
}
