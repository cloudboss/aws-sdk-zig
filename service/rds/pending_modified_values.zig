const AdditionalStorageVolume = @import("additional_storage_volume.zig").AdditionalStorageVolume;
const AutomationMode = @import("automation_mode.zig").AutomationMode;
const PendingCloudwatchLogsExports = @import("pending_cloudwatch_logs_exports.zig").PendingCloudwatchLogsExports;
const ProcessorFeature = @import("processor_feature.zig").ProcessorFeature;

/// This data type is used as a response element in the `ModifyDBInstance`
/// operation and contains changes that will be applied during the next
/// maintenance window.
pub const PendingModifiedValues = struct {
    /// The additional storage volume modifications that are pending for the DB
    /// instance.
    additional_storage_volumes: ?[]const AdditionalStorageVolume = null,

    /// The allocated storage size for the DB instance specified in gibibytes (GiB).
    allocated_storage: ?i32 = null,

    /// The automation mode of the RDS Custom DB instance: `full` or `all-paused`.
    /// If `full`, the DB instance automates monitoring and instance recovery. If
    /// `all-paused`, the instance pauses automation for the duration set by
    /// `--resume-full-automation-mode-minutes`.
    automation_mode: ?AutomationMode = null,

    /// The number of days for which automated backups are retained.
    backup_retention_period: ?i32 = null,

    /// The identifier of the CA certificate for the DB instance.
    ///
    /// For more information, see [Using SSL/TLS to encrypt a connection to a DB
    /// instance](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/UsingWithRDS.SSL.html) in the *Amazon RDS User Guide* and [ Using SSL/TLS to encrypt a connection to a DB cluster](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/UsingWithRDS.SSL.html) in the *Amazon Aurora User Guide*.
    ca_certificate_identifier: ?[]const u8 = null,

    /// The name of the compute and memory capacity class for the DB instance.
    db_instance_class: ?[]const u8 = null,

    /// The database identifier for the DB instance.
    db_instance_identifier: ?[]const u8 = null,

    /// The DB subnet group for the DB instance.
    db_subnet_group_name: ?[]const u8 = null,

    /// Indicates whether the DB instance has a dedicated log volume (DLV) enabled.>
    dedicated_log_volume: ?bool = null,

    /// The database engine of the DB instance.
    engine: ?[]const u8 = null,

    /// The database engine version.
    engine_version: ?[]const u8 = null,

    /// Indicates whether mapping of Amazon Web Services Identity and Access
    /// Management (IAM) accounts to database accounts is enabled.
    iam_database_authentication_enabled: ?bool = null,

    /// The Provisioned IOPS value for the DB instance.
    iops: ?i32 = null,

    /// The license model for the DB instance.
    ///
    /// Valid values: `license-included` | `bring-your-own-license` |
    /// `general-public-license`
    license_model: ?[]const u8 = null,

    /// The master credentials for the DB instance.
    master_user_password: ?[]const u8 = null,

    /// Indicates whether the Single-AZ DB instance will change to a Multi-AZ
    /// deployment.
    multi_az: ?bool = null,

    /// Indicates whether the DB instance will change to the multi-tenant
    /// configuration (TRUE) or the single-tenant configuration (FALSE).
    multi_tenant: ?bool = null,

    pending_cloudwatch_logs_exports: ?PendingCloudwatchLogsExports = null,

    /// The port for the DB instance.
    port: ?i32 = null,

    /// The number of CPU cores and the number of threads per core for the DB
    /// instance class of the DB instance.
    processor_features: ?[]const ProcessorFeature = null,

    /// The number of minutes to pause the automation. When the time period ends,
    /// RDS Custom resumes full automation. The minimum value is 60 (default). The
    /// maximum value is 1,440.
    resume_full_automation_mode_time: ?i64 = null,

    /// The storage throughput of the DB instance.
    storage_throughput: ?i32 = null,

    /// The storage type of the DB instance.
    storage_type: ?[]const u8 = null,
};
