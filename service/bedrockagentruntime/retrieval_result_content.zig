const AudioSegment = @import("audio_segment.zig").AudioSegment;
const RetrievalResultContentColumn = @import("retrieval_result_content_column.zig").RetrievalResultContentColumn;
const RetrievalResultContentType = @import("retrieval_result_content_type.zig").RetrievalResultContentType;
const VideoSegment = @import("video_segment.zig").VideoSegment;

/// Contains information about a chunk of text from a data source in the
/// knowledge base. If the result is from a structured data source, the cell in
/// the database and the type of the value is also identified.
///
/// This data type is used in the following API operations:
///
/// * [Retrieve
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_Retrieve.html#API_agent-runtime_Retrieve_ResponseSyntax) – in the `content` field
/// * [RetrieveAndGenerate
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_RetrieveAndGenerate.html#API_agent-runtime_RetrieveAndGenerate_ResponseSyntax) – in the `content` field
/// * [InvokeAgent
///   response](https://docs.aws.amazon.com/bedrock/latest/APIReference/API_agent-runtime_InvokeAgent.html#API_agent-runtime_InvokeAgent_ResponseSyntax) – in the `content` field
pub const RetrievalResultContent = struct {
    /// Audio segment information when the retrieval result contains audio content.
    audio: ?AudioSegment = null,

    /// A data URI with base64-encoded content from the data source. The URI is in
    /// the following format: returned in the following format:
    /// `data:image/jpeg;base64,${base64-encoded string}`.
    byte_content: ?[]const u8 = null,

    /// Specifies information about the rows with the cells to return in retrieval.
    row: ?[]const RetrievalResultContentColumn = null,

    /// The cited text from the data source.
    text: []const u8 = "",

    /// The type of content in the retrieval result.
    @"type": ?RetrievalResultContentType = null,

    /// Video segment information when the retrieval result contains video content.
    video: ?VideoSegment = null,

    pub const json_field_names = .{
        .audio = "audio",
        .byte_content = "byteContent",
        .row = "row",
        .text = "text",
        .@"type" = "type",
        .video = "video",
    };
};
