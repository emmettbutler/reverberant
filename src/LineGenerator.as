package {
    import org.flixel.*;

    public class LineGenerator {
        public var normal_lines:Array;
        public var poem_lines:Array;

        public var poem_counter:Number;

        public function LineGenerator() {
            this.normal_lines = new Array("NORMAL LINE");
            this.poem_lines = new Array("POEM LINE");
            this.poem_counter = 0;
        }

        public function get_next():String {
            return this.normal_lines[Math.floor(Math.random() * this.normal_lines.length)]
        }
    }
}
