/// A time ranged that specifies when the observed behavior in an insight
/// started and
/// ended.
pub const InsightTimeRange = struct {
    /// The time when the behavior described in an insight ended.
    end_time: ?i64 = null,

    /// The time when the behavior described in an insight started.
    start_time: i64,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .start_time = "StartTime",
    };
};
