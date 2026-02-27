/// The time, in UTC format, when OpenSearch Service takes a daily automated
/// snapshot of
/// the specified domain. Default is `0` hours.
pub const SnapshotOptions = struct {
    /// The time, in UTC format, when OpenSearch Service takes a daily automated
    /// snapshot of
    /// the specified domain. Default is `0` hours.
    automated_snapshot_start_hour: ?i32,

    pub const json_field_names = .{
        .automated_snapshot_start_hour = "AutomatedSnapshotStartHour",
    };
};
