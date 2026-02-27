const ScheduleAction = @import("schedule_action.zig").ScheduleAction;

/// A list of schedule actions to create (in a request) or that have been
/// created (in a response).
pub const BatchScheduleActionCreateRequest = struct {
    /// A list of schedule actions to create.
    schedule_actions: []const ScheduleAction,

    pub const json_field_names = .{
        .schedule_actions = "ScheduleActions",
    };
};
