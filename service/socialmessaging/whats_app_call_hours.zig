const WhatsAppHolidayScheduleEntry = @import("whats_app_holiday_schedule_entry.zig").WhatsAppHolidayScheduleEntry;
const WhatsAppWeeklyOperatingHoursEntry = @import("whats_app_weekly_operating_hours_entry.zig").WhatsAppWeeklyOperatingHoursEntry;

/// The operating hours during which a business phone number accepts WhatsApp
/// calls, including the time zone, weekly schedule, and any holiday overrides.
pub const WhatsAppCallHours = struct {
    /// Specifies whether call hours are enforced. When disabled, the business
    /// accepts calls at any time.
    enabled: bool,

    /// Date-specific overrides to the weekly operating hours, such as holidays.
    holiday_schedule: ?[]const WhatsAppHolidayScheduleEntry = null,

    /// The IANA time zone in which the operating hours are interpreted, such as
    /// `America/New_York`.
    timezone: []const u8,

    /// The weekly schedule of hours during which the business accepts calls.
    weekly_operating_hours: []const WhatsAppWeeklyOperatingHoursEntry,

    pub const json_field_names = .{
        .enabled = "enabled",
        .holiday_schedule = "holidaySchedule",
        .timezone = "timezone",
        .weekly_operating_hours = "weeklyOperatingHours",
    };
};
