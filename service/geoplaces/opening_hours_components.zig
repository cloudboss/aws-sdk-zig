/// Components of the opening hours object.
pub const OpeningHoursComponents = struct {
    /// String which represents the duration of the opening period, such as
    /// `"PT12H00M"`.
    open_duration: ?[]const u8,

    /// String which represents the opening hours, such as `"T070000"`.
    open_time: ?[]const u8,

    /// Days or periods when the provided opening hours are in affect.
    ///
    /// Example: `FREQ:DAILY;BYDAY:MO,TU,WE,TH,SU`
    recurrence: ?[]const u8,

    pub const json_field_names = .{
        .open_duration = "OpenDuration",
        .open_time = "OpenTime",
        .recurrence = "Recurrence",
    };
};
