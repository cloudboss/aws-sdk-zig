const Metadata = @import("metadata.zig").Metadata;
const PostProcessingParsedResponse = @import("post_processing_parsed_response.zig").PostProcessingParsedResponse;
const RawResponse = @import("raw_response.zig").RawResponse;
const ReasoningContentBlock = @import("reasoning_content_block.zig").ReasoningContentBlock;

/// The foundation model output from the post-processing step.
pub const PostProcessingModelInvocationOutput = struct {
    /// Contains information about the foundation model output from the
    /// post-processing step.
    metadata: ?Metadata = null,

    /// Details about the response from the Lambda parsing of the output of the
    /// post-processing step.
    parsed_response: ?PostProcessingParsedResponse = null,

    /// Details of the raw response from the foundation model output.
    raw_response: ?RawResponse = null,

    /// Contains content about the reasoning that the model made during the
    /// post-processing step.
    reasoning_content: ?ReasoningContentBlock = null,

    /// The unique identifier of the trace.
    trace_id: ?[]const u8 = null,

    pub const json_field_names = .{
        .metadata = "metadata",
        .parsed_response = "parsedResponse",
        .raw_response = "rawResponse",
        .reasoning_content = "reasoningContent",
        .trace_id = "traceId",
    };
};
