const AccountWithRestoreAccess = @import("account_with_restore_access.zig").AccountWithRestoreAccess;
const Tag = @import("tag.zig").Tag;

/// Describes a snapshot.
pub const Snapshot = struct {
    /// A list of the Amazon Web Services accounts authorized to restore the
    /// snapshot. Returns
    /// `null` if no accounts are authorized. Visible only to the snapshot owner.
    accounts_with_restore_access: ?[]const AccountWithRestoreAccess = null,

    /// The size of the incremental backup.
    actual_incremental_backup_size_in_mega_bytes: ?f64 = null,

    /// The Availability Zone in which the cluster was created.
    availability_zone: ?[]const u8 = null,

    /// The number of megabytes that have been transferred to the snapshot
    /// backup.
    backup_progress_in_mega_bytes: ?f64 = null,

    /// The time (UTC) when the cluster was originally created.
    cluster_create_time: ?i64 = null,

    /// The identifier of the cluster for which the snapshot was taken.
    cluster_identifier: ?[]const u8 = null,

    /// The version ID of the Amazon Redshift engine that is running on the cluster.
    cluster_version: ?[]const u8 = null,

    /// The number of megabytes per second being transferred to the snapshot backup.
    /// Returns `0` for a completed backup.
    current_backup_rate_in_mega_bytes_per_second: ?f64 = null,

    /// The name of the database that was created when the cluster was created.
    db_name: ?[]const u8 = null,

    /// The amount of time an in-progress snapshot backup has been running, or the
    /// amount
    /// of time it took a completed backup to finish.
    elapsed_time_in_seconds: ?i64 = null,

    /// If `true`, the data in the snapshot is encrypted at rest.
    encrypted: ?bool = null,

    /// A boolean that indicates whether the snapshot data is encrypted using the
    /// HSM keys
    /// of the source cluster. `true` indicates that the data is encrypted using HSM
    /// keys.
    encrypted_with_hsm: ?bool = null,

    /// The cluster version of the cluster used to create the snapshot. For example,
    /// 1.0.15503.
    engine_full_version: ?[]const u8 = null,

    /// An option that specifies whether to create the cluster with enhanced VPC
    /// routing
    /// enabled. To create a cluster that uses enhanced VPC routing, the cluster
    /// must be in a
    /// VPC. For more information, see [Enhanced VPC
    /// Routing](https://docs.aws.amazon.com/redshift/latest/mgmt/enhanced-vpc-routing.html) in
    /// the Amazon Redshift Cluster Management Guide.
    ///
    /// If this option is `true`, enhanced VPC routing is enabled.
    ///
    /// Default: false
    enhanced_vpc_routing: ?bool = null,

    /// The estimate of the time remaining before the snapshot backup will complete.
    /// Returns `0` for a completed backup.
    estimated_seconds_to_completion: ?i64 = null,

    /// The Key Management Service (KMS) key ID of the encryption key that was used
    /// to
    /// encrypt data in the cluster from which the snapshot was taken.
    kms_key_id: ?[]const u8 = null,

    /// The name of the maintenance track for the snapshot.
    maintenance_track_name: ?[]const u8 = null,

    /// The number of days until a manual snapshot will pass its retention period.
    manual_snapshot_remaining_days: ?i32 = null,

    /// The number of days that a manual snapshot is retained. If the value is -1,
    /// the manual
    /// snapshot is retained indefinitely.
    ///
    /// The value must be either -1 or an integer between 1 and 3,653.
    manual_snapshot_retention_period: ?i32 = null,

    /// The Amazon Resource Name (ARN) for the cluster's admin user credentials
    /// secret.
    master_password_secret_arn: ?[]const u8 = null,

    /// The ID of the Key Management Service (KMS) key used to encrypt and store the
    /// cluster's admin credentials secret.
    master_password_secret_kms_key_id: ?[]const u8 = null,

    /// The admin user name for the cluster.
    master_username: ?[]const u8 = null,

    /// The node type of the nodes in the cluster.
    node_type: ?[]const u8 = null,

    /// The number of nodes in the cluster.
    number_of_nodes: ?i32 = null,

    /// For manual snapshots, the Amazon Web Services account used to create or copy
    /// the snapshot.
    /// For automatic snapshots, the owner of the cluster. The owner can perform all
    /// snapshot
    /// actions, such as sharing a manual snapshot.
    owner_account: ?[]const u8 = null,

    /// The port that the cluster is listening on.
    port: ?i32 = null,

    /// The list of node types that this cluster snapshot is able to restore
    /// into.
    restorable_node_types: ?[]const []const u8 = null,

    /// The Amazon Resource Name (ARN) of the snapshot.
    snapshot_arn: ?[]const u8 = null,

    /// The time (in UTC format) when Amazon Redshift began the snapshot. A snapshot
    /// contains a
    /// copy of the cluster data as of this exact time.
    snapshot_create_time: ?i64 = null,

    /// The snapshot identifier that is provided in the request.
    snapshot_identifier: ?[]const u8 = null,

    /// A timestamp representing the start of the retention period for the snapshot.
    snapshot_retention_start_time: ?i64 = null,

    /// The snapshot type. Snapshots created using CreateClusterSnapshot
    /// and CopyClusterSnapshot are of type "manual".
    snapshot_type: ?[]const u8 = null,

    /// The source region from which the snapshot was copied.
    source_region: ?[]const u8 = null,

    /// The snapshot status. The value of the status depends on the API operation
    /// used:
    ///
    /// * CreateClusterSnapshot and CopyClusterSnapshot returns status as
    ///   "creating".
    ///
    /// * DescribeClusterSnapshots returns status as "creating",
    /// "available", "final snapshot", or "failed".
    ///
    /// * DeleteClusterSnapshot returns status as "deleted".
    status: ?[]const u8 = null,

    /// The list of tags for the cluster snapshot.
    tags: ?[]const Tag = null,

    /// The size of the complete set of backup data that would be used to restore
    /// the
    /// cluster.
    total_backup_size_in_mega_bytes: ?f64 = null,

    /// The VPC identifier of the cluster if the snapshot is from a cluster in a
    /// VPC.
    /// Otherwise, this field is not in the output.
    vpc_id: ?[]const u8 = null,
};
