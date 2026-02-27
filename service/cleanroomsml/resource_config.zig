const InstanceType = @import("instance_type.zig").InstanceType;

/// Information about the EC2 resources that are used to train the model.
pub const ResourceConfig = struct {
    /// The number of resources that are used to train the model.
    instance_count: i32 = 1,

    /// The instance type that is used to train the model.
    instance_type: InstanceType,

    /// The volume size of the instance that is used to train the model. Please see
    /// [EC2 volume
    /// limit](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/instance-store-volumes.html) for volume size limitations on different instance types.
    volume_size_in_gb: i32,

    pub const json_field_names = .{
        .instance_count = "instanceCount",
        .instance_type = "instanceType",
        .volume_size_in_gb = "volumeSizeInGB",
    };
};
