/// Audio Normalization Algorithm Control
pub const AudioNormalizationAlgorithmControl = enum {
    correct_audio,

    pub const json_field_names = .{
        .correct_audio = "CORRECT_AUDIO",
    };
};
