pub const AutomatedReasoningPolicyAnnotationStatus = enum {
    applied,
    failed,

    pub const json_field_names = .{
        .applied = "APPLIED",
        .failed = "FAILED",
    };
};
