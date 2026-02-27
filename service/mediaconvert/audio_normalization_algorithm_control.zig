/// When enabled the output audio is corrected using the chosen algorithm. If
/// disabled, the audio will be measured but not adjusted.
pub const AudioNormalizationAlgorithmControl = enum {
    correct_audio,
    measure_only,

    pub const json_field_names = .{
        .correct_audio = "CORRECT_AUDIO",
        .measure_only = "MEASURE_ONLY",
    };
};
