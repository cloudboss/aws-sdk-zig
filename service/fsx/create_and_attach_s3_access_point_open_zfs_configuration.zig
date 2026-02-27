const OpenZFSFileSystemIdentity = @import("open_zfs_file_system_identity.zig").OpenZFSFileSystemIdentity;

/// Specifies the FSx for OpenZFS volume that the S3 access point will be
/// attached to, and the file system user identity.
pub const CreateAndAttachS3AccessPointOpenZFSConfiguration = struct {
    /// Specifies the file system user identity to use for authorizing file read and
    /// write requests that are made using this S3 access point.
    file_system_identity: OpenZFSFileSystemIdentity,

    /// The ID of the FSx for OpenZFS volume to which you want the S3 access point
    /// attached.
    volume_id: []const u8,

    pub const json_field_names = .{
        .file_system_identity = "FileSystemIdentity",
        .volume_id = "VolumeId",
    };
};
