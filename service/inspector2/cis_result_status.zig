pub const CisResultStatus = enum {
    passed,
    failed,
    skipped,

    pub const json_field_names = .{
        .passed = "PASSED",
        .failed = "FAILED",
        .skipped = "SKIPPED",
    };
};
