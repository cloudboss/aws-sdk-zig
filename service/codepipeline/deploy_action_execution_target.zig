const DeployTargetEvent = @import("deploy_target_event.zig").DeployTargetEvent;

/// The target for the deploy action.
pub const DeployActionExecutionTarget = struct {
    /// The end time for the deploy action.
    end_time: ?i64 = null,

    /// The lifecycle events for the deploy action.
    events: ?[]const DeployTargetEvent = null,

    /// The start time for the deploy action.
    start_time: ?i64 = null,

    /// The status of the deploy action.
    status: ?[]const u8 = null,

    /// The ID of the target for the deploy action.
    target_id: ?[]const u8 = null,

    /// The type of target for the deploy action.
    target_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .end_time = "endTime",
        .events = "events",
        .start_time = "startTime",
        .status = "status",
        .target_id = "targetId",
        .target_type = "targetType",
    };
};
