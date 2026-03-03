/// The location information (prefix and bucket name) for the s3 location being
/// used for
/// label data.
pub const LabelsS3InputConfiguration = struct {
    /// The name of the S3 bucket holding the label data.
    bucket: []const u8,

    /// The prefix for the S3 bucket used for the label data.
    prefix: ?[]const u8 = null,

    pub const json_field_names = .{
        .bucket = "Bucket",
        .prefix = "Prefix",
    };
};
