/// An EC2 instance configuration PCS uses to launch compute nodes.
pub const InstanceConfig = struct {
    /// The EC2 instance type that PCS can provision in the compute node group.
    ///
    /// Example: `t2.xlarge`
    instance_type: ?[]const u8 = null,

    pub const json_field_names = .{
        .instance_type = "instanceType",
    };
};
