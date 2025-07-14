// ascii.test.zig !
//
// repo   : https://github.com/Super-ZIG/io
// docs   : https://super-zig.github.io/io/string/utils/ascii
// author : https://github.com/maysara-elshewehy
//
// Developed with ❤️ by Maysara.



// ╔══════════════════════════════════════ PACK ══════════════════════════════════════╗

    const std           = @import("std");
    const testing       = std.testing;
    const ascii         = @import("./ascii.zig");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const uppercase     = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    const lowercase     = "abcdefghijklmnopqrstuvwxyz";
    const digits        = "0123456789";
    const letters       = uppercase ++ lowercase;

    const punctuation   = "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~";
    const printable     = letters ++ digits ++ punctuation ++ " ";

    const whitespace    = " \t\n\r";
    const control       = "\x00\x01\x02\x03\x04\x05\x06\x07\x08\x09\x0a\x0b\x0c\x0d\x0e\x0f";
    const non_ascii     = "\x80\x81\x82\x83\x84\x85\x86\x87\x88\x89\x8a\x8b\x8c\x8d\x8e\x8f";

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    // ┌────────────────────────── Conversion ────────────────────────┐

        test "toUpper" {
            for(0..lowercase.len) |i| {
                try testing.expectEqual(uppercase[i], ascii.toUpper(lowercase[i]));
            }

            // unchanged
            for(uppercase ++ digits ++ punctuation) |c| {
                try testing.expectEqual(c, ascii.toUpper(c));
            }
        }

        test "toLower" {
            for(0..uppercase.len) |i| {
                try testing.expectEqual(lowercase[i], ascii.toLower(uppercase[i]));
            }

            // unchanged
            for(lowercase ++ digits ++ punctuation) |c| {
                try testing.expectEqual(c, ascii.toLower(c));
            }
        }

    // └──────────────────────────────────────────────────────────────┘


    // ┌────────────────────────── Properties ────────────────────────┐

        test "isUpper" {
            for(uppercase) |c| {
                try testing.expect(ascii.isUpper(c));
            }

            // false
            for(lowercase) |c| {
                try testing.expect(!ascii.isUpper(c));
            }
        }

        test "isLower" {
            for(lowercase) |c| {
                try testing.expect(ascii.isLower(c));
            }

            // false
            for(uppercase) |c| {
                try testing.expect(!ascii.isLower(c));
            }
        }

        test "isAlphabetic" {
            for(letters) |c| {
                try testing.expect(ascii.isAlphabetic(c));
            }

            // false
            for(digits) |c| {
                try testing.expect(!ascii.isAlphabetic(c));
            }
        }

        test "isDigit" {
            for(digits) |c| {
                try testing.expect(ascii.isDigit(c));
            }

            // false
            for(letters) |c| {
                try testing.expect(!ascii.isDigit(c));
            }
        }

        test "isAlphanumeric" {
            for(letters ++ digits) |c| {
                try testing.expect(ascii.isAlphanumeric(c));
            }

            // false
            for(punctuation) |c| {
                try testing.expect(!ascii.isAlphanumeric(c));
            }
        }

        test "isHex" {
            for("0123456789ABCDEFabcdef") |c| {
                try testing.expect(ascii.isHex(c));
            }

            for(non_ascii) |c| {
                try testing.expect(!ascii.isHex(c));
            }
        }

        test "isOctal" {
            for("01234567") |c| {
                try testing.expect(ascii.isOctal(c));
            }

            for(non_ascii) |c| {
                try testing.expect(!ascii.isOctal(c));
            }
        }

        test "isBinary" {
            for("01") |c| {
                try testing.expect(ascii.isBinary(c));
            }

            for(non_ascii) |c| {
                try testing.expect(!ascii.isBinary(c));
            }
        }

        test "isPunctuation" {
            for(punctuation) |c| {
                try testing.expect(ascii.isPunctuation(c));
            }

            // false
            for(letters ++ digits) |c| {
                try testing.expect(!ascii.isPunctuation(c));
            }
        }

        test "isWhitespace" {
            for(whitespace) |c| {
                try testing.expect(ascii.isWhitespace(c));
            }

            // false
            for(non_ascii) |c| {
                try testing.expect(!ascii.isWhitespace(c));
            }
        }

        test "isPrintable" {
            for(printable) |c| {
                try testing.expect(ascii.isPrintable(c));
            }

            // false
            for(non_ascii) |c| {
                try testing.expect(!ascii.isPrintable(c));
            }
        }

        test "isControl" {
            for(control) |c| {
                try testing.expect(ascii.isControl(c));
            }

            // false
            for(non_ascii) |c| {
                try testing.expect(!ascii.isControl(c));
            }
        }

    // └──────────────────────────────────────────────────────────────┘

// ╚══════════════════════════════════════════════════════════════════════════════════╝