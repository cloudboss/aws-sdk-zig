const Tag = @import("tag.zig").Tag;

/// Contains the details for an Amazon RDS DB cluster snapshot
///
/// This data type is used as a response element in the
/// `DescribeDBClusterSnapshots` action.
pub const DBClusterSnapshot = struct {
    /// The allocated storage size of the DB cluster snapshot in gibibytes (GiB).
    allocated_storage: ?i32 = null,

    /// The list of Availability Zones (AZs) where instances in the DB cluster
    /// snapshot can be restored.
    availability_zones: ?[]const []const u8 = null,

    /// The time when the DB cluster was created, in Universal Coordinated Time
    /// (UTC).
    cluster_create_time: ?i64 = null,

    /// The DB cluster identifier of the DB cluster that this DB cluster snapshot
    /// was created from.
    db_cluster_identifier: ?[]const u8 = null,

    /// The resource ID of the DB cluster that this DB cluster snapshot was created
    /// from.
    db_cluster_resource_id: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the DB cluster snapshot.
    db_cluster_snapshot_arn: ?[]const u8 = null,

    /// The identifier for the DB cluster snapshot.
    db_cluster_snapshot_identifier: ?[]const u8 = null,

    /// Reserved for future use.
    db_system_id: ?[]const u8 = null,

    /// The name of the database engine for this DB cluster snapshot.
    engine: ?[]const u8 = null,

    /// The engine mode of the database engine for this DB cluster snapshot.
    engine_mode: ?[]const u8 = null,

    /// The version of the database engine for this DB cluster snapshot.
    engine_version: ?[]const u8 = null,

    /// Indicates whether mapping of Amazon Web Services Identity and Access
    /// Management (IAM) accounts to database accounts is enabled.
    iam_database_authentication_enabled: ?bool = null,

    /// If `StorageEncrypted` is true, the Amazon Web Services KMS key identifier
    /// for the encrypted DB cluster snapshot.
    ///
    /// The Amazon Web Services KMS key identifier is the key ARN, key ID, alias
    /// ARN, or alias name for the KMS key.
    kms_key_id: ?[]const u8 = null,

    /// The license model information for this DB cluster snapshot.
    license_model: ?[]const u8 = null,

    /// The master username for this DB cluster snapshot.
    master_username: ?[]const u8 = null,

    /// The percentage of the estimated data that has been transferred.
    percent_progress: ?i32 = null,

    /// The port that the DB cluster was listening on at the time of the snapshot.
    port: ?i32 = null,

    /// The time when the snapshot was taken, in Universal Coordinated Time (UTC).
    snapshot_create_time: ?i64 = null,

    /// The type of the DB cluster snapshot.
    snapshot_type: ?[]const u8 = null,

    /// If the DB cluster snapshot was copied from a source DB cluster snapshot, the
    /// Amazon Resource Name (ARN) for the source DB cluster snapshot, otherwise, a
    /// null value.
    source_db_cluster_snapshot_arn: ?[]const u8 = null,

    /// The status of this DB cluster snapshot. Valid statuses are the following:
    ///
    /// * `available`
    /// * `copying`
    /// * `creating`
    status: ?[]const u8 = null,

    /// Indicates whether the DB cluster snapshot is encrypted.
    storage_encrypted: ?bool = null,

    /// The storage throughput for the DB cluster snapshot. The throughput is
    /// automatically set based on the IOPS that you provision, and is not
    /// configurable.
    ///
    /// This setting is only for non-Aurora Multi-AZ DB clusters.
    storage_throughput: ?i32 = null,

    /// The storage type associated with the DB cluster snapshot.
    ///
    /// This setting is only for Aurora DB clusters.
    storage_type: ?[]const u8 = null,

    tag_list: ?[]const Tag = null,

    /// The VPC ID associated with the DB cluster snapshot.
    vpc_id: ?[]const u8 = null,
};
