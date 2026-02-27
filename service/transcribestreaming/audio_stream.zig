const AudioEvent = @import("audio_event.zig").AudioEvent;
const ConfigurationEvent = @import("configuration_event.zig").ConfigurationEvent;

/// An encoded stream of audio blobs. Audio streams are encoded as either HTTP/2
/// or WebSocket
/// data frames.
///
/// For more information, see [Transcribing streaming
/// audio](https://docs.aws.amazon.com/transcribe/latest/dg/streaming.html).
pub const AudioStream = union(enum) {
    /// A blob of audio from your application. Your audio stream consists of one or
    /// more audio
    /// events.
    ///
    /// For more information, see [Event stream
    /// encoding](https://docs.aws.amazon.com/transcribe/latest/dg/event-stream.html).
    audio_event: ?AudioEvent,
    /// Contains audio channel definitions and post-call analytics settings.
    configuration_event: ?ConfigurationEvent,

    pub const json_field_names = .{
        .audio_event = "AudioEvent",
        .configuration_event = "ConfigurationEvent",
    };
};
