const S3Path = @import("s3_path.zig").S3Path;

/// User accounts whose documents should be indexed.
pub const OneDriveUsers = struct {
    /// A list of users whose documents should be indexed. Specify the user names in
    /// email
    /// format, for example, `username@tenantdomain`. If you need to index the
    /// documents of more than 10 users, use the `OneDriveUserS3Path` field to
    /// specify the location of a file containing a list of users.
    one_drive_user_list: ?[]const []const u8,

    /// The S3 bucket location of a file containing a list of users whose documents
    /// should be
    /// indexed.
    one_drive_user_s3_path: ?S3Path,

    pub const json_field_names = .{
        .one_drive_user_list = "OneDriveUserList",
        .one_drive_user_s3_path = "OneDriveUserS3Path",
    };
};
