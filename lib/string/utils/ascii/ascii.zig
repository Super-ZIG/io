// ascii.zig — ASCII handling module for I/O library.
//
// repo   : https://github.com/Super-ZIG/io
// docs   : https://super-zig.github.io/io/string/utils/ascii
// author : https://github.com/maysara-elshewehy
//
// Developed with ❤️ by Maysara.



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    // ┌────────────────────────── Conversion ────────────────────────┐

        /// Converts a character to uppercase.
        /// If the character is not a lowercase letter, it is returned unchanged.
        pub fn toUpper(c: u8) u8 {
            // credit: std.ascii.toUpper
            const mask = @as(u8, @intFromBool(@call(.always_inline, isLower, .{c}))) << 5;
            return c ^ mask;
        }

        /// Converts a character to lowercase.
        /// If the character is not an uppercase letter, it is returned unchanged.
        pub fn toLower(c: u8) u8 {
            // credit: std.ascii.toLower
            const mask = @as(u8, @intFromBool(@call(.always_inline, isUpper, .{c}))) << 5;
            return c | mask;
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌────────────────────────── Properties ────────────────────────┐

        /// Returns true if the character is an uppercase letter (`A-Z`).
        pub fn isUpper(c: u8) bool {
            return switch (c) {
                'A'...'Z' => true,
                else => false,
            };
        }

        /// Returns true if the character is a lowercase letter (`a-z`).
        pub fn isLower(c: u8) bool {
            return switch (c) {
                'a'...'z' => true,
                else => false,
            };
        }

        /// Returns true if the character is an alphabetic letter (`A-Z`, `a-z`).
        pub fn isAlphabetic(c: u8) bool {
            return switch (c) {
                'A'...'Z', 'a'...'z' => true,
                else => false,
            };
        }

        /// Returns true if the character is a numeric digit (`0-9`).
        pub fn isDigit(c: u8) bool {
            return switch (c) {
                '0'...'9' => true,
                else => false,
            };
        }

        /// Returns true if the character is alphanumeric (`A-Z`, `a-z`, `0-9`).
        pub fn isAlphanumeric(c: u8) bool {
            return switch (c) {
                'A'...'Z', 'a'...'z', '0'...'9' => true,
                else => false,
            };
        }

        /// Returns true if the character is a hexadecimal digit (`0-9`, `A-F`, `a-f`).
        pub fn isHex(c: u8) bool {
            return switch (c) {
                '0'...'9', 'A'...'F', 'a'...'f' => true,
                else => false,
            };
        }

        /// Returns true if the character is an octal digit (`0-7`).
        pub fn isOctal(c: u8) bool {
            return switch (c) {
                '0'...'7' => true,
                else => false,
            };
        }

        /// Returns true if the character is a binary digit (`0`, `1`).
        pub fn isBinary(c: u8) bool {
            return switch (c) {
                '0', '1' => true,
                else => false,
            };
        }

        /// Returns true if the character is a punctuation symbol
        /// (any printable ASCII character that is not a letter, digit, or space).
        pub fn isPunctuation(c: u8) bool {
            return switch (c) {
                '!'...'/', ':'...'@', '['...'`', '{'...'~' => true,
                else => false,
            };
        }

        /// Returns true if the character is a whitespace character
        /// (space, tab, newline, carriage return).
        pub fn isWhitespace(c: u8) bool {
            return switch (c) {
                ' ', '\t', '\n', '\r' => true,
                else => false,
            };
        }

        /// Returns true if the character is printable
        /// (ASCII 0x20-0x7E, i.e., space through tilde).
        pub fn isPrintable(c: u8) bool {
            return switch (c) {
                ' '...'~' => true,
                else => false,
            };
        }

        /// Returns true if the character is a control character
        /// (ASCII 0x00-0x1F or 0x7F).
        pub fn isControl(c: u8) bool {
            return (c <= 0x1F) or (c == 0x7F);
        }

    // └──────────────────────────────────────────────────────────────┘

// ╚══════════════════════════════════════════════════════════════════════════════════╝