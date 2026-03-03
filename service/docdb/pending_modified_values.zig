const PendingCloudwatchLogsExports = @import("pending_cloudwatch_logs_exports.zig").PendingCloudwatchLogsExports;

/// One or more modified settings for an instance. These modified settings have
/// been
/// requested, but haven't been applied yet.
pub const PendingModifiedValues = struct {
    /// Contains the new `AllocatedStorage` size for then instance that will be
    /// applied or is currently being applied.
    allocated_storage: ?i32 = null,

    /// Specifies the pending number of days for which automated backups are
    /// retained.
    backup_retention_period: ?i32 = null,

    /// Specifies the identifier of the certificate authority (CA) certificate for
    /// the DB
    /// instance.
    ca_certificate_identifier: ?[]const u8 = null,

    /// Contains the new `DBInstanceClass` for the instance that will be
    /// applied or is currently being applied.
    db_instance_class: ?[]const u8 = null,

    /// Contains the new `DBInstanceIdentifier` for the instance that will be
    /// applied or is currently being applied.
    db_instance_identifier: ?[]const u8 = null,

    /// The new subnet group for the instance.
    db_subnet_group_name: ?[]const u8 = null,

    /// Indicates the database engine version.
    engine_version: ?[]const u8 = null,

    /// Specifies the new Provisioned IOPS value for the instance that will be
    /// applied or
    /// is currently being applied.
    iops: ?i32 = null,

    /// The license model for the instance.
    ///
    /// Valid values: `license-included`, `bring-your-own-license`,
    /// `general-public-license`
    license_model: ?[]const u8 = null,

    /// Contains the pending or currently in-progress change of the master
    /// credentials for the
    /// instance.
    master_user_password: ?[]const u8 = null,

    /// Indicates that the Single-AZ instance is to change to a Multi-AZ deployment.
    multi_az: ?bool = null,

    /// A list of the log types whose configuration is still pending. These log
    /// types are in
    /// the process of being activated or deactivated.
    pending_cloudwatch_logs_exports: ?PendingCloudwatchLogsExports = null,

    /// Specifies the pending port for the instance.
    port: ?i32 = null,

    /// Specifies the storage type to be associated with the instance.
    storage_type: ?[]const u8 = null,
};
