/// Contains the details for an Amazon Neptune DB cluster snapshot
///
/// This data type is used as a response element in the
/// DescribeDBClusterSnapshots action.
pub const DBClusterSnapshot = struct {
    /// Specifies the allocated storage size in gibibytes (GiB).
    allocated_storage: ?i32,

    /// Provides the list of EC2 Availability Zones that instances in the DB cluster
    /// snapshot can
    /// be restored in.
    availability_zones: ?[]const []const u8,

    /// Specifies the time when the DB cluster was created, in Universal Coordinated
    /// Time
    /// (UTC).
    cluster_create_time: ?i64,

    /// Specifies the DB cluster identifier of the DB cluster that this DB cluster
    /// snapshot was
    /// created from.
    db_cluster_identifier: ?[]const u8,

    /// The Amazon Resource Name (ARN) for the DB cluster snapshot.
    db_cluster_snapshot_arn: ?[]const u8,

    /// Specifies the identifier for a DB cluster snapshot. Must match the
    /// identifier
    /// of an existing snapshot.
    ///
    /// After you restore a DB cluster using a `DBClusterSnapshotIdentifier`,
    /// you must specify the same `DBClusterSnapshotIdentifier` for any future
    /// updates to the DB cluster. When you specify this property for an update, the
    /// DB
    /// cluster is not restored from the snapshot again, and the data in the
    /// database is not
    /// changed.
    ///
    /// However, if you don't specify the `DBClusterSnapshotIdentifier`, an empty
    /// DB cluster is created, and the original DB cluster is deleted. If you
    /// specify a
    /// property that is different from the previous snapshot restore property, the
    /// DB
    /// cluster is restored from the snapshot specified by the
    /// `DBClusterSnapshotIdentifier`,
    /// and the original DB cluster is deleted.
    db_cluster_snapshot_identifier: ?[]const u8,

    /// Specifies the name of the database engine.
    engine: ?[]const u8,

    /// Provides the version of the database engine for this DB cluster snapshot.
    engine_version: ?[]const u8,

    /// True if mapping of Amazon Identity and Access Management (IAM) accounts to
    /// database accounts
    /// is enabled, and otherwise false.
    iam_database_authentication_enabled: ?bool,

    /// If `StorageEncrypted` is true, the Amazon KMS key identifier for the
    /// encrypted DB
    /// cluster snapshot.
    kms_key_id: ?[]const u8,

    /// Provides the license model information for this DB cluster snapshot.
    license_model: ?[]const u8,

    /// Not supported by Neptune.
    master_username: ?[]const u8,

    /// Specifies the percentage of the estimated data that has been transferred.
    percent_progress: ?i32,

    /// Specifies the port that the DB cluster was listening on at the time of the
    /// snapshot.
    port: ?i32,

    /// Provides the time when the snapshot was taken, in Universal Coordinated Time
    /// (UTC).
    snapshot_create_time: ?i64,

    /// Provides the type of the DB cluster snapshot.
    snapshot_type: ?[]const u8,

    /// If the DB cluster snapshot was copied from a source DB cluster snapshot, the
    /// Amazon
    /// Resource Name (ARN) for the source DB cluster snapshot, otherwise, a null
    /// value.
    source_db_cluster_snapshot_arn: ?[]const u8,

    /// Specifies the status of this DB cluster snapshot.
    status: ?[]const u8,

    /// Specifies whether the DB cluster snapshot is encrypted.
    storage_encrypted: ?bool,

    /// The storage type associated with the DB cluster snapshot.
    storage_type: ?[]const u8,

    /// Provides the VPC ID associated with the DB cluster snapshot.
    vpc_id: ?[]const u8,
};
