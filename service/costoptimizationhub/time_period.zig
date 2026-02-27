/// Specifies a date range for retrieving efficiency metrics. The start date is
/// inclusive and the end date is exclusive.
pub const TimePeriod = struct {
    /// The end of the time period (exclusive). Specify the date in ISO 8601 format,
    /// such as 2024-12-31.
    end: []const u8,

    /// The beginning of the time period (inclusive). Specify the date in ISO 8601
    /// format, such as 2024-01-01.
    start: []const u8,

    pub const json_field_names = .{
        .end = "end",
        .start = "start",
    };
};
