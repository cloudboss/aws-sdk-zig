const GpuDeviceInfo = @import("gpu_device_info.zig").GpuDeviceInfo;

/// Describes the GPU accelerators for the instance type.
pub const GpuInfo = struct {
    /// Describes the GPU accelerators for the instance type.
    gpus: ?[]const GpuDeviceInfo,

    /// The total size of the memory for the GPU accelerators for the instance type,
    /// in MiB.
    total_gpu_memory_in_mi_b: ?i32,
};
