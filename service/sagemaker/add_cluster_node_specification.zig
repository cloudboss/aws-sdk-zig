/// Specifies an instance group and the number of nodes to add to it.
pub const AddClusterNodeSpecification = struct {
    /// The number of nodes to add to the specified instance group. The total number
    /// of nodes across all instance groups in a single request cannot exceed 50.
    increment_target_count_by: i32,

    /// The name of the instance group to which you want to add nodes.
    instance_group_name: []const u8,

    pub const json_field_names = .{
        .increment_target_count_by = "IncrementTargetCountBy",
        .instance_group_name = "InstanceGroupName",
    };
};
