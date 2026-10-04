/// Specifies the automated snapshot pause request options for the domain.
///
/// Suspending snapshots reduces data protection. You cannot restore your domain
/// to
/// points in time when snapshots are suspended. Use this feature only for
/// short-term
/// operational needs such as migrations or maintenance windows.
///
/// Maximum suspension duration: 3 days.
pub const AutomatedSnapshotPauseRequestOptions = struct {
    /// Whether to enable or disable automated snapshot pause for the domain.
    enabled: bool,

    /// The timestamp at which the automated snapshot pause should end. The maximum
    /// allowed
    /// duration between `StartTime` and `EndTime` is 3 days.
    end_time: ?i64 = null,

    /// The timestamp at which the automated snapshot pause should begin.
    start_time: ?i64 = null,

    pub const json_field_names = .{
        .enabled = "Enabled",
        .end_time = "EndTime",
        .start_time = "StartTime",
    };
};
