/// Represents entity counters.
pub const Counters = struct {
    /// The number of errored entities.
    errored: ?i32 = null,

    /// The number of failed entities.
    failed: ?i32 = null,

    /// The number of passed entities.
    passed: ?i32 = null,

    /// The number of skipped entities.
    skipped: ?i32 = null,

    /// The number of stopped entities.
    stopped: ?i32 = null,

    /// The total number of entities.
    total: ?i32 = null,

    /// The number of warned entities.
    warned: ?i32 = null,

    pub const json_field_names = .{
        .errored = "errored",
        .failed = "failed",
        .passed = "passed",
        .skipped = "skipped",
        .stopped = "stopped",
        .total = "total",
        .warned = "warned",
    };
};
