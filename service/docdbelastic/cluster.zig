const Auth = @import("auth.zig").Auth;
const Shard = @import("shard.zig").Shard;
const Status = @import("status.zig").Status;

/// Returns information about a specific elastic cluster.
pub const Cluster = struct {
    /// The name of the elastic cluster administrator.
    admin_user_name: []const u8,

    /// The authentication type for the elastic cluster.
    auth_type: Auth,

    /// The number of days for which automatic snapshots are retained.
    backup_retention_period: ?i32,

    /// The ARN identifier of the elastic cluster.
    cluster_arn: []const u8,

    /// The URL used to connect to the elastic cluster.
    cluster_endpoint: []const u8,

    /// The name of the elastic cluster.
    cluster_name: []const u8,

    /// The time when the elastic cluster was created in Universal Coordinated Time
    /// (UTC).
    create_time: []const u8,

    /// The KMS key identifier to use to encrypt the elastic cluster.
    kms_key_id: []const u8,

    /// The daily time range during which automated backups are created if automated
    /// backups are enabled, as determined by `backupRetentionPeriod`.
    preferred_backup_window: ?[]const u8,

    /// The weekly time range during which system maintenance can occur, in
    /// Universal Coordinated Time (UTC).
    ///
    /// *Format*: `ddd:hh24:mi-ddd:hh24:mi`
    preferred_maintenance_window: []const u8,

    /// The number of vCPUs assigned to each elastic cluster shard. Maximum is 64.
    /// Allowed values are 2, 4, 8, 16, 32, 64.
    shard_capacity: i32,

    /// The number of shards assigned to the elastic cluster. Maximum is 32.
    shard_count: i32,

    /// The number of replica instances applying to all shards in the cluster.
    /// A `shardInstanceCount` value of 1 means there is one writer instance, and
    /// any additional instances are replicas that can be used for reads and to
    /// improve availability.
    shard_instance_count: ?i32,

    /// The total number of shards in the cluster.
    shards: ?[]const Shard,

    /// The status of the elastic cluster.
    status: Status,

    /// The Amazon EC2 subnet IDs for the elastic cluster.
    subnet_ids: []const []const u8,

    /// A list of EC2 VPC security groups associated with thie elastic cluster.
    vpc_security_group_ids: []const []const u8,

    pub const json_field_names = .{
        .admin_user_name = "adminUserName",
        .auth_type = "authType",
        .backup_retention_period = "backupRetentionPeriod",
        .cluster_arn = "clusterArn",
        .cluster_endpoint = "clusterEndpoint",
        .cluster_name = "clusterName",
        .create_time = "createTime",
        .kms_key_id = "kmsKeyId",
        .preferred_backup_window = "preferredBackupWindow",
        .preferred_maintenance_window = "preferredMaintenanceWindow",
        .shard_capacity = "shardCapacity",
        .shard_count = "shardCount",
        .shard_instance_count = "shardInstanceCount",
        .shards = "shards",
        .status = "status",
        .subnet_ids = "subnetIds",
        .vpc_security_group_ids = "vpcSecurityGroupIds",
    };
};
