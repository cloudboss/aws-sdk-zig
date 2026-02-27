const Metadata = @import("metadata.zig").Metadata;
const PreProcessingParsedResponse = @import("pre_processing_parsed_response.zig").PreProcessingParsedResponse;
const RawResponse = @import("raw_response.zig").RawResponse;
const ReasoningContentBlock = @import("reasoning_content_block.zig").ReasoningContentBlock;

/// The foundation model output from the pre-processing step.
pub const PreProcessingModelInvocationOutput = struct {
    /// Contains information about the foundation model output from the
    /// pre-processing step.
    metadata: ?Metadata,

    /// Details about the response from the Lambda parsing of the output of the
    /// pre-processing step.
    parsed_response: ?PreProcessingParsedResponse,

    /// Details of the raw response from the foundation model output.
    raw_response: ?RawResponse,

    /// Contains content about the reasoning that the model made during the
    /// pre-processing step.
    reasoning_content: ?ReasoningContentBlock,

    /// The unique identifier of the trace.
    trace_id: ?[]const u8,

    pub const json_field_names = .{
        .metadata = "metadata",
        .parsed_response = "parsedResponse",
        .raw_response = "rawResponse",
        .reasoning_content = "reasoningContent",
        .trace_id = "traceId",
    };
};
