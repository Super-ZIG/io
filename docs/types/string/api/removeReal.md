# [←](../readme.md) `io`.`types`.`string`.`removeReal`

> Removes a _(`range` or `real position`)_ from the string.

```zig
pub inline fn removeReal(_self: *Self, _it: anytype) void
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_self` : `*Self`

        > The string structure to be used.

    - `_it` : `types.range` or `types.unsigned` or `Self`

        > The _(`range` or `real position`)_ to be remove.


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
    ```

    > Remove using a `real position`.

    ```zig
    str.removeReal(0);              // 👉 "🌍🌟!"
    ```

    > Remove using a `real range`.

    ```zig
    str.removeReal(.{ 4, 8 });      // 👉 "🌍!"
    str.removeReal(.{ 0, 4 });      // 👉 "!"
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.types.string.remove`](./remove.md)

  > [`io.types.string.pop`](./pop.md)

  > [`io.types.string.shift`](./shift.md)

  > [`io.types.string.clear`](./clear.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>