// codepoint.test.zig !
//
// repo   : https://github.com/Super-ZIG/io
// docs   : https://super-zig.github.io/io/string/utils/codepoint
// author : https://github.com/maysara-elshewehy
//
// Developed with ❤️ by Maysara.



// ╔══════════════════════════════════════ PACK ══════════════════════════════════════╗

    const Codepoint = @import("./codepoint.zig");
    const testing   = @import("std").testing;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const SAMPLE = "A©€😀";
    const RESULT = [_]struct { utf8: []const u8, cp: u21 } {
        .{ .utf8 = "A",  .cp = 0x00041 },
        .{ .utf8 = "©",  .cp = 0x000A9 },
        .{ .utf8 = "€",  .cp = 0x020AC },
        .{ .utf8 = "😀", .cp = 0x1F600 },
    };

    const INVALID_CP = 0x110000;
    const INVALID_UTF8 = "\xFF";

// ╚══════════════════════════════════════════════════════════════════════════════════╝


// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    test "Codepoint" {
        for(0..RESULT.len) |i| {
            // init (using codepoint)
            if(Codepoint.init(RESULT[i].cp)) |cp| {
                try testing.expectEqual(RESULT[i].utf8.len, cp.len);
                try testing.expectEqual(RESULT[i].cp, cp.src);
            } else return error.CodepointInitError;

            // fromUtf8 (using UTF-8 slice)
            if(Codepoint.fromUtf8(RESULT[i].utf8)) |cp| {
                try testing.expectEqual(RESULT[i].utf8.len, cp.len);
                try testing.expectEqual(RESULT[i].cp, cp.src);
            } else return error.CodepointFromUtf8Error;
        }

        // must fail
        if(Codepoint.init(INVALID_CP)) |_| return error.CodepointInitMustFail;
        if(Codepoint.fromUtf8(INVALID_UTF8)) |_| return error.CodepointFromUtf8MustFail;
    }

    test "Utf8Iterator" {
        // must fail
        if(Codepoint.Utf8Iterator.init(INVALID_UTF8)) |_| return error.Utf8IteratorInitMustFail;
        var iterator = Codepoint.Utf8Iterator.init(SAMPLE) orelse return error.Utf8IteratorInitError;

        for(0..RESULT.len) |i| {

            // codepoint
            if(iterator.nextCodepoint()) |cp| {
                try testing.expectEqual(RESULT[i].utf8.len, cp.len);
                try testing.expectEqual(RESULT[i].cp, cp.src);

                // reset
                iterator.pos -= cp.len;
            } else return error.NextCodepointError;

            // utf8 slice
            if(iterator.nextSlice()) |slice| {
                try testing.expectEqual(RESULT[i].utf8.len, slice.len);
                try testing.expectEqualStrings(RESULT[i].utf8, slice);

                // reset
                iterator.pos -= slice.len;
            } else return error.NextSliceError;

            // length
            if(iterator.nextLength()) |len| {
                try testing.expectEqual(RESULT[i].utf8.len, len);
            } else return error.NextLengthError;
        }

        // position
        try testing.expectEqual(SAMPLE.len, iterator.pos);
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝