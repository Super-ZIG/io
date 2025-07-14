// Copyright (c) 2025 Maysara, All rights reserved.
//
// repo : https://github.com/Super-ZIG/io
// docs : https://super-zig.github.io/io/string/utf8
//
// owner : https://github.com/maysara-elshewehy
// email : maysara.elshewehy@gmail.com
//
// Made with ❤️ by Maysara



// ╔══════════════════════════════════════ PACK ══════════════════════════════════════╗

    const std           = @import("std");
    const testing       = std.testing;
    const utf8          = @import("./utf8.zig");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const tests = [_]struct { slice: []const u8, codepoint: u21, } {
        .{ .slice = "A",  .codepoint = 0x00041 },
        .{ .slice = "©",  .codepoint = 0x000A9 },
        .{ .slice = "€",  .codepoint = 0x020AC },
        .{ .slice = "😀", .codepoint = 0x1F600 },
    };

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    // ┌────────────────────────── Conversion ────────────────────────┐

        test "utf8.encode" {
            var buf: [4]u8 = undefined;

            for (tests) |t| {
                const len = utf8.encode(t.codepoint, &buf);
                try testing.expectEqual(t.slice.len, len);
                for (0..len) |i|
                try testing.expectEqual(t.slice[i], buf[i]);
            }
        }

        test "utf8.decode" {
            for (tests) |t| {
                const cp = utf8.decode(t.slice);
                try testing.expectEqual(t.codepoint, cp);
                try testing.expectEqual(t.slice.len, utf8.getCodepointLength(cp));
            }
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌────────────────────────── Properties ────────────────────────┐

        test "utf8.getCodepointLength" {
            try testing.expectEqual(@as(u3, 1), utf8.getCodepointLength('A'));
            try testing.expectEqual(@as(u3, 2), utf8.getCodepointLength(0x00A9));
            try testing.expectEqual(@as(u3, 3), utf8.getCodepointLength(0x20AC));
            try testing.expectEqual(@as(u3, 4), utf8.getCodepointLength(0x1F600));
            try testing.expectEqual(null,       utf8.getCodepointLengthOrNull(0x110000));
        }

        test "utf8.getSequenceLength" {
            try testing.expectEqual(@as(u3, 1), utf8.getSequenceLength('A'));
            try testing.expectEqual(@as(u3, 2), utf8.getSequenceLength(0xC2));
            try testing.expectEqual(@as(u3, 3), utf8.getSequenceLength(0xE2));
            try testing.expectEqual(@as(u3, 4), utf8.getSequenceLength(0xF0));
            try testing.expectEqual(null,       utf8.getSequenceLengthOrNull(0xF8));
        }

        test "utf8.isValidSlice" {
            // Valid UTF-8 sequences
            try testing.expect(utf8.isValidSlice(""));
            try testing.expect(utf8.isValidSlice("Hello"));
            try testing.expect(utf8.isValidSlice("Hello 世界"));
            try testing.expect(utf8.isValidSlice("🌍🌎🌏"));

            // Invalid UTF-8 sequences
            try testing.expect(!utf8.isValidSlice(&[_]u8{0xFF}));
            try testing.expect(!utf8.isValidSlice(&[_]u8{0xC0, 0x80}));
            try testing.expect(!utf8.isValidSlice(&[_]u8{0xE0, 0x80}));
            try testing.expect(!utf8.isValidSlice(&[_]u8{0xF0, 0x80, 0x80}));
        }

        test "utf8.isValidCodepoint" {
            // Valid UTF-8 sequences
            try testing.expect(utf8.isValidCodepoint('A'));
            try testing.expect(utf8.isValidCodepoint('🌍'));
            try testing.expect(utf8.isValidCodepoint('世'));

            // Invalid UTF-8 sequences
            try testing.expect(!utf8.isValidCodepoint(0x110000));

            // ...
        }

    // └──────────────────────────────────────────────────────────────┘

// ╚══════════════════════════════════════════════════════════════════════════════════╝