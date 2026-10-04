/// The configuration for mounting an Amazon Simple Storage Service (Amazon S3)
/// Files access point that you own into a session.
pub const S3FilesConfiguration = struct {
    /// The Amazon Resource Name (ARN) of the Amazon Simple Storage Service (Amazon
    /// S3) Files access point to mount.
    access_point_arn: []const u8,

    /// The Amazon Resource Name (ARN) of the Amazon Simple Storage Service (Amazon
    /// S3) Files file system that owns the access point.
    file_system_arn: []const u8,

    /// The absolute path within the session at which the access point is mounted,
    /// for example `/mnt/s3data`. Each mount path must be unique across all file
    /// system configurations in the session.
    mount_path: []const u8,

    pub const json_field_names = .{
        .access_point_arn = "accessPointArn",
        .file_system_arn = "fileSystemArn",
        .mount_path = "mountPath",
    };
};
