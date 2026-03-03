const OntapFileSystemIdentity = @import("ontap_file_system_identity.zig").OntapFileSystemIdentity;

/// Describes the FSx for ONTAP attachment configuration of an S3 access point
/// attachment.
pub const S3AccessPointOntapConfiguration = struct {
    /// The file system identity used to authorize file access requests made using
    /// the S3 access point.
    file_system_identity: ?OntapFileSystemIdentity = null,

    /// The ID of the FSx for ONTAP volume that the S3 access point is attached to.
    volume_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .file_system_identity = "FileSystemIdentity",
        .volume_id = "VolumeId",
    };
};
