/// Describes Network File System (NFS) file share default values. Files and
/// folders stored
/// as Amazon S3 objects in S3 buckets don't, by default, have Unix file
/// permissions assigned to them. Upon discovery in an S3 bucket by Storage
/// Gateway, the S3
/// objects that represent files and folders are assigned these default Unix
/// permissions. This
/// operation is only supported for S3 File Gateways.
pub const NFSFileShareDefaults = struct {
    /// The Unix directory mode in the form "nnnn". For example, `0666` represents
    /// the default access mode for all directories inside the file share. The
    /// default value is
    /// `0777`.
    directory_mode: ?[]const u8 = null,

    /// The Unix file mode in the form "nnnn". For example, `0666` represents the
    /// default file mode inside the file share. The default value is `0666`.
    file_mode: ?[]const u8 = null,

    /// The default group ID for the file share (unless the files have another group
    /// ID
    /// specified). The default value is `nfsnobody`.
    group_id: ?i64 = null,

    /// The default owner ID for files in the file share (unless the files have
    /// another owner ID
    /// specified). The default value is `nfsnobody`.
    owner_id: ?i64 = null,

    pub const json_field_names = .{
        .directory_mode = "DirectoryMode",
        .file_mode = "FileMode",
        .group_id = "GroupId",
        .owner_id = "OwnerId",
    };
};
