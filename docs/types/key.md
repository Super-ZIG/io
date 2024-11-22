# **[SuperZig](https://github.com/Super-ZIG)** \ **[IO](../../README.md)** \ **[Docs](../readme.md)** \ **`types.key`** 🎹

- #### **Definition**

    A struct representing the details of a key press event, including its code, modifiers, and state.

- #### **Prototype**

    ```zig
    pub const key = struct
    {
        pub const State = enum
        {
            None,
            SinglePress,
            DoublePress,
        };

        m_val   : u8;            // Key code
        m_mod   : u3;            // Modifier keys (ctrl, alt, shift)
        m_state : State;         // Press state
    };
    ```

- #### **Fields**

  - `m_val` The key code (as an 8-bit unsigned integer).

  - `m_mod` Modifier keys applied (`ctrl`, `alt`, `shift`), represented as a 3-bit unsigned integer.

  - `m_state` The press state, represented by the `State` enum:

    - `None` No press detected.

    - `SinglePress` A single key press.

    - `DoublePress` A double key press.

- #### **Methods**

  - **state**  
    Returns the press state of the key.  

    ```zig
    pub inline fn state(_self: *const key) State;
    ```

  - **get**  
    Returns the key code.  

    ```zig
    pub inline fn get(_self: *const key) u8;
    ```

  - **char**  
    Returns the character representation of the key based on modifiers.  

    ```zig
    pub inline fn char(_self: *const key) u8;
    ```

  - **mod**  
    Returns a string representation of the active modifiers.  

    ```zig
    pub inline fn mod(_self: *const key) []const u8;
    ```

  - **alt**  
    Returns `true` if the `Alt` modifier is active.  

    ```zig
    pub inline fn alt(_self: *const key) bool;
    ```

  - **ctrl**  
    Returns `true` if the `Ctrl` modifier is active.  

    ```zig
    pub inline fn ctrl(_self: *const key) bool;
    ```

  - **shift**  
    Returns `true` if the `Shift` modifier is active.  

    ```zig
    pub inline fn shift(_self: *const key) bool;
    ```

  - **count**  
    Returns the count of active modifiers.  

    ```zig
    pub inline fn count(_self: *const key) u8;
    ```

- #### **Constants**

  - `MOD_ALT` Represents the `Alt` key modifier (`1 << 0`).

  - `MOD_SHIFT` Represents the `Shift` key modifier (`1 << 1`).

  - `MOD_CTRL` Represents the `Ctrl` key modifier (`1 << 2`).

- #### **Example**

    ```zig
    const myKey = key
    {
        .m_val      = 65, // 'A'
        .m_mod      = 2,  // Shift
        .m_state    = key.State.None,
    };

    try io.outWith( "Key: {c},     Modifiers: {s},    Count: {d}   \n",
                 .{ myKey.char(),   myKey.mod(),     myKey.count() });
    ```

- #### **Notes**

    - **Platform-specific, with support for `Windows` and `Linux`.**

    - **Outputs an error message for unsupported platforms.**

- ##### Related

  - ###### [`io.on`](../func/on.md)
  - ###### [`io.once`](../func/once.md)

---

Made with ❤️ by [Maysara](http://github.com/maysara-elshewehy).