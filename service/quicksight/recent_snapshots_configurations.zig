/// The recent snapshots configuration for an embedded Quick Sight dashboard.
pub const RecentSnapshotsConfigurations = struct {
    /// The recent snapshots configuration for an embedded Quick Sight dashboard.
    enabled: bool = false,

    pub const json_field_names = .{
        .enabled = "Enabled",
    };
};
