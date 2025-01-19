// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    const std = @import("std");
    const utf8 = @import("../../utils/utf8/utf8.zig");
    const Bytes = @import("../../utils/bytes/bytes.zig");

    const Allocator = std.mem.Allocator;

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ CORE ══════════════════════════════════════╗

    /// Unmanage dynamic utf8 string type.
    pub const String = struct {

        // ┌──────────────────────────── ---- ────────────────────────────┐

            const Self = @This();

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────────── Fields ───────────────────────────┐

            /// Allocator used for memory management.
            allocator: Allocator = undefined,

            /// The mutable UTF-8 encoded bytes.
            source: []u8 = &[_]u8{},

            /// The number of written bytes to `source`.
            length: usize = 0,

            /// The number of bytes that can be written to `source`.
            capacity: usize = 0,

        // └──────────────────────────────────────────────────────────────┘


        // ┌─────────────────────── Initialization ───────────────────────┐

            /// Initializes a new `String` instance with the given `allocator`.
            pub fn initAlloc(allocator: Allocator) Self {
                return Self{ .allocator = allocator, };
            }

            /// Initializes a new `String` instance with `allocator` and `size`.
            /// - `initCapacityError.ZeroSize` _if the `size` is 0._
            pub fn initCapacity(allocator: Allocator, size: usize) initCapacityError!Self {
                if(size == 0) return initCapacityError.ZeroSize;

                var self = Self.initAlloc(allocator);
                try self.ensureTotalCapacityPrecise(size);
                return self;
            }
            pub const initCapacityError = Allocator.Error || error { ZeroSize };

            /// Initializes a new `String` instance with the given `allocator` and `value`.
            /// - `initError.InvalidValue` **_if the `value` is not valid utf8._**
            /// - `initError.ZeroSize` **_if the length of `value` is 0._**
            /// - `std.mem.Allocator` **_if the allocator returned an error._**
            pub fn init(alloator: Allocator, value: []const u8) initError!Self {
                if(!utf8.utils.isValid(value)) return initError.InvalidValue;

                var self = try Self.initCapacity(alloator, value.len*2);
                self.appendSliceAssumeCapacity(value);
                self.length = Bytes.countWritten(value);
                
                return self;
            }
            pub const initError = initCapacityError || error { InvalidValue };

            /// Release all allocated memory.
            pub fn deinit(self: Self) void {
                self.allocator.free(self.allocatedSlice());
            }

        // └──────────────────────────────────────────────────────────────┘
            

        // ┌──────────────────────────── Find ────────────────────────────┐

            /// Finds the **real position** of the **first** occurrence of `value`. 
            pub fn find(self: Self, target: []const u8) ?usize {
                return Bytes.find(self.writtenSlice(), target);
            }

            /// Finds the **visual position** of the **first** occurrence of `value`.
            pub fn findVisual(self: Self, target: []const u8) !?usize {
                return Bytes.findVisual(self.writtenSlice(), target);
            }

            /// Finds the **real position** of the **last** occurrence of `value`.
            pub fn rfind(self: Self, target: []const u8) ?usize {
                return Bytes.rfind(self.writtenSlice(), target);
            }

            /// Finds the **visual position** of the **last** occurrence of `value`.
            pub fn rfindVisual(self: Self, target: []const u8) ?usize {
                return Bytes.rfindVisual(self.writtenSlice(), target);
            }

            /// Returns `true` **if contains `target`**.
            pub fn includes(self: Self, target: []const u8) bool {
                return Bytes.includes(self.writtenSlice(), target);
            }

            /// Returns `true` **if starts with `target`**.
            pub fn startsWith(self: Self, target: []const u8) bool {
                return Bytes.startsWith(self.writtenSlice(), target);
            }

            /// Returns `true` **if ends with `target`**.
            pub fn endsWith(self: Self, target: []const u8) bool {
                return Bytes.endsWith(self.writtenSlice(), target);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Case ────────────────────────────┐

            /// Converts all (ASCII) letters to lowercase.
            pub fn toLower(self: *Self) void {
                if(self.length > 0)
                Bytes.toLower(self.allocatedSlice()[0..self.length]);
            }

            /// Converts all (ASCII) letters to uppercase.
            pub fn toUpper(self: *Self) void {
                if(self.length > 0)
                Bytes.toUpper(self.allocatedSlice()[0..self.length]);
            }

            // Converts all (ASCII) letters to titlecase.
            pub fn toTitle(self: *Self) void {
                if(self.length > 0)
                Bytes.toTitle(self.allocatedSlice()[0..self.length]);
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Count ───────────────────────────┐
            
            /// Returns the total number of written bytes, stopping at the first null byte.
            pub fn countWritten(self: Self) usize {
                return self.length;
            }

            /// Returns the total number of visual characters, stopping at the first null byte.
            pub fn countVisual(self: Self) usize {
                return Bytes.countVisual(self.writtenSlice());
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌────────────────────────── Iterator ──────────────────────────┐

            /// Creates an iterator for traversing the UTF-8 bytes.
            /// - `utf8.Iterator.Error` **_if the initialization failed._**
            pub fn iterator(self: Self) utf8.Iterator.Error!utf8.Iterator {
                return try utf8.Iterator.init(self.writtenSlice());
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌──────────────────────────── Utils ───────────────────────────┐

            /// Returns a slice representing the entire allocated memory range.
            pub fn allocatedSlice(self: Self) []u8 {
                return self.source.ptr[0..self.capacity];
            }

            /// Returns a slice containing only the written part.
            pub fn writtenSlice(self: Self) []const u8 {
                return if(self.length > 0 )self.source.ptr[0..self.length] else "";
            }

        // └──────────────────────────────────────────────────────────────┘


        // ┌───────────────────────── Internal ───────────────────────────┐

            /// If the current capacity is less than `new_capacity`, this function will
            /// modify the array so that it can hold exactly `new_capacity` bytes.
            /// Invalidates element pointers if additional memory is needed.
            fn ensureTotalCapacityPrecise(self: *Self, new_capacity: usize) Allocator.Error!void {
                if (self.capacity >= new_capacity) return;

                // Here we avoid copying allocated but unused bytes by
                // attempting a resize in place, and falling back to allocating
                // a new buffer and doing our own copy. With a realloc() call,
                // the allocator implementation would pointlessly copy our
                // extra capacity. referance: std.ArrayList.
                const old_memory = self.allocatedSlice();
                if (self.allocator.resize(old_memory, new_capacity)) {
                    self.capacity = new_capacity;
                } else {
                    const new_memory = try self.allocator.alloc(u8, new_capacity);
                    @memcpy(new_memory[0..self.source.len], self.source);
                    self.allocator.free(old_memory);
                    self.source.ptr = new_memory.ptr;
                    self.capacity = new_memory.len;
                }

            }

            /// Append the slice of bytes to the list.
            /// Never invalidates element pointers.
            /// Asserts that the list can hold the additional bytes.
            fn appendSliceAssumeCapacity(self: *Self, slice: []const u8) void {
                const old_len = self.source.len;
                const new_len = old_len + slice.len;
                std.debug.assert(new_len <= self.capacity);
                self.source.len = new_len;
                self.length = new_len;
                @memcpy(self.source[old_len..][0..slice.len], slice);
            }

        // └──────────────────────────────────────────────────────────────┘
    };
    
// ╚══════════════════════════════════════════════════════════════════════════════════╝