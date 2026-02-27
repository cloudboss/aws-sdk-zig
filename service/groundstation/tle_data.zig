const TimeRange = @import("time_range.zig").TimeRange;

/// Two-line element set (TLE) data.
pub const TLEData = struct {
    /// First line of two-line element set (TLE) data.
    tle_line_1: []const u8,

    /// Second line of two-line element set (TLE) data.
    tle_line_2: []const u8,

    /// The valid time range for the TLE. Time ranges must be continuous without
    /// gaps or overlaps.
    valid_time_range: TimeRange,

    pub const json_field_names = .{
        .tle_line_1 = "tleLine1",
        .tle_line_2 = "tleLine2",
        .valid_time_range = "validTimeRange",
    };
};
