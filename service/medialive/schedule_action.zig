const ScheduleActionSettings = @import("schedule_action_settings.zig").ScheduleActionSettings;
const ScheduleActionStartSettings = @import("schedule_action_start_settings.zig").ScheduleActionStartSettings;

/// Contains information on a single schedule action.
pub const ScheduleAction = struct {
    /// The name of the action, must be unique within the schedule. This name
    /// provides the main reference to an action once it is added to the schedule. A
    /// name is unique if it is no longer in the schedule. The schedule is
    /// automatically cleaned up to remove actions with a start time of more than 1
    /// hour ago (approximately) so at that point a name can be reused.
    action_name: []const u8,

    /// Settings for this schedule action.
    schedule_action_settings: ScheduleActionSettings,

    /// The time for the action to start in the channel.
    schedule_action_start_settings: ScheduleActionStartSettings,

    pub const json_field_names = .{
        .action_name = "ActionName",
        .schedule_action_settings = "ScheduleActionSettings",
        .schedule_action_start_settings = "ScheduleActionStartSettings",
    };
};
