/// The configuration for the payload for a recommendation job.
pub const RecommendationJobPayloadConfig = struct {
    /// The Amazon Simple Storage Service (Amazon S3) path where the sample payload
    /// is stored. This path must point to a single gzip compressed tar archive
    /// (.tar.gz suffix).
    sample_payload_url: ?[]const u8 = null,

    /// The supported MIME types for the input data.
    supported_content_types: ?[]const []const u8 = null,

    pub const json_field_names = .{
        .sample_payload_url = "SamplePayloadUrl",
        .supported_content_types = "SupportedContentTypes",
    };
};
