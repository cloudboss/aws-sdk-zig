/// The time zone in which the place is located.
pub const TimeZone = struct {
    /// The time zone name.
    name: []const u8,

    /// Time zone offset of the timezone from UTC.
    offset: ?[]const u8 = null,

    /// The offset of the time zone from UTC, in seconds.
    offset_seconds: i64 = 0,

    pub const json_field_names = .{
        .name = "Name",
        .offset = "Offset",
        .offset_seconds = "OffsetSeconds",
    };
};
