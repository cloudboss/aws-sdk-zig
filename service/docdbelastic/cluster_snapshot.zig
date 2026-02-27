const SnapshotType = @import("snapshot_type.zig").SnapshotType;
const Status = @import("status.zig").Status;

/// Returns information about a specific elastic cluster snapshot.
pub const ClusterSnapshot = struct {
    /// The name of the elastic cluster administrator.
    admin_user_name: []const u8,

    /// The ARN identifier of the elastic cluster.
    cluster_arn: []const u8,

    /// The time when the elastic cluster was created in Universal Coordinated Time
    /// (UTC).
    cluster_creation_time: []const u8,

    /// The KMS key identifier is the Amazon Resource Name (ARN) for the KMS
    /// encryption key.
    /// If you are creating a cluster using the same Amazon account that owns this
    /// KMS encryption key, you can use the KMS key alias instead of the ARN as the
    /// KMS encryption key.
    /// If an encryption key is not specified here, Amazon DocumentDB uses the
    /// default encryption key that KMS creates for your account.
    /// Your account has a different default encryption key for each Amazon Region.
    kms_key_id: []const u8,

    /// The ARN identifier of the elastic cluster snapshot.
    snapshot_arn: []const u8,

    /// The time when the elastic cluster snapshot was created in Universal
    /// Coordinated Time (UTC).
    snapshot_creation_time: []const u8,

    /// The name of the elastic cluster snapshot.
    snapshot_name: []const u8,

    /// The type of cluster snapshots to be returned.
    /// You can specify one of the following values:
    ///
    /// * `automated` - Return all cluster snapshots that Amazon DocumentDB has
    ///   automatically created for your Amazon Web Services account.
    ///
    /// * `manual` - Return all cluster snapshots that you have manually created for
    ///   your Amazon Web Services account.
    snapshot_type: ?SnapshotType,

    /// The status of the elastic cluster snapshot.
    status: Status,

    /// The Amazon EC2 subnet IDs for the elastic cluster.
    subnet_ids: []const []const u8,

    /// A list of EC2 VPC security groups to associate with the elastic cluster.
    vpc_security_group_ids: []const []const u8,

    pub const json_field_names = .{
        .admin_user_name = "adminUserName",
        .cluster_arn = "clusterArn",
        .cluster_creation_time = "clusterCreationTime",
        .kms_key_id = "kmsKeyId",
        .snapshot_arn = "snapshotArn",
        .snapshot_creation_time = "snapshotCreationTime",
        .snapshot_name = "snapshotName",
        .snapshot_type = "snapshotType",
        .status = "status",
        .subnet_ids = "subnetIds",
        .vpc_security_group_ids = "vpcSecurityGroupIds",
    };
};
