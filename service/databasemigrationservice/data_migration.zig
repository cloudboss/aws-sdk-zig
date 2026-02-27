const DataMigrationSettings = @import("data_migration_settings.zig").DataMigrationSettings;
const DataMigrationStatistics = @import("data_migration_statistics.zig").DataMigrationStatistics;
const MigrationTypeValue = @import("migration_type_value.zig").MigrationTypeValue;
const SourceDataSetting = @import("source_data_setting.zig").SourceDataSetting;
const TargetDataSetting = @import("target_data_setting.zig").TargetDataSetting;

/// This object provides information about a DMS data migration.
pub const DataMigration = struct {
    /// The Amazon Resource Name (ARN) that identifies this replication.
    data_migration_arn: ?[]const u8,

    /// The CIDR blocks of the endpoints for the data migration.
    data_migration_cidr_blocks: ?[]const []const u8,

    /// The UTC time when DMS created the data migration.
    data_migration_create_time: ?i64,

    /// The UTC time when data migration ended.
    data_migration_end_time: ?i64,

    /// The user-friendly name for the data migration.
    data_migration_name: ?[]const u8,

    /// Specifies CloudWatch settings and selection rules for the data migration.
    data_migration_settings: ?DataMigrationSettings,

    /// The UTC time when DMS started the data migration.
    data_migration_start_time: ?i64,

    /// Provides information about the data migration's run, including start and
    /// stop time,
    /// latency, and data migration progress.
    data_migration_statistics: ?DataMigrationStatistics,

    /// The current status of the data migration.
    data_migration_status: ?[]const u8,

    /// Specifies whether the data migration is full-load only, change data capture
    /// (CDC) only,
    /// or full-load and CDC.
    data_migration_type: ?MigrationTypeValue,

    /// Information about the data migration's most recent error or failure.
    last_failure_message: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the data migration's associated migration
    /// project.
    migration_project_arn: ?[]const u8,

    /// The IP addresses of the endpoints for the data migration.
    public_ip_addresses: ?[]const []const u8,

    /// The IAM role that the data migration uses to access Amazon Web Services
    /// resources.
    service_access_role_arn: ?[]const u8,

    /// Specifies information about the data migration's source data provider.
    source_data_settings: ?[]const SourceDataSetting,

    /// The reason the data migration last stopped.
    stop_reason: ?[]const u8,

    /// Specifies information about the data migration's target data provider.
    target_data_settings: ?[]const TargetDataSetting,

    pub const json_field_names = .{
        .data_migration_arn = "DataMigrationArn",
        .data_migration_cidr_blocks = "DataMigrationCidrBlocks",
        .data_migration_create_time = "DataMigrationCreateTime",
        .data_migration_end_time = "DataMigrationEndTime",
        .data_migration_name = "DataMigrationName",
        .data_migration_settings = "DataMigrationSettings",
        .data_migration_start_time = "DataMigrationStartTime",
        .data_migration_statistics = "DataMigrationStatistics",
        .data_migration_status = "DataMigrationStatus",
        .data_migration_type = "DataMigrationType",
        .last_failure_message = "LastFailureMessage",
        .migration_project_arn = "MigrationProjectArn",
        .public_ip_addresses = "PublicIpAddresses",
        .service_access_role_arn = "ServiceAccessRoleArn",
        .source_data_settings = "SourceDataSettings",
        .stop_reason = "StopReason",
        .target_data_settings = "TargetDataSettings",
    };
};
