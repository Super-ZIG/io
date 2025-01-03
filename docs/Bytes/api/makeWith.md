# [←](../Bytes.md) `Bytes`.`makeWith`

> Creates a valid utf-8 array of `size` bytes and copies the `src` bytes into it.

```zig
pub fn makeWith(comptime _size: Types.len, _it: Types.cbytes) ![_size]Types.byte
```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Parameters

    - `comptime _size` : `Types.len`

        > The specified size of the array.

    - `_it` : `Types.cbytes`

        > The input to copy.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Returns : `![_size]Types.byte`

    > Returns `error.OutOfRange` _if the `_it` length is greater than the `_size`_.

    > Returns `error.ZeroValue` _if the `_size` is 0_.

    > Returns `error.InvalidUTF8` _if the `_it` is not valid UTF-8._.

    > A new array with specified size, initialized with the contents of `_it`.

    > **You can use the `Unchecked` ~= `Bytes.makeWithUnchecked` version for no checks/errors.**

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Example

    ```zig
    const Bytes = @import("io").Bytes;
    ```

    > Empty value

    ```zig
    _ = try Bytes.makeWith(64, "");           // 👉 error.ZeroValue
    ```

    > Non-Empty value

    ```zig
    _ = try Bytes.makeWith(64, "Hello 🌍!");  // 👉 "Hello 🌍!", size: 64, length: 11
    ```

    > Constant array of bytes.

    ```zig
    const src = "Hello 🌍!";
    _ = try Bytes.makeWith(64, src);          // 👉 "Hello 🌍!", size: 64, length: 11
    ```

    > Mutable array of bytes.

    ```zig
    var src = "Hello 🌍!";
    _ = try Bytes.makeWith(64, src[0..]);     // 👉 "Hello 🌍!", size: 64, length: 11
    ```

    > Length exceeds size.

    ```zig
    _ = try Bytes.makeWith(1, "122");         // 👉 error.OutOfRange
    ```


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- ##### Related

  > [`Bytes.make`](./make.md)

  > [`Bytes.clone`](./clone.md)


<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/_dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>