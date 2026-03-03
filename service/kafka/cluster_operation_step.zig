const ClusterOperationStepInfo = @import("cluster_operation_step_info.zig").ClusterOperationStepInfo;

/// Step taken during a cluster operation.
pub const ClusterOperationStep = struct {
    /// Information about the step and its status.
    step_info: ?ClusterOperationStepInfo = null,

    /// The name of the step.
    step_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .step_info = "StepInfo",
        .step_name = "StepName",
    };
};
