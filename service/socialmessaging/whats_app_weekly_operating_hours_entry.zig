const WhatsAppTimeOfDay = @import("whats_app_time_of_day.zig").WhatsAppTimeOfDay;
const WhatsAppDayOfWeek = @import("whats_app_day_of_week.zig").WhatsAppDayOfWeek;

/// A single entry in a weekly calling schedule, defining the open and close
/// times for one day of the week.
pub const WhatsAppWeeklyOperatingHoursEntry = struct {
    /// The time of day when the business stops accepting calls.
    close_time: WhatsAppTimeOfDay,

    /// The day of the week that the entry applies to.
    day_of_week: WhatsAppDayOfWeek,

    /// The time of day when the business begins accepting calls.
    open_time: WhatsAppTimeOfDay,

    pub const json_field_names = .{
        .close_time = "closeTime",
        .day_of_week = "dayOfWeek",
        .open_time = "openTime",
    };
};
