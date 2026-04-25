const CloseStreamEvent = @import("close_stream_event.zig").CloseStreamEvent;
const TextEvent = @import("text_event.zig").TextEvent;

/// Inbound event stream for sending input and control events to manage
/// bidirectional speech synthesis.
pub const StartSpeechSynthesisStreamActionStream = union(enum) {
    /// An event indicating the end of the input stream.
    close_stream_event: ?CloseStreamEvent,
    /// A text event containing content to be synthesized.
    text_event: ?TextEvent,

    pub const json_field_names = .{
        .close_stream_event = "CloseStreamEvent",
        .text_event = "TextEvent",
    };
};
