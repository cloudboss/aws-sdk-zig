/// The configuration that describes specifications of the instance groups to
/// update.
pub const UpdateClusterSoftwareInstanceGroupSpecification = struct {
    /// The name of the instance group to update.
    instance_group_name: []const u8,

    pub const json_field_names = .{
        .instance_group_name = "InstanceGroupName",
    };
};
