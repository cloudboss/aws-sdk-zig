const PlatformDeviceType = @import("platform_device_type.zig").PlatformDeviceType;

/// The devices that are available on the container instance. The supported
/// device types are GPUs and Neuron devices.
pub const PlatformDevice = struct {
    /// The ID for the GPU or Neuron device on the container instance. For GPUs, the
    /// available GPU IDs can also be obtained on the container instance in the
    /// `/var/lib/ecs/gpu/nvidia_gpu_info.json` file. For Neuron devices, the ID
    /// corresponds to the device index (for example, `0` for `/dev/neuron0`).
    id: []const u8,

    /// The type of device that's available on the container instance. The supported
    /// values are `GPU` and `NEURON_DEVICE`.
    type: PlatformDeviceType,

    pub const json_field_names = .{
        .id = "id",
        .type = "type",
    };
};
