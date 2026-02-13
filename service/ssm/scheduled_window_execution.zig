/// Information about a scheduled execution for a maintenance window.
pub const ScheduledWindowExecution = struct {
    /// The time, in ISO-8601 Extended format, that the maintenance window is
    /// scheduled to be
    /// run.
    execution_time: ?[]const u8,

    /// The name of the maintenance window to be run.
    name: ?[]const u8,

    /// The ID of the maintenance window to be run.
    window_id: ?[]const u8,

    pub const json_field_names = .{
        .execution_time = "ExecutionTime",
        .name = "Name",
        .window_id = "WindowId",
    };
};
