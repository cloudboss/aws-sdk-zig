const AudioSpecification = @import("audio_specification.zig").AudioSpecification;
const DTMFSpecification = @import("dtmf_specification.zig").DTMFSpecification;

/// Specifies the audio and DTMF input specification.
pub const AudioAndDTMFInputSpecification = struct {
    /// Specifies the settings on audio input.
    audio_specification: ?AudioSpecification = null,

    /// Specifies the settings on DTMF input.
    dtmf_specification: ?DTMFSpecification = null,

    /// Time for which a bot waits before assuming that the customer isn't going to
    /// speak or press
    /// a key. This timeout is shared between Audio and DTMF inputs.
    start_timeout_ms: i32,

    pub const json_field_names = .{
        .audio_specification = "audioSpecification",
        .dtmf_specification = "dtmfSpecification",
        .start_timeout_ms = "startTimeoutMs",
    };
};
