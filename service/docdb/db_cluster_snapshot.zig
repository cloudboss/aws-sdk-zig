/// Detailed information about a cluster snapshot.
pub const DBClusterSnapshot = struct {
    /// Provides the list of Amazon EC2 Availability Zones that instances in the
    /// cluster
    /// snapshot can be restored in.
    availability_zones: ?[]const []const u8,

    /// Specifies the time when the cluster was created, in Universal Coordinated
    /// Time
    /// (UTC).
    cluster_create_time: ?i64,

    /// Specifies the cluster identifier of the cluster that this cluster snapshot
    /// was created from.
    db_cluster_identifier: ?[]const u8,

    /// The Amazon Resource Name (ARN) for the cluster snapshot.
    db_cluster_snapshot_arn: ?[]const u8,

    /// Specifies the identifier for the cluster snapshot.
    db_cluster_snapshot_identifier: ?[]const u8,

    /// Specifies the name of the database engine.
    engine: ?[]const u8,

    /// Provides the version of the database engine for this cluster snapshot.
    engine_version: ?[]const u8,

    /// If `StorageEncrypted` is `true`, the KMS key identifier for the encrypted
    /// cluster snapshot.
    kms_key_id: ?[]const u8,

    /// Provides the master user name for the cluster snapshot.
    master_username: ?[]const u8,

    /// Specifies the percentage of the estimated data that has been transferred.
    percent_progress: ?i32,

    /// Specifies the port that the cluster was listening on at the time of the
    /// snapshot.
    port: ?i32,

    /// Provides the time when the snapshot was taken, in UTC.
    snapshot_create_time: ?i64,

    /// Provides the type of the cluster snapshot.
    snapshot_type: ?[]const u8,

    /// If the cluster snapshot was copied from a source cluster snapshot, the ARN
    /// for
    /// the source cluster snapshot; otherwise, a null value.
    source_db_cluster_snapshot_arn: ?[]const u8,

    /// Specifies the status of this cluster snapshot.
    status: ?[]const u8,

    /// Specifies whether the cluster snapshot is encrypted.
    storage_encrypted: ?bool,

    /// Storage type associated with your cluster snapshot
    ///
    /// For information on storage types for Amazon DocumentDB clusters, see
    /// Cluster storage configurations in the *Amazon DocumentDB Developer Guide*.
    ///
    /// Valid values for storage type - `standard | iopt1`
    ///
    /// Default value is `standard `
    storage_type: ?[]const u8,

    /// Provides the virtual private cloud (VPC) ID that is associated with the
    /// cluster
    /// snapshot.
    vpc_id: ?[]const u8,
};
