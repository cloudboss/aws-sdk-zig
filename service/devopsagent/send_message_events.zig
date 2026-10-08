const SendMessageContentBlockDeltaEvent = @import("send_message_content_block_delta_event.zig").SendMessageContentBlockDeltaEvent;
const SendMessageContentBlockStartEvent = @import("send_message_content_block_start_event.zig").SendMessageContentBlockStartEvent;
const SendMessageContentBlockStopEvent = @import("send_message_content_block_stop_event.zig").SendMessageContentBlockStopEvent;
const SendMessageHeartbeatEvent = @import("send_message_heartbeat_event.zig").SendMessageHeartbeatEvent;
const SendMessageResponseCompletedEvent = @import("send_message_response_completed_event.zig").SendMessageResponseCompletedEvent;
const SendMessageResponseCreatedEvent = @import("send_message_response_created_event.zig").SendMessageResponseCreatedEvent;
const SendMessageResponseFailedEvent = @import("send_message_response_failed_event.zig").SendMessageResponseFailedEvent;
const SendMessageResponseInProgressEvent = @import("send_message_response_in_progress_event.zig").SendMessageResponseInProgressEvent;
const SendMessageSummaryEvent = @import("send_message_summary_event.zig").SendMessageSummaryEvent;

/// Event stream for chat message responses using the content block model.
/// Events follow a lifecycle: responseCreated -> responseInProgress ->
/// (contentBlockStart/contentBlockDelta/contentBlockStop events) ->
/// responseCompleted|responseFailed SendMessage always uses content block mode
/// — legacy per-field events (outputTextDelta, functionCallArgumentsDelta,
/// etc.) are not emitted.
pub const SendMessageEvents = union(enum) {
    /// Emitted for each incremental content delta within a content block
    content_block_delta: ?SendMessageContentBlockDeltaEvent,
    /// Emitted when a new content block starts
    content_block_start: ?SendMessageContentBlockStartEvent,
    /// Emitted when a content block is complete
    content_block_stop: ?SendMessageContentBlockStopEvent,
    /// Heartbeat event sent periodically to keep the connection alive during idle
    /// periods
    heartbeat: ?SendMessageHeartbeatEvent,
    /// Emitted when the response completes successfully
    response_completed: ?SendMessageResponseCompletedEvent,
    /// Emitted when the response is created
    response_created: ?SendMessageResponseCreatedEvent,
    /// Emitted when the response fails
    response_failed: ?SendMessageResponseFailedEvent,
    /// Emitted while the response is being generated
    response_in_progress: ?SendMessageResponseInProgressEvent,
    /// Emitted to provide a summary of agent actions
    summary: ?SendMessageSummaryEvent,

    pub const json_field_names = .{
        .content_block_delta = "contentBlockDelta",
        .content_block_start = "contentBlockStart",
        .content_block_stop = "contentBlockStop",
        .heartbeat = "heartbeat",
        .response_completed = "responseCompleted",
        .response_created = "responseCreated",
        .response_failed = "responseFailed",
        .response_in_progress = "responseInProgress",
        .summary = "summary",
    };
};
