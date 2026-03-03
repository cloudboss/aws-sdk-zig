const FixedModeScheduleActionStartSettings = @import("fixed_mode_schedule_action_start_settings.zig").FixedModeScheduleActionStartSettings;
const FollowModeScheduleActionStartSettings = @import("follow_mode_schedule_action_start_settings.zig").FollowModeScheduleActionStartSettings;
const ImmediateModeScheduleActionStartSettings = @import("immediate_mode_schedule_action_start_settings.zig").ImmediateModeScheduleActionStartSettings;

/// Settings to specify when an action should occur. Only one of the options
/// must be selected.
pub const ScheduleActionStartSettings = struct {
    /// Option for specifying the start time for an action.
    fixed_mode_schedule_action_start_settings: ?FixedModeScheduleActionStartSettings = null,

    /// Option for specifying an action as relative to another action.
    follow_mode_schedule_action_start_settings: ?FollowModeScheduleActionStartSettings = null,

    /// Option for specifying an action that should be applied immediately.
    immediate_mode_schedule_action_start_settings: ?ImmediateModeScheduleActionStartSettings = null,

    pub const json_field_names = .{
        .fixed_mode_schedule_action_start_settings = "FixedModeScheduleActionStartSettings",
        .follow_mode_schedule_action_start_settings = "FollowModeScheduleActionStartSettings",
        .immediate_mode_schedule_action_start_settings = "ImmediateModeScheduleActionStartSettings",
    };
};
