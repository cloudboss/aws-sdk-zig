const PendingCloudwatchLogsExports = @import("pending_cloudwatch_logs_exports.zig").PendingCloudwatchLogsExports;

/// This data type is used as a response element in the ModifyDBInstance
/// action.
pub const PendingModifiedValues = struct {
    /// Contains the new `AllocatedStorage` size for the DB instance that will be
    /// applied or is currently being applied.
    allocated_storage: ?i32,

    /// Specifies the pending number of days for which automated backups are
    /// retained.
    backup_retention_period: ?i32,

    /// Specifies the identifier of the CA certificate for the DB instance.
    ca_certificate_identifier: ?[]const u8,

    /// Contains the new `DBInstanceClass` for the DB instance that will be applied
    /// or
    /// is currently being applied.
    db_instance_class: ?[]const u8,

    /// Contains the new `DBInstanceIdentifier` for the DB instance that will be
    /// applied or is currently being applied.
    db_instance_identifier: ?[]const u8,

    /// The new DB subnet group for the DB instance.
    db_subnet_group_name: ?[]const u8,

    /// Indicates the database engine version.
    engine_version: ?[]const u8,

    /// Specifies the new Provisioned IOPS value for the DB instance that will be
    /// applied or is
    /// currently being applied.
    iops: ?i32,

    /// Not supported by Neptune.
    license_model: ?[]const u8,

    /// Not supported by Neptune.
    master_user_password: ?[]const u8,

    /// Indicates that the Single-AZ DB instance is to change to a Multi-AZ
    /// deployment.
    multi_az: ?bool,

    /// This `PendingCloudwatchLogsExports` structure specifies
    /// pending changes to which CloudWatch logs are enabled and which are disabled.
    pending_cloudwatch_logs_exports: ?PendingCloudwatchLogsExports,

    /// Specifies the pending port for the DB instance.
    port: ?i32,

    /// Not applicable. In Neptune the storage type is managed at the DB Cluster
    /// level.
    storage_type: ?[]const u8,
};
