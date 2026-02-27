const ScheduleAction = @import("schedule_action.zig").ScheduleAction;

/// List of actions that have been created in the schedule.
pub const BatchScheduleActionCreateResult = struct {
    /// List of actions that have been created in the schedule.
    schedule_actions: []const ScheduleAction,

    pub const json_field_names = .{
        .schedule_actions = "ScheduleActions",
    };
};
