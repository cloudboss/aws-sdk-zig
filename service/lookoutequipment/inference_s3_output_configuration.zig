/// Specifies configuration information for the output results from the
/// inference,
/// including output S3 location.
pub const InferenceS3OutputConfiguration = struct {
    /// The bucket containing the output results from the inference
    bucket: []const u8,

    /// The prefix for the S3 bucket used for the output results from the inference.
    prefix: ?[]const u8,

    pub const json_field_names = .{
        .bucket = "Bucket",
        .prefix = "Prefix",
    };
};
