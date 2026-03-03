const LaunchAction = @import("launch_action.zig").LaunchAction;
const LaunchActionRunStatus = @import("launch_action_run_status.zig").LaunchActionRunStatus;

/// Launch action run.
pub const LaunchActionRun = struct {
    /// Action.
    action: ?LaunchAction = null,

    /// Failure reason.
    failure_reason: ?[]const u8 = null,

    /// Run Id.
    run_id: ?[]const u8 = null,

    /// Run status.
    status: ?LaunchActionRunStatus = null,

    pub const json_field_names = .{
        .action = "action",
        .failure_reason = "failureReason",
        .run_id = "runId",
        .status = "status",
    };
};
