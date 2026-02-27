const ScheduleAction = @import("schedule_action.zig").ScheduleAction;

/// List of actions that have been deleted from the schedule.
pub const BatchScheduleActionDeleteResult = struct {
    /// List of actions that have been deleted from the schedule.
    schedule_actions: []const ScheduleAction,

    pub const json_field_names = .{
        .schedule_actions = "ScheduleActions",
    };
};
