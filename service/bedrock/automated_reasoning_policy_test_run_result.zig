pub const AutomatedReasoningPolicyTestRunResult = enum {
    passed,
    failed,

    pub const json_field_names = .{
        .passed = "PASSED",
        .failed = "FAILED",
    };
};
