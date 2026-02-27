const AudioNormalizationAlgorithm = @import("audio_normalization_algorithm.zig").AudioNormalizationAlgorithm;
const AudioNormalizationAlgorithmControl = @import("audio_normalization_algorithm_control.zig").AudioNormalizationAlgorithmControl;

/// Audio Normalization Settings
pub const AudioNormalizationSettings = struct {
    /// Audio normalization algorithm to use. itu17701 conforms to the CALM Act
    /// specification, itu17702 conforms to the EBU R-128 specification.
    algorithm: ?AudioNormalizationAlgorithm,

    /// When set to correctAudio the output audio is corrected using the chosen
    /// algorithm. If set to measureOnly, the audio will be measured but not
    /// adjusted.
    algorithm_control: ?AudioNormalizationAlgorithmControl,

    /// Target LKFS(loudness) to adjust volume to. If no value is entered, a default
    /// value will be used according to the chosen algorithm. The CALM Act
    /// recommends a target of -24 LKFS. The EBU R-128 specification recommends a
    /// target of -23 LKFS.
    target_lkfs: ?f64,

    pub const json_field_names = .{
        .algorithm = "Algorithm",
        .algorithm_control = "AlgorithmControl",
        .target_lkfs = "TargetLkfs",
    };
};
