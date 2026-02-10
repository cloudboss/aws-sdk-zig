const DiskImageDescription = @import("disk_image_description.zig").DiskImageDescription;
const DiskImageVolumeDescription = @import("disk_image_volume_description.zig").DiskImageVolumeDescription;

/// Describes an import volume task.
pub const ImportVolumeTaskDetails = struct {
    /// The Availability Zone where the resulting volume will reside.
    availability_zone: ?[]const u8,

    /// The ID of the Availability Zone where the resulting volume will reside.
    availability_zone_id: ?[]const u8,

    /// The number of bytes converted so far.
    bytes_converted: ?i64,

    /// The description you provided when starting the import volume task.
    description: ?[]const u8,

    /// The image.
    image: ?DiskImageDescription,

    /// The volume.
    volume: ?DiskImageVolumeDescription,
};
