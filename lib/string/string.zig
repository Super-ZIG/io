// string.zig — String handling module for I/O library.
//
// repo   : https://github.com/Super-ZIG/io
// docs   : https://super-zig.github.io/io/string
// author : https://github.com/maysara-elshewehy
//
// Developed with ❤️ by Maysara.



// ╔══════════════════════════════════════ PACK ══════════════════════════════════════╗

    /// A utility module for efficient string manipulation, providing various tools
    /// for handling ASCII, UTF-8, codepoints, graphemes, and memory operations.
    pub const utils = .{
        .ascii      = @import("./utils/ascii/ascii.zig"),
        .utf8       = @import("./utils/utf8/utf8.zig"),
        .codepoint  = @import("./utils/codepoint/codepoint.zig"),
        .grapheme   = @import("./utils/grapheme/grapheme.zig"),
        .memory     = @import("./utils/memory/memory.zig"),
    };

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    test {
        // utils
        _ = @import("./utils/ascii/ascii.test.zig");
        _ = @import("./utils/utf8/utf8.test.zig");
        _ = @import("./utils/codepoint/codepoint.test.zig");
        _ = @import("./utils/grapheme/grapheme.test.zig");
        _ = @import("./utils/memory/memory.test.zig");
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝