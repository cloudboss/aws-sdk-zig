/// The Amazon S3 location that stores the notebook execution output.
pub const OutputNotebookS3LocationForOutput = struct {
    /// The Amazon S3 bucket that stores the notebook execution output.
    bucket: ?[]const u8 = null,

    /// The key to the Amazon S3 location that stores the notebook execution
    /// output.
    key: ?[]const u8 = null,

    pub const json_field_names = .{
        .bucket = "Bucket",
        .key = "Key",
    };
};
