pub const CisRuleStatus = enum {
    failed,
    passed,
    not_evaluated,
    informational,
    unknown,
    not_applicable,
    @"error",

    pub const json_field_names = .{
        .failed = "FAILED",
        .passed = "PASSED",
        .not_evaluated = "NOT_EVALUATED",
        .informational = "INFORMATIONAL",
        .unknown = "UNKNOWN",
        .not_applicable = "NOT_APPLICABLE",
        .@"error" = "ERROR",
    };
};
