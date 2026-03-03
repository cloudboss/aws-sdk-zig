const LifecycleExecutionResourceActionName = @import("lifecycle_execution_resource_action_name.zig").LifecycleExecutionResourceActionName;

/// The lifecycle policy action that was identified for the impacted resource.
pub const LifecycleExecutionResourceAction = struct {
    /// The name of the resource that was identified for a lifecycle policy action.
    name: ?LifecycleExecutionResourceActionName = null,

    /// The reason why the lifecycle policy action is taken.
    reason: ?[]const u8 = null,

    pub const json_field_names = .{
        .name = "name",
        .reason = "reason",
    };
};
