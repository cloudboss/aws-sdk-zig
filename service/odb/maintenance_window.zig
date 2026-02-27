const DayOfWeek = @import("day_of_week.zig").DayOfWeek;
const Month = @import("month.zig").Month;
const PatchingModeType = @import("patching_mode_type.zig").PatchingModeType;
const PreferenceType = @import("preference_type.zig").PreferenceType;

/// The scheduling details for the maintenance window. Patching and system
/// updates take place during the maintenance window.
pub const MaintenanceWindow = struct {
    /// The custom action timeout in minutes for the maintenance window.
    custom_action_timeout_in_mins: ?i32,

    /// The days of the week when maintenance can be performed.
    days_of_week: ?[]const DayOfWeek,

    /// The hours of the day when maintenance can be performed.
    hours_of_day: ?[]const i32,

    /// Indicates whether custom action timeout is enabled for the maintenance
    /// window.
    is_custom_action_timeout_enabled: ?bool,

    /// The lead time in weeks before the maintenance window.
    lead_time_in_weeks: ?i32,

    /// The months when maintenance can be performed.
    months: ?[]const Month,

    /// The patching mode for the maintenance window.
    patching_mode: ?PatchingModeType,

    /// The preference for the maintenance window scheduling.
    preference: ?PreferenceType,

    /// Indicates whether to skip release updates during maintenance.
    skip_ru: ?bool,

    /// The weeks of the month when maintenance can be performed.
    weeks_of_month: ?[]const i32,

    pub const json_field_names = .{
        .custom_action_timeout_in_mins = "customActionTimeoutInMins",
        .days_of_week = "daysOfWeek",
        .hours_of_day = "hoursOfDay",
        .is_custom_action_timeout_enabled = "isCustomActionTimeoutEnabled",
        .lead_time_in_weeks = "leadTimeInWeeks",
        .months = "months",
        .patching_mode = "patchingMode",
        .preference = "preference",
        .skip_ru = "skipRu",
        .weeks_of_month = "weeksOfMonth",
    };
};
