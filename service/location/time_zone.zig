/// Information about a time zone. Includes the name of the time zone and the
/// offset from UTC in seconds.
pub const TimeZone = struct {
    /// The name of the time zone, following the [ IANA time zone
    /// standard](https://www.iana.org/time-zones). For example,
    /// `America/Los_Angeles`.
    name: []const u8,

    /// The time zone's offset, in seconds, from UTC.
    offset: ?i32 = null,

    pub const json_field_names = .{
        .name = "Name",
        .offset = "Offset",
    };
};
