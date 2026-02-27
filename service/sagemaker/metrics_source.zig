/// Details about the metrics source.
pub const MetricsSource = struct {
    /// The hash key used for the metrics source.
    content_digest: ?[]const u8,

    /// The metric source content type.
    content_type: []const u8,

    /// The S3 URI for the metrics source.
    s3_uri: []const u8,

    pub const json_field_names = .{
        .content_digest = "ContentDigest",
        .content_type = "ContentType",
        .s3_uri = "S3Uri",
    };
};
