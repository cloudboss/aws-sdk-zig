/// Describes the performance configuration for compute services such as Amazon
/// EC2, Lambda, and ECS.
pub const ComputeConfiguration = struct {
    /// The architecture of the resource.
    architecture: ?[]const u8 = null,

    /// The memory size of the resource.
    memory_size_in_mb: ?i32 = null,

    /// The platform of the resource. The platform is the specific combination of
    /// operating system, license model, and software on an instance.
    platform: ?[]const u8 = null,

    /// The number of vCPU cores in the resource.
    v_cpu: ?f64 = null,

    pub const json_field_names = .{
        .architecture = "architecture",
        .memory_size_in_mb = "memorySizeInMB",
        .platform = "platform",
        .v_cpu = "vCpu",
    };
};
