/// Specifies the start and end time for OpenHours.
pub const OpenHoursRule = struct {
    /// The end of the scheduled time, in ISO 8601 format, when the channel can't
    /// send messages.
    end_time: ?[]const u8,

    /// The start of the scheduled time, in ISO 8601 format, when the channel can
    /// send messages.
    start_time: ?[]const u8,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .start_time = "StartTime",
    };
};
