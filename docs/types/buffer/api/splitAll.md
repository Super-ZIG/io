# [←](../readme.md) `io`.`types`.`string`.`splitAll`

> Returns an array of slices of the string split by the separator _(`string` or `char`)_.

```zig
pub inline fn splitAll(_self: Self, _sep: anytype) ![]types.cstr
```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_self` : `Self`

        > The string structure to be used.

    - `_sep` : `types.cstr` or `types.char` or `Self`

        > The separator to split with.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `anyerror` or `[]types.cstr`

    > An array of slices of the string split by the separator, or `anyerror` if failed.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example


    ```zig
    const string = @import("io").types.string;
    ```

    ```zig
    var str = try string.initWith(",1,,2,,3,");
    defer str.deinit();

    const res = try str.splitAll(',');

    res.len;    // 👉 7
    res[0];     // 👉 ""
    res[1];     // 👉 "1"
    res[2];     // 👉 ""
    res[3];     // 👉 "2"
    res[4];     // 👉 ""
    res[5];     // 👉 "3"
    res[6];     // 👉 ""
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.types.string.split`](./split.md)

  > [`io.types.string.splitToString`](./splitToString.md)

  > [`io.types.string.splitAllToStrings`](./splitAllToStrings.md)

  > [`io.types.string.lines`](./lines.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>