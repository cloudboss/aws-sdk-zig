const GpuDeviceMemoryInfo = @import("gpu_device_memory_info.zig").GpuDeviceMemoryInfo;

/// Describes the GPU accelerators for the instance type.
pub const GpuDeviceInfo = struct {
    /// The number of GPUs for the instance type.
    count: ?i32 = null,

    /// The size of each GPU as a fraction of a full GPU, between 0 (excluded) and 1
    /// (included).
    gpu_partition_size: ?f64 = null,

    /// Total number of GPU devices of this type.
    logical_gpu_count: ?i32 = null,

    /// The manufacturer of the GPU accelerator.
    manufacturer: ?[]const u8 = null,

    /// Describes the memory available to the GPU accelerator.
    memory_info: ?GpuDeviceMemoryInfo = null,

    /// The name of the GPU accelerator.
    name: ?[]const u8 = null,

    /// A list of workload types this GPU supports.
    workloads: ?[]const []const u8 = null,
};
