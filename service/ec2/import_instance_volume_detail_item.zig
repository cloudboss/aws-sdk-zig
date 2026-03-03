const DiskImageDescription = @import("disk_image_description.zig").DiskImageDescription;
const DiskImageVolumeDescription = @import("disk_image_volume_description.zig").DiskImageVolumeDescription;

/// Describes an import volume task.
pub const ImportInstanceVolumeDetailItem = struct {
    /// The Availability Zone where the resulting instance will reside.
    availability_zone: ?[]const u8 = null,

    /// The ID of the Availability Zone where the resulting instance will reside.
    availability_zone_id: ?[]const u8 = null,

    /// The number of bytes converted so far.
    bytes_converted: ?i64 = null,

    /// A description of the task.
    description: ?[]const u8 = null,

    /// The image.
    image: ?DiskImageDescription = null,

    /// The status of the import of this particular disk image.
    status: ?[]const u8 = null,

    /// The status information or errors related to the disk image.
    status_message: ?[]const u8 = null,

    /// The volume.
    volume: ?DiskImageVolumeDescription = null,
};
