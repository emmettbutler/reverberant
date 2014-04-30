package {
    import org.flixel.*;

    public class LineGenerator {
        public var normal_lines:Array;
        public var poem_lines:Array;

        public var poem_counter:Number;
        public var inv_poem_prob:Number = 10;

        public function LineGenerator() {
            this.normal_lines = new Array("NORMAL LINE");
            this.poem_lines = new Array("POEM LINE 1", "POEM LINE 2");
            this.poem_counter = 0;
        }

        public function get_next():String {
            var use_poem_line:Boolean = Math.floor(Math.random() * this.inv_poem_prob--) == 1;
            if (use_poem_line) {
                return this.poem_lines[this.poem_counter++];
            } else {
                return this.normal_lines[Math.floor(Math.random() * this.normal_lines.length)]
            }
        }
    }
}
