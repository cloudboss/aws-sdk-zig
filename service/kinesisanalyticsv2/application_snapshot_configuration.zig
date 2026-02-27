/// Describes whether snapshots are enabled for a Managed Service for Apache
/// Flink application.
pub const ApplicationSnapshotConfiguration = struct {
    /// Describes whether snapshots are enabled for a Managed Service for Apache
    /// Flink application.
    snapshots_enabled: bool,

    pub const json_field_names = .{
        .snapshots_enabled = "SnapshotsEnabled",
    };
};
