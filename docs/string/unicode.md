<p align="center"> <br>
  <img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/logo/Unicode/logo.png" alt="Unicode" width="1000" />
</p>

<p align="center">
     <a href="#">
        <img src="https://img.shields.io/badge/under--development-yellow.svg" alt="Under Development" />
    </a>
    <a href="https://github.com/Super-ZIG/io/actions/workflows/main.yml">
        <img src="https://github.com/Super-ZIG/io/actions/workflows/main.yml/badge.svg" alt="CI" />
    </a>
    <img src="https://img.shields.io/github/issues/Super-ZIG/io?style=flat" alt="Github Repo Issues" />
    <img src="https://img.shields.io/github/stars/Super-ZIG/io?style=social" alt="GitHub Repo stars" />
</p>

<p align="center">
    <b> Utility functions for Unicode codepoints and grapheme clusters. </b>
</p>
<div align="center">
    <b><i>
        <sup> part of <a href="https://github.com/Super-ZIG/io">SuperZIG/io</a> library.</sup>
    </i></b>
</div>


<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

<div align="center">
    <b><i>
        <sup> 🔥 Built for power. Designed for speed. Ready for production. 🔥 </sup>
    </i></b>
</div>
<br>

- ### Features 🌟

    - 🌍 **Unicode Support**
        > Provides powerful utilities for handling Unicode codepoints and grapheme clusters.

    - ⚡ **Blazing Fast Performance**
        > Matches the speed of Zig’s standard library and outperforms competitors in benchmarks.

    - 🛡️ **Rock-Solid Stability**
        > Every function is rigorously tested, making the library safe, reliable, and ready for production.

    - 🏗️ **Optimized for Scalability**
        > Designed with efficiency in mind, avoiding unnecessary allocations while maintaining flexibility.

<div align="center">
<img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### 📖 Table of Contents

    🔹 [🚀 Quick Start](#quick-start-) – A quick guide to get you started with the library.

    🔹 [🎇 API Reference](#api) – Detailed documentation of available functions.

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### Quick Start 🚀

    > If you have not already added the library to your project, please review the [installation guide](https://github.com/Super-ZIG/io/wiki/installation) for more information.

    ```zig
    const unicode = @import("io").unicode;
    ```

    > The `unicode` module provides powerful utilities for handling Unicode codepoints and grapheme clusters. Let's explore some of its features.

    ```zig
    const ZWJ_array    : [3]u8 = .{0xE2, 0x80, 0x8D};
    const MOD_array    : [2]u8 = .{0xCC, 0x81};

    // Initialize a codepoint.
    const codepoint    = try unicode.Codepoint.init("A");
    const codepointZWJ = try unicode.Codepoint.init(&ZWJ_array);
    const codepointMOD = try unicode.Codepoint.init(&MOD_array);
    ```

    ```zig
    // Get the mode of the codepoint.
    _ = codepoint.mode;     // 👉 .None
    _ = codepointZWJ.mode;  // 👉 .ZWJ
    _ = codepointMOD.mode;  // 👉 .Mod
    ```

    ```zig
    // Get the length of the codepoint.
    _ = codepoint.len;      // 👉 1
    _ = codepointZWJ.len;   // 👉 3
    _ = codepointMOD.len;   // 👉 2
    ```

    ```zig
    // Initialize an iterator for codepoints/graphemeClusters.
    var it = try unicode.Iterator.init("Aأ你🌟☹️👨‍🏭");
    ```

    ```zig
    // Get the next codepoints/graphemeClusters slice.
    _ = it.nextGraphemeClusterSlice();  // 👉 "A"
    _ = it.nextGraphemeClusterSlice();  // 👉 "أ"
    _ = it.nextGraphemeClusterSlice();  // 👉 "你"
    _ = it.nextGraphemeClusterSlice();  // 👉 "🌟"
    _ = it.nextGraphemeClusterSlice();  // 👉 "☹️"
    _ = it.nextGraphemeClusterSlice();  // 👉 "👨‍🏭"
    ```

    ```zig
    while (it.<function>()) |<res>| {
        std.debug.print("<resTag>: {}\n", .{<res>});
    }
    ```

    ```zig
    // and much more . . !
    ```

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### API 🎇

    | Index                    |
    | ------------------------ |
    | [Codepoint](#-codepoint) |
    | [Iterator](#️-iterator)   |
    | [Utils](#-utils)         |


    - #### 💠 Codepoint

        - #### 🍃 Fields

            | Field  | Type    | Description                 |
            | ------ | ------- | --------------------------- |
            | `mode` | `Mode`  | The mode of the codepoint   |
            | `len`  | `usize` | The length of the codepoint |

        - #### ✨ Initialization

            | Function | Description                                                  |
            | -------- | ------------------------------------------------------------ |
            | init     | Initializes a `Codepoint` instance with the specified slice. |

            <div align="center"><br>
            <img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
            </div>

    - #### ♻️ Iterator

        - #### 🍃 Fields

            | Field | Type         | Description                          |
            | ----- | ------------ | ------------------------------------ |
            | `src` | `[]const u8` | The input slice to iterate over      |
            | `pos` | `usize`      | The current position of the iterator |

        - #### ✨ Initialization

            | Function                 | Description                                                              |
            | ------------------------ | ------------------------------------------------------------------------ |
            | init                     | Initializes an `Iterator` with the given input slice.                    |
            | initUnchecked            | Initializes an `Iterator` with the given input slice without validation. |
            | nextCodepointSlice       | Returns the next codepoint slice and advances the iterator.              |
            | nextGraphemeClusterSlice | Returns the next grapheme cluster slice and advances the iterator.       |
            | next                     | Decodes and returns the next codepoint and advances the iterator.        |
            | peek                     | Decodes and returns the next codepoint without advancing the iterator.   |

        - #### ♻️ Methods

            | Function                 | Description                                                            |
            | ------------------------ | ---------------------------------------------------------------------- |
            | nextCodepointSlice       | Retrieves the next codepoint slice and advances the iterator.          |
            | nextGraphemeClusterSlice | Retrieves the next grapheme cluster slice and advances the iterator.   |
            | next                     | Decodes and returns the next codepoint and advances the iterator.      |
            | peek                     | Decodes and returns the next codepoint without advancing the iterator. |

        <div align="center"><br>
        <img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
        </div>

    - #### 🔥 Utils

        - #### 💠 Codepoint

            | Function               | Description                                                  |
            | ---------------------- | ------------------------------------------------------------ |
            | getLengthOfStartByte   | Returns length of the codepoint depending on the first byte. |
            | getFirstCodepointSlice | Returns the first codepoint slice.                           |
            | getFirstCodepoint      | Returns the first codepoint.                                 |
            | getLastCodepointSlice  | Returns the last codepoint slice.                            |
            | getLastCodepoint       | Returns the last codepoint.                                  |

        - #### ⭐ Grapheme Cluster

            | Function                     | Description                               |
            | ---------------------------- | ----------------------------------------- |
            | getFirstGraphemeClusterSlice | Returns the first grapheme cluster slice. |
            | getLastGraphemeClusterSlice  | Returns the last grapheme cluster slice.  |


        - #### 📍 Position

            | Function          | Description                                                          |
            | ----------------- | -------------------------------------------------------------------- |
            | getRealPosition   | Returns the real position in the array based on the visual position. |
            | getVisualPosition | Returns the visual position in the array based on the real position. |

        - #### 💫 More

            | Function     | Description                                                      |
            | ------------ | ---------------------------------------------------------------- |
            | Utf8Validate | Returns true if the input consists entirely of UTF-8 codepoints. |
            | Utf8Decode   | Decodes a UTF-8 codepoint slice into a codepoint value.          |

<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

- ### 🔗 Related

    - [Chars](./chars)
        > Utility functions for char arrays.

    - [Viewer](./viewer)
        > Immutable fixed-size string type that supports unicode.

    - [String](./string)
        > Managed dynamic-size string type that supports unicode.

    - [Buffer](./buffer)
        > Mutable fixed-size string type that supports unicode.

    - [uString](./ustring)
        > Unmanaged dynamic-size string type that supports unicode.


<div align="center"><br>
<img src="https://raw.githubusercontent.com/maysara-elshewehy/SuperZIG-assets/refs/heads/main/dist/img/md/line.png" alt="line" style="display: block; margin-top:20px;margin-bottom:20px;width:500px;"/>
</div>

<div align="center"><br>
<a href="https://github.com/maysara-elshewehy"> <img src="https://img.shields.io/badge/Made with ❤️ by-Maysara-orange"/> </a>
</div>