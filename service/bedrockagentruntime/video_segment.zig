/// Contains information about a video segment retrieved from a knowledge base,
/// including its location and summary.
///
/// This data type is used in the following API operations:
///
/// * [Retrieve
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_Retrieve.html#API_agent-runtime_Retrieve_ResponseSyntax) – in the `video` field
pub const VideoSegment = struct {
    /// The S3 URI where this specific video segment is stored in the multimodal
    /// storage destination.
    s_3_uri: []const u8,

    /// A text summary describing the content of the video segment.
    summary: ?[]const u8 = null,

    pub const json_field_names = .{
        .s_3_uri = "s3Uri",
        .summary = "summary",
    };
};
