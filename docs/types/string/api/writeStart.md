# [←](../readme.md) `io`.`types`.`string`.`writeStart`

> Inserts a _(`formatted string`)_ into the `beginning` of the string.

```zig
pub fn writeStart(_self: *Self, comptime _fmt: types.cstr, _args: anytype) anyerror!void
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_self` : `*Self`

        > The string structure to be used.

    - `_fmt` : `types.cstr`

        > A [fmt string](https://ziglang.org/documentation/master/std/#std.fmt) used to format the string.

    - `_args` : `.{..}`

        > The arguments used to format the string

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `anyerror` or `void`

    > Modifies the string in place, returns an error if the memory allocation fails.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const string = @import("io").types.string;
    ```

    ```zig
    var str = string.init();
    defer str.deinit();

    try str.writeStart( "{c}", .{ '=' } );     // 👉 "="
    try str.writeStart( "{s}", .{ "🌍" } );    // 👉 "🌍="
    try str.writeStart( "{s}", .{ "🌟" } );    // 👉 "🌟🌍="
    try str.writeStart( "{d}", .{ 99 } );      // 👉 "99🌟🌍="
    ```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.types.string.write`](./write.md)

  > [`io.types.string.writeAt`](./writeAt.md)

  > [`io.types.string.writer`](./writer.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>