/// Describes the memory available to the GPU accelerator.
pub const GpuDeviceMemoryInfo = struct {
    /// The size of the memory available to the GPU accelerator, in MiB.
    size_in_mi_b: ?i32,
};
