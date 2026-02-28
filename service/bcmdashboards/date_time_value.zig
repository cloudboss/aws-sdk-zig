const DateTimeType = @import("date_time_type.zig").DateTimeType;

/// Represents a point in time that can be specified as either an absolute date
/// (for example, "2025-07-01") or a relative time period using ISO 8601
/// duration format (for example, "-P3M" for three months ago).
pub const DateTimeValue = struct {
    /// The type of date/time value: `ABSOLUTE` for specific dates or `RELATIVE` for
    /// dynamic time periods.
    type: DateTimeType,

    /// The actual date/time value.
    value: []const u8,

    pub const json_field_names = .{
        .type = "type",
        .value = "value",
    };
};
