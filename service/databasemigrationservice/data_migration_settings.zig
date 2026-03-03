/// Options for configuring a data migration, including whether to enable
/// CloudWatch logs,
/// and the selection rules to use to include or exclude database objects from
/// the
/// migration.
pub const DataMigrationSettings = struct {
    /// Whether to enable CloudWatch logging for the data migration.
    cloudwatch_logs_enabled: ?bool = null,

    /// The number of parallel jobs that trigger parallel threads to unload the
    /// tables from the
    /// source, and then load them to the target.
    number_of_jobs: ?i32 = null,

    /// A JSON-formatted string that defines what objects to include and exclude
    /// from the
    /// migration.
    selection_rules: ?[]const u8 = null,

    pub const json_field_names = .{
        .cloudwatch_logs_enabled = "CloudwatchLogsEnabled",
        .number_of_jobs = "NumberOfJobs",
        .selection_rules = "SelectionRules",
    };
};
