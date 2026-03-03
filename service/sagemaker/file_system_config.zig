/// The Amazon Elastic File System storage configuration for a SageMaker AI
/// image.
pub const FileSystemConfig = struct {
    /// The default POSIX group ID (GID). If not specified, defaults to `100`.
    default_gid: ?i32 = null,

    /// The default POSIX user ID (UID). If not specified, defaults to `1000`.
    default_uid: ?i32 = null,

    /// The path within the image to mount the user's EFS home directory. The
    /// directory should be empty. If not specified, defaults to
    /// */home/sagemaker-user*.
    mount_path: ?[]const u8 = null,

    pub const json_field_names = .{
        .default_gid = "DefaultGid",
        .default_uid = "DefaultUid",
        .mount_path = "MountPath",
    };
};
