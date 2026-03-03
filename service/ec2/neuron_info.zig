const NeuronDeviceInfo = @import("neuron_device_info.zig").NeuronDeviceInfo;

/// Describes the neuron accelerators for the instance type.
pub const NeuronInfo = struct {
    /// Describes the neuron accelerators for the instance type.
    neuron_devices: ?[]const NeuronDeviceInfo = null,

    /// The total size of the memory for the neuron accelerators for the instance
    /// type, in
    /// MiB.
    total_neuron_device_memory_in_mi_b: ?i32 = null,
};
