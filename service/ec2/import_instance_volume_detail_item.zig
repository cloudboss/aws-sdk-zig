const DiskImageDescription = @import("disk_image_description.zig").DiskImageDescription;
const DiskImageVolumeDescription = @import("disk_image_volume_description.zig").DiskImageVolumeDescription;

/// Describes an import volume task.
pub const ImportInstanceVolumeDetailItem = struct {
    /// The Availability Zone where the resulting instance will reside.
    availability_zone: ?[]const u8,

    /// The ID of the Availability Zone where the resulting instance will reside.
    availability_zone_id: ?[]const u8,

    /// The number of bytes converted so far.
    bytes_converted: ?i64,

    /// A description of the task.
    description: ?[]const u8,

    /// The image.
    image: ?DiskImageDescription,

    /// The status of the import of this particular disk image.
    status: ?[]const u8,

    /// The status information or errors related to the disk image.
    status_message: ?[]const u8,

    /// The volume.
    volume: ?DiskImageVolumeDescription,
};
