/// A range of time that specifies when anomalous behavior in an anomaly or
/// insight
/// ended.
pub const EndTimeRange = struct {
    /// The earliest end time in the time range.
    from_time: ?i64,

    /// The latest end time in the time range.
    to_time: ?i64,

    pub const json_field_names = .{
        .from_time = "FromTime",
        .to_time = "ToTime",
    };
};
