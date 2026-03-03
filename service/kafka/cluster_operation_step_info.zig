/// State information about the operation step.
pub const ClusterOperationStepInfo = struct {
    /// The steps current status.
    step_status: ?[]const u8 = null,

    pub const json_field_names = .{
        .step_status = "StepStatus",
    };
};
