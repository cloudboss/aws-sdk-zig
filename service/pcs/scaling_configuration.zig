/// Specifies the boundaries of the compute node group auto scaling.
pub const ScalingConfiguration = struct {
    /// The upper bound of the number of instances allowed in the compute fleet.
    max_instance_count: i32 = 0,

    /// The lower bound of the number of instances allowed in the compute fleet.
    min_instance_count: i32 = 0,

    pub const json_field_names = .{
        .max_instance_count = "maxInstanceCount",
        .min_instance_count = "minInstanceCount",
    };
};
