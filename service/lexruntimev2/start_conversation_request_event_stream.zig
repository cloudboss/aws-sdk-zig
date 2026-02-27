const AudioInputEvent = @import("audio_input_event.zig").AudioInputEvent;
const ConfigurationEvent = @import("configuration_event.zig").ConfigurationEvent;
const DisconnectionEvent = @import("disconnection_event.zig").DisconnectionEvent;
const DTMFInputEvent = @import("dtmf_input_event.zig").DTMFInputEvent;
const PlaybackCompletionEvent = @import("playback_completion_event.zig").PlaybackCompletionEvent;
const TextInputEvent = @import("text_input_event.zig").TextInputEvent;

/// Represents a stream of events between your application and
/// Amazon Lex V2.
pub const StartConversationRequestEventStream = union(enum) {
    /// Speech audio sent from your client application to Amazon Lex V2. Audio
    /// starts accumulating when Amazon Lex V2 identifies a voice and continues
    /// until a
    /// natural pause in the speech is found before processing.
    audio_input_event: ?AudioInputEvent,
    /// Configuration information sent from your client application to
    /// Amazon Lex V2
    configuration_event: ?ConfigurationEvent,
    /// Event sent from the client application to indicate to Amazon Lex V2 that the
    /// conversation is over.
    disconnection_event: ?DisconnectionEvent,
    /// DTMF information sent to Amazon Lex V2 by your application. Amazon Lex V2
    /// accumulates the DMTF information from when the user sends the first
    /// character and ends
    ///
    /// * when there's a pause longer that the value configured for the
    /// end timeout.
    ///
    /// * when there's a digit that is the configured end
    /// character.
    ///
    /// * when Amazon Lex V2 accumulates characters equal to the maximum DTMF
    /// character configuration.
    dtmf_input_event: ?DTMFInputEvent,
    /// Event sent from the client application to Amazon Lex V2 to indicate that it
    /// has finished playing audio and that Amazon Lex V2 should start listening for
    /// user input.
    playback_completion_event: ?PlaybackCompletionEvent,
    /// Text sent from your client application to Amazon Lex V2. Each
    /// `TextInputEvent` is processed individually.
    text_input_event: ?TextInputEvent,

    pub const json_field_names = .{
        .audio_input_event = "AudioInputEvent",
        .configuration_event = "ConfigurationEvent",
        .disconnection_event = "DisconnectionEvent",
        .dtmf_input_event = "DTMFInputEvent",
        .playback_completion_event = "PlaybackCompletionEvent",
        .text_input_event = "TextInputEvent",
    };
};
