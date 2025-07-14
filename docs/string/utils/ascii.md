<!----------------------------------- CSS ----------------------------------->

<style>
@font-face {
    font-family: 'Chakra Petch';
    src: url('https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/fonts/Chakra_Petch/ChakraPetch-Bold.ttf') format('truetype');
    font-weight: bold;
    font-style: normal;
}
</style>

<!--------------------------------------------------------------------------->



<!----------------------------------- BEG ----------------------------------->
<br>
<div align="center">
    <p style="font-size: 40px; font-family: 'Chakra Petch', sans-serif;">
        ASCII
    </p>
</div>

<p align="center">
    <img src="https://img.shields.io/badge/version-0.0.8 dev.2-blue.svg" alt="Version" />
    <a href="https://github.com/Super-ZIG/io/actions/workflows/main.yml">
        <img src="https://github.com/Super-ZIG/io/actions/workflows/main.yml/badge.svg" alt="CI" />
    </a>
    <img src="https://img.shields.io/github/issues/Super-ZIG/io?style=flat" alt="Github Repo Issues" />
    <a href="https://github.com/Super-ZIG/io/blob/main/LICENSE">
        <img src="https://img.shields.io/badge/license-MIT-green.svg" alt="license" />
    </a>
    <img src="https://img.shields.io/github/stars/Super-ZIG/io?style=social" alt="GitHub Repo stars" />
</p>

<p align="center">
    <b>
        When simplicity meets efficiency
    </b>
</p>

<div align="center">
    <b>
        <i>
            <sup>
                part of
                <a href="https://github.com/Super-ZIG" title="SuperZIG Framework">SuperZig</a><span style="color:gray;">::</span><a href="https://github.com/Super-ZIG/io" title="IO Library">io</a> library
            </sup>
        </i>
    </b>
</div>

<div align="center">
    <img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
    <br>
</div>

<!--------------------------------------------------------------------------->



<!--------------------------------- Features -------------------------------->

- **🍃 Zero dependencies**—meticulously crafted code.

- **🚀 Blazing fast**—almost as fast as light!

- **🌍 Universal compatibility**—Windows, Linux, and macOS.

- **🛡️ Battle-tested**—ready for production.

<br>
<div align="center">
    <img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

<!--------------------------------------------------------------------------->



<!----------------------------------- --- ----------------------------------->


- ### Quick Start 🔥

    > If you have not already added the library to your project, please review the [installation guide](https://github.com/Super-ZIG/io/wiki/installation) for more information.

    ```zig
    const ascii = @import("io").string.utils.ascii;
    ```

    > Convert characters

    ```zig
    _ = ascii.toUpper('a');         // 👉 'A'
    _ = ascii.toLower('A');         // 👉 'a'
    ```

    > Check character properties

    ```zig
    _ = ascii.isUpper('A');         // 👉 true
    _ = ascii.isLower('a');         // 👉 true
    _ = ascii.isDigit('1');         // 👉 true
    _ = ascii.isHex('F');           // 👉 true
    _ = ascii.isWhitespace(' ');    // 👉 true
    _ = ascii.isPunctuation('!');   // 👉 true
    ...
    ```

<br>
<div align="center">
    <img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

<!--------------------------------------------------------------------------->



<!----------------------------------- API ----------------------------------->

- ### API

    - #### Conversion

        | Function | Return | Description                                                                                    |
        | -------- | ------ | ---------------------------------------------------------------------------------------------- |
        | toUpper  | `u8`   | Converts a character to `uppercase`, If not a `lowercase` letter, it is returned `unchanged`.  |
        | toLower  | `u8`   | Converts a character to `lowercase`, If not an `uppercase` letter, it is returned `unchanged`. |

    - #### Properties

        | Function       | Return | Description                                                                                             |
        | -------------- | ------ | ------------------------------------------------------------------------------------------------------- |
        | isUpper        | `bool` | Returns true if the character is an uppercase letter (`A-Z`).                                           |
        | isLower        | `bool` | Returns true if the character is a lowercase letter (`a-z`).                                            |
        | isAlphabetic   | `bool` | Returns true if the character is an alphabetic letter (`A-Z`, `a-z`).                                   |
        | isDigit        | `bool` | Returns true if the character is a numeric digit (`0-9`).                                               |
        | isAlphanumeric | `bool` | Returns true if the character is alphanumeric (`A-Z`, `a-z`, `0-9`).                                    |
        | isHex          | `bool` | Returns true if the character is a hexadecimal digit (`0-9`, `A-F`, `a-f`).                             |
        | isOctal        | `bool` | Returns true if the character is an octal digit (`0-7`).                                                |
        | isBinary       | `bool` | Returns true if the character is a binary digit (`0-1`).                                                |
        | isPunctuation  | `bool` | Returns true if the character is a punctuation symbol (`!`, `@`, `#`, `$`, `%`, `^`, `&`, `*`, ..).     |
        | isWhitespace   | `bool` | Returns true if the character is a whitespace character (`space`, `tab`, `newline`, `carriage return`). |
        | isPrintable    | `bool` | Returns true if the character is printable (`A-Z`, `a-z`, `0-9`, `punctuation marks`, `space`).         |
        | isControl      | `bool` | Returns true if the character is a control character (`ASCII 0x00-0x1F or 0x7F`).                       |

<br>
<div align="center">
    <img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

<!--------------------------------------------------------------------------->



<!---------------------------------- BENCH ---------------------------------->

- ### Benchmark

    > A quick summary with sample performance test results between _**`SuperZIG`.`io`.`string`.`utils`.`ascii`**_ implementations and its popular competitors.

    - #### vs `std.ascii`

        > _**In summary**, the two run at **the same speed** because they share almost the same code. ✨_

        - #### Debug Build (`zig build run --release=safe -- ascii`)

            | Benchmark | Runs   | Total Time | Avg Time | Speed |
            | --------- | ------ | ---------- | -------- | ----- |
            | std_x10   | 100000 | 2.2ms      | 22ns     | x1.00 |
            | io_x10    | 100000 | 1.9ms      | 19ns     | x1.16 |
            | std_x100  | 100000 | 5.9ms      | 59ns     | x1.00 |
            | io_x100   | 100000 | 5.2ms      | 52ns     | x1.13 |
            | std_x1000 | 100000 | 30.3ms     | 303ns    | x1.00 |
            | io_x1000  | 100000 | 30.5ms     | 305ns    | x0.99 |

        - #### Release Build (`zig build run --release=fast -- ascii`)

            | Benchmark | Runs   | Total Time | Avg Time | Speed |
            | --------- | ------ | ---------- | -------- | ----- |
            | std_x10   | 100000 | 1.6ms      | 16ns     | x1.00 |
            | io_x10    | 100000 | 1.5ms      | 15ns     | x1.07 |
            | std_x100  | 100000 | 5.2ms      | 52ns     | x1.00 |
            | io_x100   | 100000 | 5.2ms      | 52ns     | x1.00 |
            | std_x1000 | 100000 | 31.1ms     | 311ns    | x1.00 |
            | io_x1000  | 100000 | 31ms       | 310ns    | x1.00 |

    > **It is normal for the values ​​to differ each time the benchmark is run, but in general these percentages will remain close.**

    > The benchmarks were run on a **Windows 11 v24H2** with **11th Gen Intel® Core™ i5-1155G7 × 8** processor and **32GB** of RAM.
    >
    > The version of zig used is **0.14.0**.
    >
    > The source code of this benchmark **[bench/string/utils/ascii.zig](https://github.com/Super-ZIG/io-bench/tree/main/src/bench/string/utils/ascii.zig)**.

<br>
<div align="center">
    <img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

<!--------------------------------------------------------------------------->



<!----------------------------------- END ----------------------------------->

<br>
<div align="center">
    <a href="https://github.com/maysara-elshewehy">
        <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/>
    </a>
</div>

<!--------------------------------------------------------------------------->