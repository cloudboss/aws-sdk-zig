/// A list of `PreferredAvailabilityZones` objects that specifies the
/// configuration of a node group in the resharded cluster.
pub const ReshardingConfiguration = struct {
    /// Either the ElastiCache supplied 4-digit id or a user supplied id for the
    /// node group these configuration values apply to.
    node_group_id: ?[]const u8,

    /// A list of preferred availability zones for the nodes in this cluster.
    preferred_availability_zones: ?[]const []const u8,
};
