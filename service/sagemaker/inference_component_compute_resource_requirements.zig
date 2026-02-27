/// Defines the compute resources to allocate to run a model, plus any adapter
/// models, that you assign to an inference component. These resources include
/// CPU cores, accelerators, and memory.
pub const InferenceComponentComputeResourceRequirements = struct {
    /// The maximum MB of memory to allocate to run a model that you assign to an
    /// inference component.
    max_memory_required_in_mb: ?i32,

    /// The minimum MB of memory to allocate to run a model that you assign to an
    /// inference component.
    min_memory_required_in_mb: i32,

    /// The number of accelerators to allocate to run a model that you assign to an
    /// inference component. Accelerators include GPUs and Amazon Web Services
    /// Inferentia.
    number_of_accelerator_devices_required: ?f32,

    /// The number of CPU cores to allocate to run a model that you assign to an
    /// inference component.
    number_of_cpu_cores_required: ?f32,

    pub const json_field_names = .{
        .max_memory_required_in_mb = "MaxMemoryRequiredInMb",
        .min_memory_required_in_mb = "MinMemoryRequiredInMb",
        .number_of_accelerator_devices_required = "NumberOfAcceleratorDevicesRequired",
        .number_of_cpu_cores_required = "NumberOfCpuCoresRequired",
    };
};
