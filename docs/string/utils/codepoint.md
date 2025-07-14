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
        Codepoint
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
    const codepoint = @import("io").string.utils.codepoint;
    ```

    > Initializes a Codepoint from a Codepoint or UTF-8 slice.

    ```zig
    _ = codepoint.init(0x1F31F).?;   // 👉 .{ .src = 0x1F31F, .len = 4 }
    _ = codepoint.fromUtf8("🌟").?;  // 👉 .{ .src = 0x1F31F, .len = 4 }
    ```

    > Iterate over a Codepoint or UTF-8 slice.

    ```zig
    var iter = codepoint.Utf8Iterator.init("..").?; // 👉 .{ .src = "..", .pos = 0 }

    while(iter.nextSlice())     |slice| { .. }
    while(iter.nextCodepoint()) |cp|    { .. }
    ```

<br>
<div align="center">
    <img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

<!--------------------------------------------------------------------------->



<!----------------------------------- API ----------------------------------->

- ### API

    - #### Codepoint

        - ##### Fields

            | Field | Type  | Description                                                  |
            | ----- | ----- | ------------------------------------------------------------ |
            | `src` | `u21` | Numeric value of the Unicode codepoint (U+0000 to U+10FFFF). |
            | `len` | `u3`  | Length of this codepoint in UTF-8 (1-4 bytes).               |

        - ##### Initialization

            | Function        | Return  | Description                                                        |
            | --------------- | ------- | ------------------------------------------------------------------ |
            | init            | `?Self` | Initializes a Codepoint from a Unicode `codepoint` value if valid. |
            | unsafe_init     | `Self`  | Initializes a Codepoint from a Unicode `codepoint` value.          |
            | fromUtf8        | `?Self` | Initializes a Codepoint from a `UTF-8 encoded slice` if valid.     |
            | unsafe_fromUtf8 | `Self`  | Initializes a Codepoint from a `UTF-8 encoded slice`.              |

    - #### Utf8Iterator

        - ##### Fields

            | Field | Type         | Description                                               |
            | ----- | ------------ | --------------------------------------------------------- |
            | `src` | `[]const u8` | The UTF-8 encoded string that the iterator will traverse. |
            | `pos` | `usize`      | The current byte position in the string.                  |

        - ##### Initialization

            | Function    | Return  | Description                                                           |
            | ----------- | ------- | --------------------------------------------------------------------- |
            | init        | `?Self` | Initializes a new Utf8Iterator from the given `UTF-8 slice` if valid. |
            | unsafe_init | `Self`  | Initializes a new Utf8Iterator from the given `UTF-8 slice`.          |

        - ##### Next

            | Function      | Return       | Description                                                          |
            | ------------- | ------------ | -------------------------------------------------------------------- |
            | nextCodepoint | `?Codepoint` | Returns the next `Codepoint` **and** increments the position.        |
            | nextSlice     | `?Codepoint` | Returns the next `UTF-8 slice` **and** increments the position.      |
            | nextLength    | `?Codepoint` | Returns the next `Codepoint` length **and** increments the position. |

        - ##### Peek

            | Function      | Return       | Description                                                                |
            | ------------- | ------------ | -------------------------------------------------------------------------- |
            | peekCodepoint | `?Codepoint` | Returns the next `Codepoint` **without** incrementing the position.        |
            | peekSlice     | `?Codepoint` | Returns the next `UTF-8 slice` **without** incrementing the position.      |
            | peekLength    | `?Codepoint` | Returns the next `Codepoint` length **without** incrementing the position. |

<br>
<div align="center">
    <img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

<!--------------------------------------------------------------------------->



<!---------------------------------- BENCH ---------------------------------->

- ### Benchmark

    > A quick summary with sample performance test results between _**`SuperZIG`.`io`.`string`.`utils`.`codepoint`**_ implementations and its popular competitors.

    - #### vs `std.unicode`

        > _**In summary**, `io` is faster by **5 times** compared to `std` in most cases, thanks to its optimized implementation. ✨_

        - #### Debug Build (`zig build run -- codepoint`)

            | Benchmark | Runs   | Total Time | Avg Time | Speed |
            | --------- | ------ | ---------- | -------- | ----- |
            | std_x10   | 100000 | 87.4ms     | 874ns    | x1.00 |
            | io_x10    | 100000 | 65.6ms     | 656ns    | x1.33 |
            | std_x100  | 23412  | 2.108s     | 90.082us | x1.00 |
            | io_x100   | 46583  | 1.952s     | 41.918us | x2.15 |
            | std_x1000 | 234    | 2.061s     | 8.81ms   | x1.00 |
            | io_x1000  | 457    | 2.1s       | 4.596ms  | x1.92 |

        - #### Release Build (`zig build run --release=fast -- codepoint`)

            | Benchmark | Runs   | Total Time | Avg Time | Speed |
            | --------- | ------ | ---------- | -------- | ----- |
            | std_x10   | 100000 | 84.9ms     | 849ns    | x1.00 |
            | io_x10    | 100000 | 22ms       | 220ns    | x3.86 |
            | std_x100  | 25531  | 1.967s     | 77.053us | x1.00 |
            | io_x100   | 100000 | 1.56s      | 15.608us | x4.94 |
            | std_x1000 | 263    | 2.107s     | 8.012ms  | x1.00 |
            | io_x1000  | 1233   | 1.966s     | 1.594ms  | x5.02 |

    > **It is normal for the values ​​to differ each time the benchmark is run, but in general these percentages will remain close.**

    > The benchmarks were run on a **Windows 11 v24H2** with **11th Gen Intel® Core™ i5-1155G7 × 8** processor and **32GB** of RAM.
    >
    > The version of zig used is **0.14.0**.
    >
    > The source code of this benchmark **[bench/string/utils/codepoint.zig](https://github.com/Super-ZIG/io-bench/tree/main/src/bench/string/utils/codepoint.zig)**.

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