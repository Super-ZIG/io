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
        UTF-8
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
    const utf8 = @import("io").string.utils.utf8;
    ```

    > Convert slice to codepoint

    ```zig
    _ = utf8.decode("🌟").?;                // 👉 0x1F31F
    ```

    > Convert codepoint to slice

    ```zig
    var buf: [4]u8 = undefined;             // 👉 "🌟"
    _ = utf8.encode(0x1F31F, &buf).?;       // 👉 4
    ```

    > Get codepoint length

    ```zig
    _ = utf8.getCodepointLength(0x1F31F);   // 👉 4
    ```

    > Get UTF-8 sequence length

    ```zig
    _ = utf8.getCodepointLength("🌟"[0]);   // 👉 4
    ```

<br>
<div align="center">
    <img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

<!--------------------------------------------------------------------------->



<!----------------------------------- API ----------------------------------->

- ### API

    - #### Encoding / Decoding

        | Function | Return | Description                                                                                   |
        | -------- | ------ | --------------------------------------------------------------------------------------------- |
        | encode   | `u3`   | Encode a single Unicode `codepoint` to `UTF-8 sequence`, Returns the number of bytes written. |
        | decode   | `u21`  | Decode a `UTF-8 sequence` to a Unicode `codepoint`, Returns the decoded codepoint.            |

    - #### Properties

        | Function                 | Return | Description                                                                                  |
        | ------------------------ | ------ | -------------------------------------------------------------------------------------------- |
        | getCodepointLength       | `u3`   | Returns the number of bytes (`1-4`) needed to encode a `codepoint` in UTF-8 format.          |
        | getCodepointLengthOrNull | `?u3`  | Returns the number of bytes (`1-4`) needed to encode a `codepoint` in UTF-8 format if valid. |
        | getSequenceLength        | `u3`   | Returns the number of bytes (`1-4`) in a `UTF-8 sequence` based on the first byte.           |
        | getSequenceLengthOrNull  | `?u3`  | Returns the number of bytes (`1-4`) in a `UTF-8 sequence` based on the first byte if valid.  |

    - #### Validation

        | Function         | Return | Description                                                            |
        | ---------------- | ------ | ---------------------------------------------------------------------- |
        | isValidSlice     | `bool` | Returns true if the provided slice contains valid `UTF-8 sequence`.    |
        | isValidCodepoint | `bool` | Returns true if the provided code point is valid for `UTF-8 encoding`. |

<br>
<div align="center">
    <img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

<!--------------------------------------------------------------------------->



<!---------------------------------- BENCH ---------------------------------->

- ### Benchmark

    > A quick summary with sample performance test results between _**`SuperZIG`.`io`.`string`.`utils`.`utf8`**_ implementations and its popular competitors.

    - #### vs `std.unicode`

        > _**In summary**, `io` is faster by **5 times** compared to `std` in most cases, thanks to its optimized implementation. ✨_

        - #### Debug Build (`zig build run --release=safe -- utf8`)

            | Benchmark | Runs   | Total Time | Avg Time | Speed |
            | --------- | ------ | ---------- | -------- | ----- |
            | std_x10   | 100000 | 92.7ms     | 927ns    | x1.00 |
            | io_x10    | 100000 | 31.9ms     | 319ns    | x2.91 |
            | std_x100  | 21485  | 1.959s     | 91.188us | x1.00 |
            | io_x100   | 96186  | 1.997s     | 20.768us | x4.39 |
            | std_x1000 | 218    | 2.067s     | 9.482ms  | x1.00 |
            | io_x1000  | 961    | 1.87s      | 1.946ms  | x4.87 |

        - #### Release Build (`zig build run --release=fast -- utf8`)

            | Benchmark | Runs   | Total Time | Avg Time | Speed |
            | --------- | ------ | ---------- | -------- | ----- |
            | std_x10   | 100000 | 102.6ms    | 1.026us  | x1.00 |
            | io_x10    | 100000 | 29.1ms     | 291ns    | x3.53 |
            | std_x100  | 20653  | 1.915s     | 92.771us | x1.00 |
            | io_x100   | 100000 | 1.796s     | 17.962us | x5.16 |
            | std_x1000 | 232    | 2.028s     | 8.742ms  | x1.00 |
            | io_x1000  | 1176   | 2.07s      | 1.76ms   | x4.96 |

    > **It is normal for the values ​​to differ each time the benchmark is run, but in general these percentages will remain close.**

    > The benchmarks were run on a **Windows 11 v24H2** with **11th Gen Intel® Core™ i5-1155G7 × 8** processor and **32GB** of RAM.
    >
    > The version of zig used is **0.14.0**.
    >
    > The source code of this benchmark **[bench/string/utils/utf8.zig](https://github.com/Super-ZIG/io-bench/tree/main/src/bench/string/utils/utf8.zig)**.

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