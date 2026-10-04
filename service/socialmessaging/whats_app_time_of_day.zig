/// A time of day, expressed as an hour and minute.
pub const WhatsAppTimeOfDay = struct {
    /// The hour of the day, from 0 to 23.
    hours: i32,

    /// The minute of the hour, from 0 to 59.
    minutes: i32,

    pub const json_field_names = .{
        .hours = "hours",
        .minutes = "minutes",
    };
};
