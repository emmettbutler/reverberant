package {
    import org.flixel.*;

    public class LineGenerator {
        public var normal_lines:Array;
        public var poem_lines:Array;

        public var poem_counter:Number;
        public var line_counter:Number = 0;
        public var inv_poem_prob:Number = 5;

        public function LineGenerator() {
            this.normal_lines = new Array(
                "mov [recvbuflen], dword 0xffff",
                "push dword [socketarray]",
                "call recv packet",
                "add esp, 4",
                "test eax, eax",
                "js syn scan next batch",
                "movzx eax, byte [recvbuf]",
                "and eax, 0xf",
                "shl eax, 2",
                "mov edi, eax",
                "add eax, 13",
                "lea esi, [recvbuf   eax]",
                "lodsb",
                "and al, 0x12",
                "cmp al, 0x12",
                "jne syn scan recv reply loop",
                "push dword port open fmtstr",
                "movzx eax, word [recvbuf   edi]",
                "xchg al, ah",
                "push eax",
                "call print port",
                "add esp, 8"
            );
            this.poem_lines = new Array(
                "the walk to work was slow",
                "shuffled your feet",
                "breathed a lot",
                "she left early that morning",
                "when you were barely awake",
                "you tried to say goodbye",
                "all you got out was 'mmmgff'",
                "on the train nervously tap phone",
                "jittery and rundown",
                "uninterested in feeling anything else",
                "keep your mind off of the thoughts",
                "that wouldn't stop no matter how",
                "you wish they would",
                "thinking",
                "literally anything could happen right now",
                "and you wouldn't see it coming",
                "and that would be it for you",
                "you made a cup of tea at work",
                "breathing heavily",
                "attempting to control the throat lump",
                "stomach churn",
                "thought it would calm you down",
                "it did in an annoyingly superficial way",
                "having the internet at your fingertips",
                "doesn't sound appealing",
                "when everything makes your heart pound",
                "turns your throat into a screaming machine",
                "the feeling doesn't go away all day",
                "focusing on work doesn't happen",
                "type some things",
                "distracting yourself from yourself",
                "every once in a while",
                "you have a thought that sets you off",
                "you're typing a line",
                "and the words aren't what you told them to be",
                "it's the same word twice",
                "or a smudge from all the wrong keys",
                "as your hands pretend everything's fine",
                "it doesn't feel real",
                "to be in a full panic at your desk",
                "wondering if anyone around you notices",
                "each bodypart tenses itself to the limit",
                "hold back purposeless sobs",
                "a physical reaction",
                "of terror",
                "get up hiding your face",
                "walk quickly to the bathroom",
                "close the door",
                "lock it",
                "open the window",
                "look out at the street",
                "and scream silently to the buildings",
                "with only a faint idea of what you're doing or why",
                "it's easier after that",
                "for a little while",
                "you get some work done",
                "order the computer around with magic spells",
                "knowing that at any moment you'll become subhuman"
            );
            this.poem_counter = 0;
        }

        public function get_next():String {
            this.line_counter++;
            var use_poem_line:Boolean = false;
            if (this.line_counter % (2+Math.floor(Math.random() * 3)) == 0 && this.line_counter > 3) {
                use_poem_line = true;
            }
            if (use_poem_line) {
                return this.poem_lines[this.poem_counter++];
            } else {
                return this.normal_lines[Math.floor(Math.random() * this.normal_lines.length)]
            }
        }

        public function get_current_poem_line():String {
            return this.poem_lines[this.poem_counter];
        }
    }
}
