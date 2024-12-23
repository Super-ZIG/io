// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");
    const chars = @import("../../utils/chars/src.zig");
    const types = chars.types;
    const builtin = @import("builtin");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    /// Dynamic array of characters.
    pub const string = struct {
        const Self = @This();
        /// Nullable array of characters to store the content.
        m_buff: ?types.str,
        /// Allocator used for memory management.
        m_alloc: std.mem.Allocator,
        /// Size of the string.
        m_size: types.unsigned,
        /// Length of the string.
        m_bytes: types.unsigned,


        // ┌─────────────────────────── BASICS ───────────────────────────┐

            /// Returns the number of characters in the string.
            pub fn bytes(_self: Self) types.unsigned {
                return _self.m_bytes;
            }

            /// Returns the number of characters in the string (Unicode characters are counted as regular characters).
            pub fn ubytes(_self: Self) types.unsigned {
                if(_self.m_buff) |m_buff| return chars.ubytes(m_buff[0.._self.m_bytes]);
                return 0;
            }

            /// Returns the size of the string.
            pub fn size(_self: Self) types.unsigned {
                return _self.m_size;
            }

            /// Returns the source of the string.
            pub fn src(_self: Self) types.cstr {
                if (_self.m_buff) |m_buff| return m_buff[0.._self.m_bytes];
                return "";
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── INIT ────────────────────────────┐

            /// Initialize an empty string.
            pub fn init() Self {
                // set the console output to UTF-8 encoding for Windows.
                if (builtin.os.tag == .windows) { _ = std.os.windows.kernel32.SetConsoleOutputCP(65001); }

                return .{
                    .m_buff  = null,
                    .m_alloc = std.testing.allocator, // Use testing allocator for simplicity.
                    .m_size  = 0,
                    .m_bytes   = 0,
                };
            }

            /// Initialize a string with an allocator and a given substring.
            pub fn initWith(_it: anytype) anyerror!Self {
                var l_str = init();
                try l_str.append(_it);
                return l_str;
            }

            /// Deallocate the string buffer.
            pub fn deinit(_self: *Self) void {
                if (_self.m_buff) |m_buff| _self.m_alloc.free(m_buff);
                _self.m_size = 0;
                _self.m_bytes = 0;
            }

            /// Allocate or reallocate the string buffer to a new size.
            pub fn allocate(_self: *Self, _bytes: types.unsigned) anyerror!void {
                if (_self.m_buff) |m_buff| {
                    if (_bytes < _self.m_size) _self.m_size = _bytes;
                    _self.m_buff = _self.m_alloc.realloc(m_buff, _bytes) catch { return error.OutOfMemory; };
                } else {
                    _self.m_buff = _self.m_alloc.alloc(types.char, _bytes) catch { return error.OutOfMemory; };
                }
                _self.m_size = _bytes;
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── INSERT ───────────────────────────┐

            /// Inserts a (`string` or `char`) into the `end` of the string.
            pub fn append(_self: *Self, _it: anytype) anyerror!void {
                if(@TypeOf(_it) == Self) return _self.append(_it.src());
                const l_count = if(chars.utils.isCtype(@TypeOf(_it))) 1 else _it.len;
                try _self.__alloc(l_count + _self.m_bytes);
                chars.append(_self.m_buff.?[0.._self.m_size], _self.m_bytes, _it);
                _self.m_bytes += l_count;
            }

            /// Inserts a (`string` or `char`) into the `beginning` of the string.
            pub fn prepend(_self: *Self, _it: anytype) anyerror!void {
                if(@TypeOf(_it) == Self) return _self.prepend(_it.src());
                const l_count = if(chars.utils.isCtype(@TypeOf(_it))) 1 else _it.len;
                try _self.__alloc(l_count + _self.m_bytes);
                chars.prepend(_self.m_buff.?[0..], _self.m_bytes, _it);
                _self.m_bytes += l_count;
            }

            /// Inserts a (`string` or `char`) into a `specific position` in the string.
            pub fn insert(_self: *Self, _it: anytype, _pos: types.unsigned) anyerror!void {
                if(@TypeOf(_it) == Self) return _self.insert(_it.src(), _pos);
                if(_pos == _self.m_bytes) return _self.append(_it);
                if(_pos == 0) return _self.prepend(_it);

                const l_count = if(chars.utils.isCtype(@TypeOf(_it))) 1 else _it.len;
                try _self.__alloc(l_count + _pos);
                chars.insert(_self.m_buff.?[0.._self.m_size], _self.m_bytes, _it, _pos);
                _self.m_bytes += l_count;
            }

            /// Inserts a (`string` or `char`) into a `specific position` (The real position) in the string.
            pub fn insertReal(_self: *Self, _it: anytype, _pos: types.unsigned) anyerror!void {
                if(@TypeOf(_it) == Self) return _self.insert(_it.src(), _pos);
                if(_pos == _self.m_bytes) return _self.append(_it);
                if(_pos == 0) return _self.prepend(_it);

                const l_count = if(chars.utils.isCtype(@TypeOf(_it))) 1 else _it.len;
                try _self.__alloc(l_count + _pos);
                chars.insertReal(_self.m_buff.?[0.._self.m_size], _self.m_bytes, _it, _pos);
                _self.m_bytes += l_count;
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── REMOVE ───────────────────────────┐

            /// Removes a (`range` or `position`) from the string.
            pub inline fn remove(_self: *Self, _it: anytype) void {
                if(_self.m_buff) |m_buff| {
                    if(chars.utils.isUtype(@TypeOf(_it))) {
                        if(chars.utils.indexOf(m_buff[0.._self.m_bytes], _it)) |l_pos| {
                            const l_beg = l_pos - chars.utils.begOf(m_buff[0..], l_pos);
                            const l_count : types.unsigned = chars.utils.sizeOf(m_buff[l_beg]);
                            chars.removeReal(m_buff[0.._self.m_bytes], .{l_beg, l_beg+l_count});
                            _self.m_bytes -= l_count;
                        } else unreachable;
                    }
                    else {
                        const l_range = chars.utils.rangeOf(m_buff[0.._self.m_bytes], _it);
                        chars.remove(m_buff[0.._self.m_bytes], _it);
                        _self.m_bytes -= l_range[1] - l_range[0];
                    }
                }
            }

            /// Removes a (`range` or `position` (The real position)) from the string.
            pub inline fn removeReal(_self: *Self, _it: anytype) void {
                if(_self.m_buff) |m_buff| {
                    if(chars.utils.isUtype(@TypeOf(_it))) {
                        const l_beg = _it - chars.utils.begOf(m_buff[0..], _it);
                        const l_count : types.unsigned = chars.utils.sizeOf(m_buff[l_beg]);
                        chars.removeReal(m_buff[0.._self.m_bytes], .{l_beg, l_beg+l_count});
                        _self.m_bytes -= l_count;
                    }
                    else {
                        const l_range = chars.utils.realRangeOf(m_buff[0.._self.m_bytes], _it);
                        chars.removeReal(m_buff[0.._self.m_bytes], _it);
                        _self.m_bytes -= l_range[1] - l_range[0];
                    }
                }
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── WRITER ───────────────────────────┐

            pub usingnamespace struct {
                /// The underlying type of the Writer returned by `writer()`.
                pub const Writer = std.io.Writer(*Self, anyerror, __write);

                /// Returns a writer for the string.
                pub fn writer(_self: *Self) Writer {
                    return .{ .context = _self };
                }

                /// Writes a string to the writer.
                fn __write(_self: *Self, _it: types.cstr) !types.unsigned {
                    try _self.append(_it);
                    return _it.len;
                }

                /// Inserts a (`formatted string`) into the `end` of the string.
                pub fn write(_self: *Self, comptime _fmt: types.cstr, _args: anytype) anyerror!void {
                    const l_count = std.fmt.count(_fmt, _args);
                    try _self.__alloc(l_count + _self.m_bytes);
                    _self.writer().print(_fmt, _args) catch {};
                }

                /// Inserts a (`formatted string`) into the `beginning` of the string.
                pub fn writeStart(_self: *Self, comptime _fmt: types.cstr, _args: anytype) anyerror!void {
                    const l_count = std.fmt.count(_fmt, _args);
                    try _self.__alloc(l_count + _self.m_bytes);
                    chars.utils.move_right(_self.m_buff.?[0.._self.m_size], 0, _self.m_bytes, l_count);
                    var l_fixedBufferStream = std.io.fixedBufferStream(_self.m_buff.?[0..]);
                    const l_writer = l_fixedBufferStream.writer();
                    l_writer.print(_fmt, _args) catch {};
                    _self.m_bytes += l_count;
                }

                /// Inserts a (`formatted string`) into a `specific position` in the string.
                pub fn writeAt(_self: *Self, comptime _fmt: types.cstr, _args: anytype, _pos: types.unsigned) anyerror!void {
                    if(_pos == _self.m_bytes) return _self.write(_fmt, _args);
                    if(_pos == 0) return _self.writeStart(_fmt, _args);

                    try _self.__alloc(std.fmt.count(_fmt, _args) + _pos);
                    if(chars.utils.indexOf(_self.src(), _pos)) |l_pos| {
                        return _self.writeAtReal(_fmt, _args, l_pos);
                    } else unreachable;
                }

                /// Inserts a (`formatted string`) into a `specific position` (The real position) in the string.
                pub fn writeAtReal(_self: *Self, comptime _fmt: types.cstr, _args: anytype, _pos: types.unsigned) anyerror!void {
                    if(_pos == _self.m_bytes) return _self.write(_fmt, _args);
                    if(_pos == 0) return _self.writeStart(_fmt, _args);

                    const l_count = std.fmt.count(_fmt, _args);
                    try _self.__alloc(l_count + _pos);
                    const l_beg = _pos - chars.utils.begOf(_self.m_buff.?[0..], _pos);
                    chars.utils.move_right(_self.m_buff.?[0..], l_beg, _self.m_bytes-l_beg, l_count);

                    var l_fixedBufferStream = std.io.fixedBufferStream(_self.m_buff.?[l_beg..]);
                    const l_writer = l_fixedBufferStream.writer();
                    l_writer.print(_fmt, _args) catch unreachable;
                    _self.m_bytes += l_count;
                }
            };

        // └──────────────────────────────────────────────────────────────┘


        // ┌────────────────────────── ITERATOR ──────────────────────────┐

            pub usingnamespace struct {
                /// Iterator of the string type.
                pub const Iterator = struct {
                    /// String to iterate.
                    m_string: *const Self,
                    /// Current index.
                    m_index: types.unsigned,

                    /// Returns the next character in the string.
                    pub fn next(_it: *Iterator) ?types.cstr {
                        if (_it.m_string.m_buff) |m_buff| {
                            if (_it.m_index == _it.m_string.m_size) return null;
                            const i = _it.m_index;
                            _it.m_index += chars.utils.sizeOf(m_buff[i]);
                            return m_buff[i.._it.m_index];
                        } else {
                            return null;
                        }
                    }
                };

                /// Returns an iterator for the string.
                pub fn iterator(_self: *const Self) Iterator {
                    return Iterator{
                        .m_string = _self,
                        .m_index = 0,
                    };
                }
            };

        // └──────────────────────────────────────────────────────────────┘


        // ┌────────────────────────── INTERNAL ──────────────────────────┐

            /// ..?
            inline fn __alloc(_self: *Self, _bytes: types.unsigned) anyerror!void {
                if (_self.m_buff) |_| {
                    if (_self.m_size <= _bytes+1) {
                        try _self.allocate((_bytes+1) * 2);
                    }
                } else {
                    try _self.allocate((_bytes+1) * 2);
                }
            }

            /// ..?
            inline fn __indexOf(_self: *Self, _pos: types.unsigned) ?types.unsigned {
                return chars.utils.indexOf(_self.m_buff.?[0.._self.m_bytes], _pos).?;
            }

        // └──────────────────────────────────────────────────────────────┘
    };

// ╚══════════════════════════════════════════════════════════════════════════════════╝