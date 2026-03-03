const InstanceRoleType = @import("instance_role_type.zig").InstanceRoleType;
const PlacementGroupStrategy = @import("placement_group_strategy.zig").PlacementGroupStrategy;

/// Placement group configuration for an Amazon EMR cluster. The configuration
/// specifies the placement strategy that can be applied to instance roles
/// during cluster
/// creation.
///
/// To use this configuration, consider attaching managed policy
/// AmazonElasticMapReducePlacementGroupPolicy to the Amazon EMR role.
pub const PlacementGroupConfig = struct {
    /// Role of the instance in the cluster.
    ///
    /// Starting with Amazon EMR release 5.23.0, the only supported instance role is
    /// `MASTER`.
    instance_role: InstanceRoleType,

    /// Amazon EC2 Placement Group strategy associated with instance role.
    ///
    /// Starting with Amazon EMR release 5.23.0, the only supported placement
    /// strategy
    /// is `SPREAD` for the `MASTER` instance role.
    placement_strategy: ?PlacementGroupStrategy = null,

    pub const json_field_names = .{
        .instance_role = "InstanceRole",
        .placement_strategy = "PlacementStrategy",
    };
};
