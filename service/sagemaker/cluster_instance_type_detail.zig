const ClusterInstanceType = @import("cluster_instance_type.zig").ClusterInstanceType;

/// Details about a specific instance type within a flexible instance group,
/// including the count and configuration.
pub const ClusterInstanceTypeDetail = struct {
    /// The number of instances of this type currently running in the instance
    /// group.
    current_count: ?i32 = null,

    /// The instance type.
    instance_type: ?ClusterInstanceType = null,

    /// The number of threads per CPU core for this instance type.
    threads_per_core: ?i32 = null,

    pub const json_field_names = .{
        .current_count = "CurrentCount",
        .instance_type = "InstanceType",
        .threads_per_core = "ThreadsPerCore",
    };
};
