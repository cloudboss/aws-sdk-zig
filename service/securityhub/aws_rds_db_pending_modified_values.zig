const AwsRdsPendingCloudWatchLogsExports = @import("aws_rds_pending_cloud_watch_logs_exports.zig").AwsRdsPendingCloudWatchLogsExports;
const AwsRdsDbProcessorFeature = @import("aws_rds_db_processor_feature.zig").AwsRdsDbProcessorFeature;

/// Changes to a DB instance that are currently pending.
pub const AwsRdsDbPendingModifiedValues = struct {
    /// The new value of the allocated storage for the DB instance.
    allocated_storage: ?i32,

    /// The new backup retention period for the DB instance.
    backup_retention_period: ?i32,

    /// The new CA certificate identifier for the DB instance.
    ca_certificate_identifier: ?[]const u8,

    /// The new DB instance class for the DB instance.
    db_instance_class: ?[]const u8,

    /// The new DB instance identifier for the DB instance.
    db_instance_identifier: ?[]const u8,

    /// The name of the new subnet group for the DB instance.
    db_subnet_group_name: ?[]const u8,

    /// The new engine version for the DB instance.
    engine_version: ?[]const u8,

    /// The new provisioned IOPS value for the DB instance.
    iops: ?i32,

    /// The new license model value for the DB instance.
    license_model: ?[]const u8,

    /// The new master user password for the DB instance.
    master_user_password: ?[]const u8,

    /// Indicates that a single Availability Zone DB instance is changing to a
    /// multiple Availability Zone deployment.
    multi_az: ?bool,

    /// A list of log types that are being enabled or disabled.
    pending_cloud_watch_logs_exports: ?AwsRdsPendingCloudWatchLogsExports,

    /// The new port for the DB instance.
    port: ?i32,

    /// Processor features that are being updated.
    processor_features: ?[]const AwsRdsDbProcessorFeature,

    /// The new storage type for the DB instance.
    storage_type: ?[]const u8,

    pub const json_field_names = .{
        .allocated_storage = "AllocatedStorage",
        .backup_retention_period = "BackupRetentionPeriod",
        .ca_certificate_identifier = "CaCertificateIdentifier",
        .db_instance_class = "DbInstanceClass",
        .db_instance_identifier = "DbInstanceIdentifier",
        .db_subnet_group_name = "DbSubnetGroupName",
        .engine_version = "EngineVersion",
        .iops = "Iops",
        .license_model = "LicenseModel",
        .master_user_password = "MasterUserPassword",
        .multi_az = "MultiAZ",
        .pending_cloud_watch_logs_exports = "PendingCloudWatchLogsExports",
        .port = "Port",
        .processor_features = "ProcessorFeatures",
        .storage_type = "StorageType",
    };
};
