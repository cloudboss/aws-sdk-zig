const PendingCloudwatchLogsExports = @import("pending_cloudwatch_logs_exports.zig").PendingCloudwatchLogsExports;

/// This data type is used as a response element in the `ModifyDBCluster`
/// operation and
/// contains changes that will be applied during the next maintenance window.
pub const ClusterPendingModifiedValues = struct {
    /// The allocated storage size in gibibytes (GiB) for database engines. For
    /// Neptune,
    /// `AllocatedStorage` always returns 1, because Neptune DB cluster storage size
    /// isn't fixed, but
    /// instead automatically adjusts as needed.
    allocated_storage: ?i32,

    /// The number of days for which automatic DB snapshots are retained.
    backup_retention_period: ?i32,

    /// The DBClusterIdentifier value for the DB cluster.
    db_cluster_identifier: ?[]const u8,

    /// The database engine version.
    engine_version: ?[]const u8,

    /// A value that indicates whether mapping of Amazon Web Services Identity and
    /// Access Management (IAM) accounts to database accounts is enabled.
    iam_database_authentication_enabled: ?bool,

    /// The Provisioned IOPS (I/O operations per second) value. This setting is only
    /// for Multi-AZ DB clusters.
    iops: ?i32,

    /// This `PendingCloudwatchLogsExports` structure specifies
    /// pending changes to which CloudWatch logs are enabled and which are disabled.
    pending_cloudwatch_logs_exports: ?PendingCloudwatchLogsExports,

    /// The pending change in storage type for the DB cluster.   Valid Values:
    ///
    /// * **
    /// `standard`
    /// **   –
    /// ( *the default* ) Configures cost-effective database storage for
    /// applications
    /// with moderate to small I/O usage.
    ///
    /// * **
    /// `iopt1`
    /// **   –
    /// Enables [I/O-Optimized
    /// storage](https://docs.aws.amazon.com/neptune/latest/userguide/storage-types.html#provisioned-iops-storage)
    /// that's designed to meet the needs of I/O-intensive graph workloads that
    /// require predictable pricing with low I/O latency and consistent I/O
    /// throughput.
    ///
    /// Neptune I/O-Optimized storage is only available starting with engine release
    /// 1.3.0.0.
    storage_type: ?[]const u8,
};
