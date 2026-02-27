const VolumeType = @import("volume_type.zig").VolumeType;

/// The structure that consists of name and type of volume.
pub const Volume = struct {
    /// A unique identifier for the volume.
    volume_name: ?[]const u8,

    /// The type of file system volume. Currently, FinSpace only supports `NAS_1`
    /// volume type.
    volume_type: ?VolumeType,

    pub const json_field_names = .{
        .volume_name = "volumeName",
        .volume_type = "volumeType",
    };
};
