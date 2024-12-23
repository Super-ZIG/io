# [←](../../readme.md) `io`.`types`.`string`

<p align="center">
  <img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/logo/string/logo.png" alt="string" width="1000" />
</p>

<p align="center">
     <a href="https://github.com/Super-ZIG/io/actions/workflows/main.yml">
        <img src="https://github.com/Super-ZIG/io/actions/workflows/main.yml/badge.svg" alt="CI" />
    </a>
    <img src="https://img.shields.io/github/issues/Super-ZIG/io?style=flat" alt="Github Repo Issues" />
    <img src="https://img.shields.io/github/stars/Super-ZIG/io?style=social" alt="GitHub Repo stars" />
</p>

<p align="center">
  <strong>Dynamic string done right.</strong><br />
</p>

<br />

</div>

> A **streamlined** and **powerful** library for **dynamic string** manipulation in **Zig**. It provides **efficient** and **robust** functions for typical operations such as **insertions**, **deletions**, **replacements**, and **searches**, with comprehensive **Unicode** support.

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

- #### Usage

    ```zig
    const string = @import("io").types.string;
    ```

    ```zig
    var str = string.init();        // Creates a new string structure.
    defer str.deinit();             // Cleans up the allocated memory (if allocated) when the scope ends.

    try str.append("Hello 🌍!");    // 👉 "Hello 🌍!"
    str.ubytes();                   // 👉 8     (Unicode characters are counted as regular characters).
    str.bytes();                    // 👉 11    Regular characters = 1, Unicode characters = 4.
    str.size();                     // 👉 24    Total size of the allocated memory `(11+1)*2`.
    str.src();                      // 👉 "Hello 🌍!"
    ```

- ### API

   - #### ☵ Init

        | Method                          | Description                                                  |
        | ------------------------------- | ------------------------------------------------------------ |
        | [`init`](./api/init.md)         | Initialize an empty string.                                  |
        | [`initWith`](./api/initWith.md) | Initialize a string with an allocator and a given substring. |
        | [`deinit`](./api/initWith.md)   | Deallocate the string buffer.                                |
        | [`allocate`](./api/initWith.md) | Allocate or reallocate the string buffer to a new size.      |

   - #### ❱ Basics

        | Method                      | Description                                                                                            |
        | --------------------------- | ------------------------------------------------------------------------------------------------------ |
        | [`bytes`](./api/bytes.md)   | Returns the number of characters in the string.                                                        |
        | [`ubytes`](./api/ubytes.md) | Returns the number of characters in the string (Unicode characters are counted as regular characters). |
        | [`size`](./api/size.md)     | Returns the size of the string.                                                                        |
        | [`src`](./api/src.md)       | Returns the source of the string.                                                                      |

   - #### ➕ Insertion

        | Method                              | Description                                                                                      |
        | ----------------------------------- | ------------------------------------------------------------------------------------------------ |
        | [`append`](./api/append.md)         | Inserts a _(`string` or `char`)_ into the `end` of the string.                                   |
        | [`prepend`](./api/prepend.md)       | Inserts a _(`string` or `char`)_ into the `beg` of the string.                                   |
        | [`insert`](./api/insert.md)         | Inserts a _(`string` or `char`)_ into a `specific position` in the string.                       |
        | [`insertReal`](./api/insertReal.md) | Inserts a _(`string` or `char`)_ into a `specific real  position` in the string. |

   - #### ➖ Deletion

        | Method                              | Description                                                                |
        | ----------------------------------- | -------------------------------------------------------------------------- |
        | [`remove`](./api/remove.md)         | Removes a _(`range` or `position`)_ from the string.                       |
        | [`removeReal`](./api/removeReal.md) | Removes a _(`range` or `real position`)_ from the string. |

   - #### ✍️ Writer

        | Method                                | Description                                                                                     |
        | ------------------------------------- | ----------------------------------------------------------------------------------------------- |
        | [`Writer (Type)`](./api/Writer_t.md)  | The underlying type of the Writer returned by `writer()`.                                       |
        | [`writer`](./api/writer.md)           | Returns a writer for the string.                                                                |
        | [`write`](./api/write.md)             | Writes a _(`formatted string`)_ into the `end` of the string.                                   |
        | [`writeStart`](./api/writeStart.md)   | Writes a _(`formatted string`)_ into the `beg` of the string.                                   |
        | [`writeAt`](./api/writeAt.md)         | Writes a _(`formatted string`)_ into a `specific position` in the string.                       |
        | [`writeAtReal`](./api/writeAtReal.md) | Writes a _(`formatted string`)_ into a `specific real  position` in the string. |

   - #### 🔄 Iterator

        | Method                                   | Description                                                   |
        | ---------------------------------------- | ------------------------------------------------------------- |
        | [`Iterator (Type)`](./api/Iterator_t.md) | The underlying type of the Iterator returned by `iterator()`. |
        | [`iterator`](./api/iterator.md)          | Returns an iterator for the string.                           |

   - #### ⡾ Fields

        | Field     | Description                                        |
        | --------- | -------------------------------------------------- |
        | `m_buff`  | Nullable array of characters to store the content. |
        | `m_alloc` | Allocator used for memory management.              |
        | `m_size`  | Size of the string.                                |
        | `m_bytes` | Length of the string.                              |


    - #### ⠟ Types

        | Type       | Refer To                                                             |
        | ---------- | -------------------------------------------------------------------- |
        | `char`     | [`io.utils.chars.types.char`](../../utils/chars/readme.md#types)     |
        | `str`      | [`io.utils.chars.types.str`](../../utils/chars/readme.md#types)      |
        | `cstr`     | [`io.utils.chars.types.cstr`](../../utils/chars/readme.md#types)     |
        | `unsigned` | [`io.utils.chars.types.unsigned`](../../utils/chars/readme.md#types) |
        | `signed`   | [`io.utils.chars.types.signed`](../../utils/chars/readme.md#types)   |

<div align="center">
<img src="https://raw.githubusercontent.com/Super-ZIG/io/refs/heads/main/docs/dist/img/md/line.png" alt="line" style="width:500px;"/>
</div>

<p align="center" style="color:grey;"><br />Made with ❤️ by <a href="http://github.com/maysara-elshewehy" target="blank">Maysara</a>.</p>