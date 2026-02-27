const OntapFileSystemIdentity = @import("ontap_file_system_identity.zig").OntapFileSystemIdentity;

/// Specifies the FSx for ONTAP volume that the S3 access point will be attached
/// to, and the file system user identity.
pub const CreateAndAttachS3AccessPointOntapConfiguration = struct {
    /// Specifies the file system user identity to use for authorizing file read and
    /// write requests that are made using this S3 access point.
    file_system_identity: OntapFileSystemIdentity,

    /// The ID of the FSx for ONTAP volume to which you want the S3 access point
    /// attached.
    volume_id: []const u8,

    pub const json_field_names = .{
        .file_system_identity = "FileSystemIdentity",
        .volume_id = "VolumeId",
    };
};
