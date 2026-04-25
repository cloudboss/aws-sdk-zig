const HarnessContentBlockDeltaEvent = @import("harness_content_block_delta_event.zig").HarnessContentBlockDeltaEvent;
const HarnessContentBlockStartEvent = @import("harness_content_block_start_event.zig").HarnessContentBlockStartEvent;
const HarnessContentBlockStopEvent = @import("harness_content_block_stop_event.zig").HarnessContentBlockStopEvent;
const InternalServerException = @import("errors.zig").InternalServerException;
const HarnessMessageStartEvent = @import("harness_message_start_event.zig").HarnessMessageStartEvent;
const HarnessMessageStopEvent = @import("harness_message_stop_event.zig").HarnessMessageStopEvent;
const HarnessMetadataEvent = @import("harness_metadata_event.zig").HarnessMetadataEvent;
const RuntimeClientError = @import("errors.zig").RuntimeClientError;
const ValidationException = @import("errors.zig").ValidationException;

/// The streaming events returned by a harness invocation.
pub const InvokeHarnessStreamOutput = union(enum) {
    /// A delta update to the current content block.
    content_block_delta: ?HarnessContentBlockDeltaEvent,
    /// Indicates the start of a new content block.
    content_block_start: ?HarnessContentBlockStartEvent,
    /// Indicates the end of the current content block.
    content_block_stop: ?HarnessContentBlockStopEvent,
    internal_server_exception: ?InternalServerException,
    /// Indicates the start of a new message from the agent.
    message_start: ?HarnessMessageStartEvent,
    /// Indicates the end of the current message.
    message_stop: ?HarnessMessageStopEvent,
    /// Token usage and latency metrics for the invocation.
    metadata: ?HarnessMetadataEvent,
    runtime_client_error: ?RuntimeClientError,
    validation_exception: ?ValidationException,

    pub const json_field_names = .{
        .content_block_delta = "contentBlockDelta",
        .content_block_start = "contentBlockStart",
        .content_block_stop = "contentBlockStop",
        .internal_server_exception = "internalServerException",
        .message_start = "messageStart",
        .message_stop = "messageStop",
        .metadata = "metadata",
        .runtime_client_error = "runtimeClientError",
        .validation_exception = "validationException",
    };
};
