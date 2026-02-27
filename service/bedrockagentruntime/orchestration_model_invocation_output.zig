const Metadata = @import("metadata.zig").Metadata;
const RawResponse = @import("raw_response.zig").RawResponse;
const ReasoningContentBlock = @import("reasoning_content_block.zig").ReasoningContentBlock;

/// The foundation model output from the orchestration step.
pub const OrchestrationModelInvocationOutput = struct {
    /// Contains information about the foundation model output from the
    /// orchestration step.
    metadata: ?Metadata,

    /// Contains details of the raw response from the foundation model output.
    raw_response: ?RawResponse,

    /// Contains content about the reasoning that the model made during the
    /// orchestration step.
    reasoning_content: ?ReasoningContentBlock,

    /// The unique identifier of the trace.
    trace_id: ?[]const u8,

    pub const json_field_names = .{
        .metadata = "metadata",
        .raw_response = "rawResponse",
        .reasoning_content = "reasoningContent",
        .trace_id = "traceId",
    };
};
