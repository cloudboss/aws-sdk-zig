const CertificateDetails = @import("certificate_details.zig").CertificateDetails;
const PendingCloudwatchLogsExports = @import("pending_cloudwatch_logs_exports.zig").PendingCloudwatchLogsExports;
const RdsCustomClusterConfiguration = @import("rds_custom_cluster_configuration.zig").RdsCustomClusterConfiguration;

/// This data type is used as a response element in the `ModifyDBCluster`
/// operation and contains changes that will be applied during the next
/// maintenance window.
pub const ClusterPendingModifiedValues = struct {
    /// The allocated storage size in gibibytes (GiB) for all database engines
    /// except Amazon Aurora. For Aurora, `AllocatedStorage` always returns 1,
    /// because Aurora DB cluster storage size isn't fixed, but instead
    /// automatically adjusts as needed.
    allocated_storage: ?i32,

    /// The number of days for which automatic DB snapshots are retained.
    backup_retention_period: ?i32,

    certificate_details: ?CertificateDetails,

    /// The DBClusterIdentifier value for the DB cluster.
    db_cluster_identifier: ?[]const u8,

    /// The database engine version.
    engine_version: ?[]const u8,

    /// Indicates whether mapping of Amazon Web Services Identity and Access
    /// Management (IAM) accounts to database accounts is enabled.
    iam_database_authentication_enabled: ?bool,

    /// The Provisioned IOPS (I/O operations per second) value. This setting is only
    /// for non-Aurora Multi-AZ DB clusters.
    iops: ?i32,

    /// The master credentials for the DB cluster.
    master_user_password: ?[]const u8,

    pending_cloudwatch_logs_exports: ?PendingCloudwatchLogsExports,

    /// Reserved for future use.
    rds_custom_cluster_configuration: ?RdsCustomClusterConfiguration,

    /// The storage type for the DB cluster.
    storage_type: ?[]const u8,
};
