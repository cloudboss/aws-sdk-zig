/// Node group (shard) configuration options when adding or removing replicas.
/// Each
/// node group (shard) configuration has the following members: NodeGroupId,
/// NewReplicaCount, and PreferredAvailabilityZones.
pub const ConfigureShard = struct {
    /// The number of replicas you want in this node group at the end of this
    /// operation.
    /// The maximum value for `NewReplicaCount` is 5. The minimum value depends upon
    /// the type of Valkey or Redis OSS replication group you are working with.
    ///
    /// The minimum number of replicas in a shard or replication group is:
    ///
    /// * Valkey or Redis OSS (cluster mode disabled)
    ///
    /// * If Multi-AZ: 1
    ///
    /// * If Multi-AZ: 0
    ///
    /// * Valkey or Redis OSS (cluster mode enabled): 0 (though you will not be able
    ///   to failover to
    /// a replica if your primary node fails)
    new_replica_count: i32,

    /// The 4-digit id for the node group you are configuring. For Valkey or Redis
    /// OSS (cluster mode
    /// disabled) replication groups, the node group id is always 0001. To find a
    /// Valkey or Redis OSS (cluster mode enabled)'s node group's (shard's) id, see
    /// [Finding a Shard's
    /// Id](https://docs.aws.amazon.com/AmazonElastiCache/latest/dg/shard-find-id.html).
    node_group_id: []const u8,

    /// A list of `PreferredAvailabilityZone` strings that specify which
    /// availability zones the replication group's nodes are to be in. The nummber
    /// of
    /// `PreferredAvailabilityZone` values must equal the value of
    /// `NewReplicaCount` plus 1 to account for the primary node. If this member
    /// of `ReplicaConfiguration` is omitted, ElastiCache selects the
    /// availability zone for each of the replicas.
    preferred_availability_zones: ?[]const []const u8 = null,

    /// The outpost ARNs in which the cache cluster is created.
    preferred_outpost_arns: ?[]const []const u8 = null,
};
