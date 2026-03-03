const LifecycleExecutionStatus = @import("lifecycle_execution_status.zig").LifecycleExecutionStatus;

/// The current state of the runtime instance of the lifecycle policy.
pub const LifecycleExecutionState = struct {
    /// The reason for the current status.
    reason: ?[]const u8 = null,

    /// The runtime status of the lifecycle execution.
    status: ?LifecycleExecutionStatus = null,

    pub const json_field_names = .{
        .reason = "reason",
        .status = "status",
    };
};
