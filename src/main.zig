// ╔══════════════════════════════════════ INIT ══════════════════════════════════════╗

    /// A unified set of internal data types to facilitate subsequent library creation and maintenance.
    pub const iTypes = @import("./common/types.zig").Types;

    /// A set of useful utilities with associated functions.
    pub const Utils = @import("./Utils/src.zig");

    /// A set of useful data types with their associated functions.
    pub const Types = @import("./Types/src.zig");

// ╚══════════════════════════════════════════════════════════════════════════════════╝



// ╔══════════════════════════════════════ TEST ══════════════════════════════════════╗

    test {
        _ = @import("./Utils/src.zig");
        _ = @import("./Types/src.zig");
    }

// ╚══════════════════════════════════════════════════════════════════════════════════╝