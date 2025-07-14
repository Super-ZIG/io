// io.zig — Central entry point for I/O library.
//
// repo   : https://github.com/Super-ZIG/io
// docs   : https://super-zig.github.io/io
// author : https://github.com/maysara-elshewehy
//
// Developed with ❤️ by Maysara.



// ╔══════════════════════════════════════ PACK ══════════════════════════════════════╗

    /// Provides utilities for string manipulation and operations.
    pub const string = @import("./string/string.zig");

    /// Provides utilities for terminal input/output operations.
    pub const terminal = @import("./terminal/terminal.zig");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    test {
        _ = @import("./string/string.zig");
        _ = @import("./terminal/terminal.zig");
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝