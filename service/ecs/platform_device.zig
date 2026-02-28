const PlatformDeviceType = @import("platform_device_type.zig").PlatformDeviceType;

/// The devices that are available on the container instance. The only supported
/// device
/// type is a GPU.
pub const PlatformDevice = struct {
    /// The ID for the GPUs on the container instance. The available GPU IDs can
    /// also be
    /// obtained on the container instance in the
    /// `/var/lib/ecs/gpu/nvidia_gpu_info.json` file.
    id: []const u8,

    /// The type of device that's available on the container instance. The only
    /// supported
    /// value is `GPU`.
    @"type": PlatformDeviceType,

    pub const json_field_names = .{
        .id = "id",
        .@"type" = "type",
    };
};
