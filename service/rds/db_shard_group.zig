const Tag = @import("tag.zig").Tag;

/// Contains the details for an Amazon RDS DB shard group.
pub const DBShardGroup = struct {
    /// Specifies whether to create standby DB shard groups for the DB shard group.
    /// Valid values are the following:
    ///
    /// * 0 - Creates a DB shard group without a standby DB shard group. This is the
    ///   default value.
    /// * 1 - Creates a DB shard group with a standby DB shard group in a different
    ///   Availability Zone (AZ).
    /// * 2 - Creates a DB shard group with two standby DB shard groups in two
    ///   different AZs.
    compute_redundancy: ?i32 = null,

    /// The name of the primary DB cluster for the DB shard group.
    db_cluster_identifier: ?[]const u8 = null,

    /// The Amazon Resource Name (ARN) for the DB shard group.
    db_shard_group_arn: ?[]const u8 = null,

    /// The name of the DB shard group.
    db_shard_group_identifier: ?[]const u8 = null,

    /// The Amazon Web Services Region-unique, immutable identifier for the DB shard
    /// group.
    db_shard_group_resource_id: ?[]const u8 = null,

    /// The connection endpoint for the DB shard group.
    endpoint: ?[]const u8 = null,

    /// The maximum capacity of the DB shard group in Aurora capacity units (ACUs).
    max_acu: ?f64 = null,

    /// The minimum capacity of the DB shard group in Aurora capacity units (ACUs).
    min_acu: ?f64 = null,

    /// Indicates whether the DB shard group is publicly accessible.
    ///
    /// When the DB shard group is publicly accessible, its Domain Name System (DNS)
    /// endpoint resolves to the private IP address from within the DB shard group's
    /// virtual private cloud (VPC). It resolves to the public IP address from
    /// outside of the DB shard group's VPC. Access to the DB shard group is
    /// ultimately controlled by the security group it uses. That public access
    /// isn't permitted if the security group assigned to the DB shard group doesn't
    /// permit it.
    ///
    /// When the DB shard group isn't publicly accessible, it is an internal DB
    /// shard group with a DNS name that resolves to a private IP address.
    ///
    /// For more information, see CreateDBShardGroup.
    ///
    /// This setting is only for Aurora Limitless Database.
    publicly_accessible: ?bool = null,

    /// The status of the DB shard group.
    status: ?[]const u8 = null,

    tag_list: ?[]const Tag = null,
};
