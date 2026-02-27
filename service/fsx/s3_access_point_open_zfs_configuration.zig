const OpenZFSFileSystemIdentity = @import("open_zfs_file_system_identity.zig").OpenZFSFileSystemIdentity;

/// Describes the FSx for OpenZFS attachment configuration of an S3 access point
/// attachment.
pub const S3AccessPointOpenZFSConfiguration = struct {
    /// The file system identity used to authorize file access requests made using
    /// the S3 access point.
    file_system_identity: ?OpenZFSFileSystemIdentity,

    /// The ID of the FSx for OpenZFS volume that the S3 access point is attached
    /// to.
    volume_id: ?[]const u8,

    pub const json_field_names = .{
        .file_system_identity = "FileSystemIdentity",
        .volume_id = "VolumeId",
    };
};
