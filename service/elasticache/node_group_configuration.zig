/// Node group (shard) configuration options. Each node group (shard)
/// configuration has
/// the following: `Slots`, `PrimaryAvailabilityZone`,
/// `ReplicaAvailabilityZones`, `ReplicaCount`.
pub const NodeGroupConfiguration = struct {
    /// Either the ElastiCache supplied 4-digit id or a user supplied id for the
    /// node group these configuration values apply to.
    node_group_id: ?[]const u8 = null,

    /// The Availability Zone where the primary node of this node group (shard) is
    /// launched.
    primary_availability_zone: ?[]const u8 = null,

    /// The outpost ARN of the primary node.
    primary_outpost_arn: ?[]const u8 = null,

    /// A list of Availability Zones to be used for the read replicas. The number of
    /// Availability Zones in this list must match the value of `ReplicaCount` or
    /// `ReplicasPerNodeGroup` if not specified.
    replica_availability_zones: ?[]const []const u8 = null,

    /// The number of read replica nodes in this node group (shard).
    replica_count: ?i32 = null,

    /// The outpost ARN of the node replicas.
    replica_outpost_arns: ?[]const []const u8 = null,

    /// A string that specifies the keyspace for a particular node group. Keyspaces
    /// range from
    /// 0 to 16,383. The string is in the format `startkey-endkey`.
    ///
    /// Example: `"0-3999"`
    slots: ?[]const u8 = null,
};
