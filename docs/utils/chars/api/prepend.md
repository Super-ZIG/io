# [←](../readme.md) `io`.`utils`.`chars`.`prepend`

> Inserts a _(`string` or `char`)_ into the `beginning` of the string.

```zig
pub inline fn prepend(_to: types.str, _len: types.unsigned, _it: anytype) void
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `_to` : `types.str`

        > The string to insert into.


    - `_len` : `types.unsigned`

        > The length of string to insert into.


    - `_it` : `types.cstr` or `types.char`

        > The _(`string` or `char`)_ to be inserted into the string.


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `void`

    > Modifies the string in place, does not return a value.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const chars = @import("io").utils.chars;
    ```

    ```zig
    const src = chars.make(64, null);
    ```

    > Prepend using a `character`.

    ```zig
    chars.prepend(res[0..], 0, '=');     // 👉 "="
    ```

    > Prepend using a `unicode`.

    ```zig
    chars.prepend(res[0..], 1, "🌍");    // 👉 "🌍="
    chars.prepend(res[0..], 5, "🌟");    // 👉 "🌟🌍="
    ```

    > Prepend using a `string`.

    ```zig
    chars.prepend(res[0..], 9, "!!");    // 👉 "!!🌟🌍="
    ```

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`io.utils.chars.append`](./append.md)

  > [`io.utils.chars.insert`](./insert.md)

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>