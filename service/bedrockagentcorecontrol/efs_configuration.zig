/// The configuration for mounting an Amazon Elastic File System (Amazon EFS)
/// access point that you own into a session.
pub const EfsConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Elastic File System (Amazon
    /// EFS) access point to mount.
    access_point_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the Amazon Elastic File System (Amazon
    /// EFS) file system that owns the access point.
    file_system_arn: []const u8,

    /// The absolute path within the session at which the access point is mounted,
    /// for example `/mnt/efs`. Each mount path must be unique across all file
    /// system configurations in the session.
    mount_path: []const u8,

    pub const json_field_names = .{
        .access_point_arn = "accessPointArn",
        .file_system_arn = "fileSystemArn",
        .mount_path = "mountPath",
    };
};
