/// A time range used to specify when the behavior of an insight or anomaly
/// started.
pub const StartTimeRange = struct {
    /// The start time of the time range.
    from_time: ?i64,

    /// The end time of the time range.
    to_time: ?i64,

    pub const json_field_names = .{
        .from_time = "FromTime",
        .to_time = "ToTime",
    };
};
