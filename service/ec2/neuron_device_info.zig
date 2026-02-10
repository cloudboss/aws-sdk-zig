const NeuronDeviceCoreInfo = @import("neuron_device_core_info.zig").NeuronDeviceCoreInfo;
const NeuronDeviceMemoryInfo = @import("neuron_device_memory_info.zig").NeuronDeviceMemoryInfo;

/// Describes the neuron accelerators for the instance type.
pub const NeuronDeviceInfo = struct {
    /// Describes the cores available to each neuron accelerator.
    core_info: ?NeuronDeviceCoreInfo,

    /// The number of neuron accelerators for the instance type.
    count: ?i32,

    /// Describes the memory available to each neuron accelerator.
    memory_info: ?NeuronDeviceMemoryInfo,

    /// The name of the neuron accelerator.
    name: ?[]const u8,
};
