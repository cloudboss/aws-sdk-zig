pub const ComplianceStatus = enum {
    passed,
    warning,
    failed,
    not_available,

    pub const json_field_names = .{
        .passed = "PASSED",
        .warning = "WARNING",
        .failed = "FAILED",
        .not_available = "NOT_AVAILABLE",
    };
};
