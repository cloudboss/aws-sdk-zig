const InstanceType = @import("instance_type.zig").InstanceType;

/// Configures the resource instances to use while running the Amazon Braket
/// hybrid job on Amazon Braket.
pub const InstanceConfig = struct {
    /// Configures the number of resource instances to use while running an Amazon
    /// Braket hybrid job on Amazon Braket. The default value is 1.
    instance_count: ?i32,

    /// Configures the type of resource instances to use while running an Amazon
    /// Braket hybrid job.
    instance_type: InstanceType,

    /// The size of the storage volume, in GB, to provision.
    volume_size_in_gb: i32,

    pub const json_field_names = .{
        .instance_count = "instanceCount",
        .instance_type = "instanceType",
        .volume_size_in_gb = "volumeSizeInGb",
    };
};
