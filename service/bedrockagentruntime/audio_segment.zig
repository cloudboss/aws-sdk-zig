/// Contains information about an audio segment retrieved from a knowledge base,
/// including its location and transcription.
///
/// This data type is used in the following API operations:
///
/// * [Retrieve
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_Retrieve.html#API_agent-runtime_Retrieve_ResponseSyntax) – in the `audio` field
pub const AudioSegment = struct {
    /// The S3 URI where this specific audio segment is stored in the multimodal
    /// storage destination.
    s_3_uri: []const u8,

    /// The text transcription of the audio segment content.
    transcription: ?[]const u8,

    pub const json_field_names = .{
        .s_3_uri = "s3Uri",
        .transcription = "transcription",
    };
};
