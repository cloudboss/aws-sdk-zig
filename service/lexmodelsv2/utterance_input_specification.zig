const UtteranceAudioInputSpecification = @import("utterance_audio_input_specification.zig").UtteranceAudioInputSpecification;

/// Contains information about input of an utterance.
pub const UtteranceInputSpecification = struct {
    /// Contains information about the audio input for an utterance.
    audio_input: ?UtteranceAudioInputSpecification,

    /// A text input transcription of the utterance. It is only applicable for
    /// test-sets containing text data.
    text_input: ?[]const u8,

    pub const json_field_names = .{
        .audio_input = "audioInput",
        .text_input = "textInput",
    };
};
