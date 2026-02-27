/// Specifies the time, in UTC format, when the service takes a daily automated
/// snapshot of the specified Elasticsearch domain. Default value is `0` hours.
pub const SnapshotOptions = struct {
    /// Specifies the time, in UTC format, when the service takes a daily automated
    /// snapshot of the specified Elasticsearch domain. Default value is `0` hours.
    automated_snapshot_start_hour: ?i32,

    pub const json_field_names = .{
        .automated_snapshot_start_hour = "AutomatedSnapshotStartHour",
    };
};
