/// Time range specified using ISO 8601 format timestamps.
pub const ISO8601TimeRange = struct {
    /// End time in ISO 8601 format in Coordinated Universal Time (UTC).
    ///
    /// Example: `2024-01-15T12:00:00.000Z`
    end_time: i64,

    /// Start time in ISO 8601 format in Coordinated Universal Time (UTC).
    ///
    /// Example: `2026-11-15T10:28:48.000Z`
    start_time: i64,

    pub const json_field_names = .{
        .end_time = "endTime",
        .start_time = "startTime",
    };
};
