/// The Amazon S3 location that stores the notebook execution input.
pub const NotebookS3LocationFromInput = struct {
    /// The Amazon S3 bucket that stores the notebook execution input.
    bucket: ?[]const u8,

    /// The key to the Amazon S3 location that stores the notebook execution
    /// input.
    key: ?[]const u8,

    pub const json_field_names = .{
        .bucket = "Bucket",
        .key = "Key",
    };
};
