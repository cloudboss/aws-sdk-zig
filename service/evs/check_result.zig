pub const CheckResult = enum {
    passed,
    failed,
    unknown,

    pub const json_field_names = .{
        .passed = "PASSED",
        .failed = "FAILED",
        .unknown = "UNKNOWN",
    };
};
