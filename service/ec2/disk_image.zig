const DiskImageDetail = @import("disk_image_detail.zig").DiskImageDetail;
const VolumeDetail = @import("volume_detail.zig").VolumeDetail;

/// Describes a disk image.
pub const DiskImage = struct {
    /// A description of the disk image.
    description: ?[]const u8,

    /// Information about the disk image.
    image: ?DiskImageDetail,

    /// Information about the volume.
    volume: ?VolumeDetail,
};
