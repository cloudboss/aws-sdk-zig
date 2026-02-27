/// Describes the GPU accelerators for the instance type.
pub const Gpu = struct {
    /// The number of GPUs for the instance type.
    gpu_count: i32 = 0,

    /// The total size of the memory for the GPU accelerators for the instance type,
    /// in MiB.
    gpu_memory_size_in_mi_b: i32 = 0,

    pub const json_field_names = .{
        .gpu_count = "gpuCount",
        .gpu_memory_size_in_mi_b = "gpuMemorySizeInMiB",
    };
};
