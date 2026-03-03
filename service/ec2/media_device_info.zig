const MediaDeviceMemoryInfo = @import("media_device_memory_info.zig").MediaDeviceMemoryInfo;

/// Describes the media accelerators for the instance type.
pub const MediaDeviceInfo = struct {
    /// The number of media accelerators for the instance type.
    count: ?i32 = null,

    /// The manufacturer of the media accelerator.
    manufacturer: ?[]const u8 = null,

    /// Describes the memory available to the media accelerator.
    memory_info: ?MediaDeviceMemoryInfo = null,

    /// The name of the media accelerator.
    name: ?[]const u8 = null,
};
