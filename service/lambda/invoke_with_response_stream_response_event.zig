const InvokeWithResponseStreamCompleteEvent = @import("invoke_with_response_stream_complete_event.zig").InvokeWithResponseStreamCompleteEvent;
const InvokeResponseStreamUpdate = @import("invoke_response_stream_update.zig").InvokeResponseStreamUpdate;

/// An object that includes a chunk of the response payload. When the stream has
/// ended, Lambda includes a `InvokeComplete` object.
pub const InvokeWithResponseStreamResponseEvent = union(enum) {
    /// An object that's returned when the stream has ended and all the payload
    /// chunks have been returned.
    invoke_complete: ?InvokeWithResponseStreamCompleteEvent,
    /// A chunk of the streamed response payload.
    payload_chunk: ?InvokeResponseStreamUpdate,

    pub const json_field_names = .{
        .invoke_complete = "InvokeComplete",
        .payload_chunk = "PayloadChunk",
    };
};
