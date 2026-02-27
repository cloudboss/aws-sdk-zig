const EfsFileLocation = @import("efs_file_location.zig").EfsFileLocation;
const S3InputFileLocation = @import("s3_input_file_location.zig").S3InputFileLocation;

/// Specifies the location for the file that's being processed.
pub const InputFileLocation = struct {
    /// Specifies the details for the Amazon Elastic File System (Amazon EFS) file
    /// that's being decrypted.
    efs_file_location: ?EfsFileLocation,

    /// Specifies the details for the Amazon S3 file that's being copied or
    /// decrypted.
    s3_file_location: ?S3InputFileLocation,

    pub const json_field_names = .{
        .efs_file_location = "EfsFileLocation",
        .s3_file_location = "S3FileLocation",
    };
};
