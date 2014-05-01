package
{
    import org.flixel.*;

    public class PlayState extends FlxState {
        [Embed(source="../assets/office.mp3")] private var SndBG:Class;
        [Embed(source="../assets/negative.mp3")] private var SndWrong:Class;
        [Embed(source="../assets/positive.mp3")] private var SndRight:Class;

        public var textBox:TextInputBox;
        public var autoBox:AutoTypeTextBox;
        public var lines:LineGenerator;
        public var notification:Notification;
        public var time_bar:TimeCounter;

        public var titleText:StaticTextBox;
        public var scoreText:StaticTextBox;
        public var promptText:StaticTextBox;
        public var instText:StaticTextBox;

        public var bg:FlxSprite;

        public var cur_timelimit:Number = 30 * 14;
        public var correct_count:Number = 0;
        public var incorrect_count:Number = 0;

        public var timeout_time:Number = 0;
        public var last_advance_time:Number = 0;
        public var frame_lifetime:Number = 0;
        public var end_time:Number = 0;

        public var box_color:int = 0xffcccccc;
        public var shadow_color:int = 0xffaaaaaa;

        public var player_name:String;

        public var dbgText:FlxText;

        public function PlayState(player_name:String) {
            this.player_name = player_name;
        }

        override public function create():void{
            FlxG.playMusic(SndBG);
            FlxG.bgColor = 0xff0000ff;

            var shadow:FlxSprite = new FlxSprite(7, 7);
            shadow.makeGraphic(320-10, 240-10, 0xff000000);
            add(shadow);

            bg = new FlxSprite(5, 5);
            bg.makeGraphic(320-10, 240-10, 0xff999999);
            add(bg);

            lines = new LineGenerator();

            notification = new Notification(new FlxPoint(0, FlxG.height/2), "");
            add(notification);

            textBox = new TextInputBox(new FlxPoint(10, 70), 600, lines);
            textBox.enterCallback = this.enterCallback;
            textBox.enterPoemCallback = this.enterPoemCallback;
            textBox.erase();
            FlxG.keys = new Inputter(textBox.keyPressCallback);

            autoBox = new AutoTypeTextBox(new FlxPoint(10, 50), 600,
                                          "WELCOME. ENTER THIS LINE");
            autoBox.speed = 3;

            titleText = new StaticTextBox(new FlxPoint(10, 10), FlxG.width,
                                          "EVERYTHING IS FINE");
            titleText.color = 0xff000000;
            add(titleText);

            promptText = new StaticTextBox(new FlxPoint(10, 30), FlxG.width,
                                           "prompt:");
            promptText.color = box_color;
            add(promptText);

            instText = new StaticTextBox(new FlxPoint(10, FlxG.height-65), FlxG.width,
                                         "Type the prompt text before time runs out and press enter.\nCompany policy prohibits you from writing software bugs.");
            instText.color = 0xff444444;
            add(instText);

            var score_shadow:FlxSprite = new FlxSprite(FlxG.width-100+2, 10+2);
            score_shadow.makeGraphic(42, 17, shadow_color);
            add(score_shadow);

            var score_bg:FlxSprite = new FlxSprite(FlxG.width-100, 10);
            score_bg.makeGraphic(42, 17, box_color);
            add(score_bg);

            scoreText = new StaticTextBox(new FlxPoint(FlxG.width-100, 10),
                                          FlxG.width, "0/0");
            scoreText.color = 0xff000000;
            add(scoreText);

            var bar_shadow:FlxSprite = new FlxSprite((FlxG.width/2-105)+2, (FlxG.height-88)+2);
            bar_shadow.makeGraphic(210, 21, shadow_color);
            add(bar_shadow);

            var bar_bg:FlxSprite = new FlxSprite(FlxG.width/2 - 105, FlxG.height - 88);
            bar_bg.makeGraphic(210, 21, box_color);
            add(bar_bg);

            time_bar = new TimeCounter(new FlxPoint(FlxG.width/2 - 100,
                                       FlxG.height - 85), 200);
            time_bar.set_time(cur_timelimit);
            time_bar.running = false;

            dbgText = new FlxText(100, 80, FlxG.width, "");
            add(dbgText);
        }

        public function updateTitleText():void {
            if (this.lines.poem_counter > 40) {
                titleText.text = "  E     NG        ";
                instText.text = "T pe t   pr   t  ext b f  e t me r  s o t a   pr     n er.\n o p ny   l cy pr h bit  y u    m         so    re b gs.";
            } else if (this.lines.poem_counter > 30) {
                titleText.text = "E ER    NG I  F   ";
                instText.text = "T pe t   pr   t  ext b fore t me r  s o t and pr     n er.\nComp ny   l cy pr hibit  you f om   i   g so    re b gs.";
            } else if (this.lines.poem_counter > 20) {
                titleText.text = "E ER  H NG IS FI E";
                instText.text = "T pe t   pr   t  ext b fore t me runs o t and press  n er.\nComp ny   l cy pr hibit  you from wri   g so    re b gs.";
            } else if (this.lines.poem_counter > 10) {
                titleText.text = "EVER  HING IS FI E";
                instText.text = "Type the prompt  ext b fore t me runs o t and press  n er.\nComp ny   l cy pr hibit  you from writing software b gs.";
            }
        }

        public function enterCallback(content:String):void {
            if (this.end_time != 0) return;
            if (this.autoBox.running) return;
            textBox.erase();
            if (content == autoBox.printed_string) {
                notification.set_note("TESTS PASS", 0xff00ff00);
                time_bar.set_color(0xff00ff00);
                FlxG.play(SndRight, .3);
                correct_count++;
            } else {
                notification.set_note("BUG DETECTED", 0xffff0000);
                time_bar.set_color(0xffff0000);
                FlxG.play(SndWrong, .7);
                incorrect_count++;
            }
            this.scoreText.text = correct_count + "/" + incorrect_count;
            this.advance();
            this.last_advance_time = this.frame_lifetime;
        }

        public function enterPoemCallback(content:String):void {
            if (this.timeout_time == 0) {
                this.timeout_time = this.frame_lifetime;
            }
            this.textBox.complete();
            this.lines.poem_counter++;
        }

        public function print_debug():void {
            dbgText.text = "running: " + autoBox.running + "\ncharCounter: " + autoBox.charCounter + "\ntoType: " + autoBox.toType + "\nframes: " + autoBox.frame_lifetime + "\norigin: " + autoBox.origin.x + "," + autoBox.origin.y + "\nprinted: " + autoBox.printed_string + "\ntimeout_time: " + this.timeout_time + "\nuse_poem_line: " + this.textBox.use_poem_line + "\ncurrent_poem_line: " + this.textBox.current_poem_line + "\npoem counter: " + this.lines.poem_counter;
        }

        override public function update():void{
            this.frame_lifetime++;
            //this.print_debug();

            super.update();
            this.updateTitleText();
            textBox.update();
            autoBox.update();
            time_bar.update();

            if (time_bar.frames_remaining == 0 && this.timeout_time == 0) {
                this.timeout_time = this.frame_lifetime;
            }

            if (this.timeout_time != 0 && this.frame_lifetime - this.timeout_time > 90) {
                this.enterCallback(this.textBox.printed_string);
            }

            if (this.last_advance_time != 0 && this.frame_lifetime - this.last_advance_time > 40) {
                this.time_bar.set_color(0xffffffff);
            }

            if (this.end_time != 0 && this.frame_lifetime - this.end_time > 260) {
                FlxG.switchState(new EndState(incorrect_count, player_name));
            }
        }

        public function advance():void {
            autoBox.erase();
            cur_timelimit -= 2;
            time_bar.set_time(cur_timelimit);
            if (this.lines.poem_counter == this.lines.poem_lines.length) {
                time_bar.running = false;
                end_time = this.frame_lifetime;
                return;
            }
            time_bar.running = true;
            this.timeout_time = 0;
            autoBox.typeString(lines.get_next().toUpperCase());

            if (this.lines != null){
                if (this.lines.poem_counter > 42) {
                    this.textBox.use_poem_line = Math.floor(Math.random() * 5) == 1;
                } else if (this.lines.poem_counter > 35) {
                    this.textBox.use_poem_line = true;
                } else if (this.lines.poem_counter > 25) {
                    this.textBox.use_poem_line = Math.floor(Math.random() * 3) == 1;
                } else if (this.lines.poem_counter > 10) {
                    this.textBox.use_poem_line = Math.floor(Math.random() * 5) == 1;
                } else {
                    this.textBox.use_poem_line = false;
                }
            } else {
                this.textBox.use_poem_line = false;
            }
            if (this.textBox.use_poem_line) {
                var line:String = this.lines.get_next_poem_line();
                if (line != null) {
                    this.textBox.current_poem_line = line.toUpperCase();
                }
            } else {
                this.textBox.current_poem_line = "";
            }
        }
    }
}
