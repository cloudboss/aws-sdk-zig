const LifecycleExecutionResourceStatus = @import("lifecycle_execution_resource_status.zig").LifecycleExecutionResourceStatus;

/// Contains the state of an impacted resource that the runtime instance
/// of the lifecycle policy identified for action.
pub const LifecycleExecutionResourceState = struct {
    /// Messaging that clarifies the reason for the assigned status.
    reason: ?[]const u8 = null,

    /// The runtime status of the lifecycle action taken for the
    /// impacted resource.
    status: ?LifecycleExecutionResourceStatus = null,

    pub const json_field_names = .{
        .reason = "reason",
        .status = "status",
    };
};
