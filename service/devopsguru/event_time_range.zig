/// The time range during which an Amazon Web Services event occurred. Amazon
/// Web Services resource events and
/// metrics are analyzed by DevOps Guru to find anomalous behavior and provide
/// recommendations to
/// improve your operational solutions.
pub const EventTimeRange = struct {
    /// The time when the event started.
    from_time: i64,

    /// The time when the event ended.
    to_time: i64,

    pub const json_field_names = .{
        .from_time = "FromTime",
        .to_time = "ToTime",
    };
};
