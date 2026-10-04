const WhatsAppTimeOfDay = @import("whats_app_time_of_day.zig").WhatsAppTimeOfDay;

/// A date-specific override to the weekly operating hours, such as a holiday.
pub const WhatsAppHolidayScheduleEntry = struct {
    /// The date that the override applies to, in ISO 8601 format (`YYYY-MM-DD`).
    date: []const u8,

    /// The time of day when the business stops accepting calls on the override
    /// date.
    end_time: WhatsAppTimeOfDay,

    /// The time of day when the business begins accepting calls on the override
    /// date.
    start_time: WhatsAppTimeOfDay,

    pub const json_field_names = .{
        .date = "date",
        .end_time = "endTime",
        .start_time = "startTime",
    };
};
