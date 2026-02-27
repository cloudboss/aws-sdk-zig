/// Describes updates to whether snapshots are enabled for a Managed Service for
/// Apache Flink application.
pub const ApplicationSnapshotConfigurationUpdate = struct {
    /// Describes updates to whether snapshots are enabled for an application.
    snapshots_enabled_update: bool,

    pub const json_field_names = .{
        .snapshots_enabled_update = "SnapshotsEnabledUpdate",
    };
};
