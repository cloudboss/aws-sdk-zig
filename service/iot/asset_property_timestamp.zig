/// An asset property timestamp entry containing the following information.
pub const AssetPropertyTimestamp = struct {
    /// Optional. A string that contains the nanosecond time offset. Accepts
    /// substitution
    /// templates.
    offset_in_nanos: ?[]const u8 = null,

    /// A string that contains the time in seconds since epoch. Accepts substitution
    /// templates.
    time_in_seconds: []const u8,

    pub const json_field_names = .{
        .offset_in_nanos = "offsetInNanos",
        .time_in_seconds = "timeInSeconds",
    };
};
