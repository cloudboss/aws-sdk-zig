const MIGProfileType = @import("mig_profile_type.zig").MIGProfileType;

/// Configuration for allocating accelerator partitions.
pub const AcceleratorPartitionConfig = struct {
    /// The number of accelerator partitions to allocate with the specified
    /// partition type. If you don't specify a value for vCPU and MemoryInGiB,
    /// SageMaker AI automatically allocates ratio-based values for those parameters
    /// based on the accelerator partition count you provide.
    count: i32,

    /// The Multi-Instance GPU (MIG) profile type that defines the partition
    /// configuration. The profile specifies the compute and memory allocation for
    /// each partition instance. The available profile types depend on the instance
    /// type specified in the compute quota configuration.
    type: MIGProfileType,

    pub const json_field_names = .{
        .count = "Count",
        .type = "Type",
    };
};
