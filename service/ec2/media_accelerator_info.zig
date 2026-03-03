const MediaDeviceInfo = @import("media_device_info.zig").MediaDeviceInfo;

/// Describes the media accelerators for the instance type.
pub const MediaAcceleratorInfo = struct {
    /// Describes the media accelerators for the instance type.
    accelerators: ?[]const MediaDeviceInfo = null,

    /// The total size of the memory for the media accelerators for the instance
    /// type, in
    /// MiB.
    total_media_memory_in_mi_b: ?i32 = null,
};
