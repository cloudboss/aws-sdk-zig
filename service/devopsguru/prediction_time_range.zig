/// The time range during which anomalous behavior in a proactive anomaly or an
/// insight
/// is expected to occur.
pub const PredictionTimeRange = struct {
    /// The time when the behavior in a proactive insight is expected to end.
    end_time: ?i64,

    /// The time range during which a metric limit is expected to be exceeded. This
    /// applies
    /// to proactive insights only.
    start_time: i64,

    pub const json_field_names = .{
        .end_time = "EndTime",
        .start_time = "StartTime",
    };
};
