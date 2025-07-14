// codepoint.zig — Codepoint handling module for I/O library.
//
// repo   : https://github.com/Super-ZIG/io
// docs   : https://super-zig.github.io/io/string/utils/codepoint
// author : https://github.com/maysara-elshewehy
//
// Developed with ❤️ by Maysara.



// ╔══════════════════════════════════════ PACK ══════════════════════════════════════╗

    const utf8 = @import("../utf8/utf8.zig");
    const Codepoint = @This();

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    // ┌─────────────────────────── Fields ───────────────────────────┐

        /// Numeric value of the Unicode codepoint (U+0000 to U+10FFFF).
        src: u21 = 0,

        /// Length of this codepoint in UTF-8 (1-4 bytes).
        len: u3  = 0,

    // └──────────────────────────────────────────────────────────────┘


    // ┌────────────────────────── Methods ───────────────────────────┐

        /// Initializes a Codepoint from a Unicode scalar value if valid.
        /// Returns null if the codepoint is invalid according to UTF-8.
        pub fn init(cp: u21) ?Codepoint {
            return if(@call(.always_inline, utf8.isValidCodepoint, .{cp}))
            @call(.always_inline, unsafe_init, .{cp}) else null;
        }

        /// Initializes a Codepoint from a Unicode scalar value.
        /// Assumes the input is a valid codepoint.
        pub fn unsafe_init(cp: u21) Codepoint {
            return .{
                .src = cp,
                .len = @call(.always_inline, utf8.getCodepointLength, .{cp})
            };
        }

        /// Initializes a Codepoint from a UTF-8 encoded byte slice if valid.
        /// Returns null if the slice is empty or contains an invalid UTF-8 sequence.
        pub fn fromUtf8(slice: []const u8) ?Codepoint {
            return if(slice.len == 0 or !@call(.always_inline, utf8.isValidSlice, .{slice})) null
            else @call(.always_inline, unsafe_fromUtf8, .{slice});
        }

        /// Initializes a Codepoint from a UTF-8 encoded byte slice.
        /// Assumes the input is a valid UTF-8 slice.
        pub fn unsafe_fromUtf8(slice: []const u8) Codepoint {
            return if(@call(.always_inline, utf8.getSequenceLengthOrNull, .{slice[0]})) |len|
            .{
                .src = utf8.decode(slice[0..len]),
                .len = len
            } else .{};
        }

    // └──────────────────────────────────────────────────────────────┘

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ ITER ══════════════════════════════════════╗

    pub const Utf8Iterator = struct {

        // ┌─────────────────────────── Fields ───────────────────────────┐

            /// The UTF-8 encoded string that the iterator will traverse.
            src: []const u8,

            /// The current byte position in the string.
            pos: usize = 0,

        // └──────────────────────────────────────────────────────────────┘


        // ┌────────────────────────── Methods ───────────────────────────┐

            /// Initializes a new Utf8Iterator from the given UTF-8 slice if valid.
            /// Returns null if the slice is empty or contains invalid UTF-8.
            pub fn init(slice: []const u8) ?Utf8Iterator {
                return if(slice.len == 0 or !utf8.isValidSlice(slice)) null
                else @call(.always_inline, Utf8Iterator.unsafe_init, .{slice});
            }

            /// Initializes a new Utf8Iterator from the given UTF-8 slice.
            /// Assumes the input is a valid UTF-8 slice.
            pub fn unsafe_init(slice: []const u8) Utf8Iterator {
                return .{ .src = slice };
            }

            /// Returns the next Codepoint and increments the position.
            pub fn nextCodepoint(self: *Utf8Iterator) ?Codepoint {
                if(@call(.always_inline, Utf8Iterator.peekCodepoint, .{self.*})) |cp| {
                    self.pos += cp.len;
                    return cp;
                } else return null;
            }

            /// Returns the next UTF-8 slice and increments the position.
            pub fn nextSlice(self: *Utf8Iterator) ?[]const u8 {
                if(@call(.always_inline, Utf8Iterator.peekSlice, .{self.*})) |slice| {
                    self.pos += slice.len;
                    return slice;
                } else return null;
            }

            /// Returns the next codepoint length and increments the position.
            pub fn nextLength(self: *Utf8Iterator) ?u3 {
                if(@call(.always_inline, Utf8Iterator.peekLength, .{self.*})) |len| {
                    self.pos += len;
                    return len;
                } else return null;
            }

            /// Returns the next Codepoint without incrementing the position.
            pub fn peekCodepoint(self: Utf8Iterator) ?Codepoint {
                if(@call(.always_inline, Utf8Iterator.peekLength, .{self})) |len| {
                    return Codepoint {
                        .src = utf8.decode(self.src[self.pos..self.pos+len]),
                        .len = len
                    };
                } else return null;
            }

            /// Returns the next UTF-8 slice without incrementing the position.
            pub fn peekSlice(self: Utf8Iterator) ?[]const u8 {
                if(@call(.always_inline, Utf8Iterator.peekLength, .{self})) |len| {
                    return self.src[self.pos..self.pos+len];
                } else return null;
            }

            /// Returns the next codepoint length without incrementing the position.
            pub fn peekLength(self: Utf8Iterator) ?u3 {
                return if(self.pos == self.src.len) null
                else @call(.always_inline, utf8.getSequenceLengthOrNull, .{self.src[self.pos]});
            }

        // └──────────────────────────────────────────────────────────────┘
    };

// ╚══════════════════════════════════════════════════════════════════════════════════╝