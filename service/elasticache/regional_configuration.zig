const ReshardingConfiguration = @import("resharding_configuration.zig").ReshardingConfiguration;

/// A list of the replication groups
pub const RegionalConfiguration = struct {
    /// The name of the secondary cluster
    replication_group_id: []const u8,

    /// The Amazon region where the cluster is stored
    replication_group_region: []const u8,

    /// A list of `PreferredAvailabilityZones` objects that specifies the
    /// configuration of a node group in the resharded cluster.
    resharding_configuration: []const ReshardingConfiguration,
};
