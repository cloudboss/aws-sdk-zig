/// The status counts.
pub const StatusCounts = struct {
    /// The number of checks that failed.
    failed: ?i32,

    /// The number of checks that passed.
    passed: ?i32,

    /// The number of checks that were skipped.
    skipped: ?i32,

    pub const json_field_names = .{
        .failed = "failed",
        .passed = "passed",
        .skipped = "skipped",
    };
};
