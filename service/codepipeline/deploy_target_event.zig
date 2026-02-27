const DeployTargetEventContext = @import("deploy_target_event_context.zig").DeployTargetEventContext;

/// A lifecycle event for the deploy action.
pub const DeployTargetEvent = struct {
    /// The context for the event for the deploy action.
    context: ?DeployTargetEventContext,

    /// The end time for the event for the deploy action.
    end_time: ?i64,

    /// The name of the event for the deploy action.
    name: ?[]const u8,

    /// The start time for the event for the deploy action.
    start_time: ?i64,

    /// The status of the event for the deploy action.
    status: ?[]const u8,

    pub const json_field_names = .{
        .context = "context",
        .end_time = "endTime",
        .name = "name",
        .start_time = "startTime",
        .status = "status",
    };
};
