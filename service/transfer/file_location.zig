const EfsFileLocation = @import("efs_file_location.zig").EfsFileLocation;
const S3FileLocation = @import("s3_file_location.zig").S3FileLocation;

/// Specifies the Amazon S3 or EFS file details to be used in the step.
pub const FileLocation = struct {
    /// Specifies the Amazon EFS identifier and the path for the file being used.
    efs_file_location: ?EfsFileLocation = null,

    /// Specifies the S3 details for the file being used, such as bucket, ETag, and
    /// so forth.
    s3_file_location: ?S3FileLocation = null,

    pub const json_field_names = .{
        .efs_file_location = "EfsFileLocation",
        .s3_file_location = "S3FileLocation",
    };
};
