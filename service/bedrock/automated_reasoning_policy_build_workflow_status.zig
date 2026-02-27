pub const AutomatedReasoningPolicyBuildWorkflowStatus = enum {
    scheduled,
    cancel_requested,
    preprocessing,
    building,
    testing,
    completed,
    failed,
    cancelled,

    pub const json_field_names = .{
        .scheduled = "SCHEDULED",
        .cancel_requested = "CANCEL_REQUESTED",
        .preprocessing = "PREPROCESSING",
        .building = "BUILDING",
        .testing = "TESTING",
        .completed = "COMPLETED",
        .failed = "FAILED",
        .cancelled = "CANCELLED",
    };
};
