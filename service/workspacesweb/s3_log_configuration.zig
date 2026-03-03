const FolderStructure = @import("folder_structure.zig").FolderStructure;
const LogFileFormat = @import("log_file_format.zig").LogFileFormat;

/// The S3 log configuration.
pub const S3LogConfiguration = struct {
    /// The S3 bucket name where logs are delivered.
    bucket: []const u8,

    /// The expected bucket owner of the target S3 bucket. The caller must have
    /// permissions to write to the target bucket.
    bucket_owner: ?[]const u8 = null,

    /// The folder structure that defines the organizational structure for log files
    /// in S3.
    folder_structure: FolderStructure,

    /// The S3 path prefix that determines where log files are stored.
    key_prefix: ?[]const u8 = null,

    /// The format of the LogFile that is written to S3.
    log_file_format: LogFileFormat,

    pub const json_field_names = .{
        .bucket = "bucket",
        .bucket_owner = "bucketOwner",
        .folder_structure = "folderStructure",
        .key_prefix = "keyPrefix",
        .log_file_format = "logFileFormat",
    };
};
