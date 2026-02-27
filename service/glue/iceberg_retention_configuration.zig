/// The configuration for an Iceberg snapshot retention optimizer.
pub const IcebergRetentionConfiguration = struct {
    /// If set to false, snapshots are only deleted from table metadata, and the
    /// underlying data and metadata files are not deleted.
    clean_expired_files: ?bool,

    /// The number of Iceberg snapshots to retain within the retention period. If an
    /// input is not provided, the corresponding Iceberg table configuration field
    /// will be used or if not present, the default value 1 will be used.
    number_of_snapshots_to_retain: ?i32,

    /// The interval in hours between retention job runs. This parameter controls
    /// how frequently the retention optimizer will run to clean up expired
    /// snapshots. The value must be between 3 and 168 hours (7 days). If an input
    /// is not provided, the default value 24 will be used.
    run_rate_in_hours: ?i32,

    /// The number of days to retain the Iceberg snapshots. If an input is not
    /// provided, the corresponding Iceberg table configuration field will be used
    /// or if not present, the default value 5 will be used.
    snapshot_retention_period_in_days: ?i32,

    pub const json_field_names = .{
        .clean_expired_files = "cleanExpiredFiles",
        .number_of_snapshots_to_retain = "numberOfSnapshotsToRetain",
        .run_rate_in_hours = "runRateInHours",
        .snapshot_retention_period_in_days = "snapshotRetentionPeriodInDays",
    };
};
