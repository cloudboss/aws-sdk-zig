/// A summary of rule results, providing counts for each status type.
pub const RuleStatusCounts = struct {
    /// The number of rules that failed.
    failed: ?i32,

    /// The number of rules that returned informational results.
    info: ?i32,

    /// The number of rules that passed.
    passed: ?i32,

    /// The number of rules with unknown status.
    unknown: ?i32,

    /// The number of rules that returned warnings.
    warning: ?i32,

    pub const json_field_names = .{
        .failed = "Failed",
        .info = "Info",
        .passed = "Passed",
        .unknown = "Unknown",
        .warning = "Warning",
    };
};
