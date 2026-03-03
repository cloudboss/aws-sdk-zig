/// You can configure Amazon Redshift to copy snapshots for a cluster to another
/// Amazon Web Services Region. This parameter
/// provides information about a cross-Region snapshot copy.
pub const AwsRedshiftClusterClusterSnapshotCopyStatus = struct {
    /// The destination Region that snapshots are automatically copied to when
    /// cross-Region
    /// snapshot copy is enabled.
    destination_region: ?[]const u8 = null,

    /// The number of days that manual snapshots are retained in the destination
    /// Region after
    /// they are copied from a source Region.
    ///
    /// If the value is `-1`,
    /// then the manual snapshot is retained indefinitely.
    ///
    /// Valid values: Either `-1`
    /// or an integer between 1 and 3,653
    manual_snapshot_retention_period: ?i32 = null,

    /// The number of days to retain automated snapshots in the destination Region
    /// after they
    /// are copied from a source Region.
    retention_period: ?i32 = null,

    /// The name of the snapshot copy grant.
    snapshot_copy_grant_name: ?[]const u8 = null,

    pub const json_field_names = .{
        .destination_region = "DestinationRegion",
        .manual_snapshot_retention_period = "ManualSnapshotRetentionPeriod",
        .retention_period = "RetentionPeriod",
        .snapshot_copy_grant_name = "SnapshotCopyGrantName",
    };
};
