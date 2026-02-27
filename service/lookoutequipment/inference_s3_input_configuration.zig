/// Specifies configuration information for the input data for the inference,
/// including
/// input data S3 location.
pub const InferenceS3InputConfiguration = struct {
    /// The bucket containing the input dataset for the inference.
    bucket: []const u8,

    /// The prefix for the S3 bucket used for the input data for the inference.
    prefix: ?[]const u8,

    pub const json_field_names = .{
        .bucket = "Bucket",
        .prefix = "Prefix",
    };
};
