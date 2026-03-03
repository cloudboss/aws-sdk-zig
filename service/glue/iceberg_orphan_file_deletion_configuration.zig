/// The configuration for an Iceberg orphan file deletion optimizer.
pub const IcebergOrphanFileDeletionConfiguration = struct {
    /// Specifies a directory in which to look for files (defaults to the table's
    /// location). You may choose a sub-directory rather than the top-level table
    /// location.
    location: ?[]const u8 = null,

    /// The number of days that orphan files should be retained before file
    /// deletion. If an input is not provided, the default value 3 will be used.
    orphan_file_retention_period_in_days: ?i32 = null,

    /// The interval in hours between orphan file deletion job runs. This parameter
    /// controls how frequently the orphan file deletion optimizer will run to clean
    /// up orphan files. The value must be between 3 and 168 hours (7 days). If an
    /// input is not provided, the default value 24 will be used.
    run_rate_in_hours: ?i32 = null,

    pub const json_field_names = .{
        .location = "location",
        .orphan_file_retention_period_in_days = "orphanFileRetentionPeriodInDays",
        .run_rate_in_hours = "runRateInHours",
    };
};
