const ClusterInstanceType = @import("cluster_instance_type.zig").ClusterInstanceType;

/// Specifies an instance group and the number of nodes to add to it.
pub const AddClusterNodeSpecification = struct {
    /// The availability zones in which to add nodes. Use this to target node
    /// placement in specific availability zones within a flexible instance group.
    availability_zones: ?[]const []const u8 = null,

    /// The number of nodes to add to the specified instance group. The total number
    /// of nodes across all instance groups in a single request cannot exceed 50.
    increment_target_count_by: i32,

    /// The name of the instance group to which you want to add nodes.
    instance_group_name: []const u8,

    /// The instance types to use when adding nodes. Use this to target specific
    /// instance types within a flexible instance group.
    instance_types: ?[]const ClusterInstanceType = null,

    pub const json_field_names = .{
        .availability_zones = "AvailabilityZones",
        .increment_target_count_by = "IncrementTargetCountBy",
        .instance_group_name = "InstanceGroupName",
        .instance_types = "InstanceTypes",
    };
};
