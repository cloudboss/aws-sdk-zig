const AudioNormalizationAlgorithm = @import("audio_normalization_algorithm.zig").AudioNormalizationAlgorithm;
const AudioNormalizationAlgorithmControl = @import("audio_normalization_algorithm_control.zig").AudioNormalizationAlgorithmControl;
const AudioNormalizationLoudnessLogging = @import("audio_normalization_loudness_logging.zig").AudioNormalizationLoudnessLogging;
const AudioNormalizationPeakCalculation = @import("audio_normalization_peak_calculation.zig").AudioNormalizationPeakCalculation;

/// Advanced audio normalization settings. Ignore these settings unless you need
/// to comply with a loudness standard.
pub const AudioNormalizationSettings = struct {
    /// Choose one of the following audio normalization algorithms: ITU-R BS.1770-1:
    /// Ungated loudness. A measurement of ungated average loudness for an entire
    /// piece of content, suitable for measurement of short-form content under ATSC
    /// recommendation A/85. Supports up to 5.1 audio channels. ITU-R BS.1770-2:
    /// Gated loudness. A measurement of gated average loudness compliant with the
    /// requirements of EBU-R128. Supports up to 5.1 audio channels. ITU-R
    /// BS.1770-3: Modified peak. The same loudness measurement algorithm as 1770-2,
    /// with an updated true peak measurement. ITU-R BS.1770-4: Higher channel
    /// count. Allows for more audio channels than the other algorithms, including
    /// configurations such as 7.1.
    algorithm: ?AudioNormalizationAlgorithm = null,

    /// When enabled the output audio is corrected using the chosen algorithm. If
    /// disabled, the audio will be measured but not adjusted.
    algorithm_control: ?AudioNormalizationAlgorithmControl = null,

    /// Content measuring above this level will be corrected to the target level.
    /// Content measuring below this level will not be corrected.
    correction_gate_level: ?i32 = null,

    /// If set to LOG, log each output's audio track loudness to a CSV file.
    loudness_logging: ?AudioNormalizationLoudnessLogging = null,

    /// If set to TRUE_PEAK, calculate and log the TruePeak for each output's audio
    /// track loudness.
    peak_calculation: ?AudioNormalizationPeakCalculation = null,

    /// When you use Audio normalization, optionally use this setting to specify a
    /// target loudness. If you don't specify a value here, the encoder chooses a
    /// value for you, based on the algorithm that you choose for Algorithm. If you
    /// choose algorithm 1770-1, the encoder will choose -24 LKFS; otherwise, the
    /// encoder will choose -23 LKFS.
    target_lkfs: ?f64 = null,

    /// Specify the True-peak limiter threshold in decibels relative to full scale
    /// (dBFS). The peak inter-audio sample loudness in your output will be limited
    /// to the value that you specify, without affecting the overall target LKFS.
    /// Enter a value from 0 to -8. Leave blank to use the default value 0.
    true_peak_limiter_threshold: ?f64 = null,

    pub const json_field_names = .{
        .algorithm = "Algorithm",
        .algorithm_control = "AlgorithmControl",
        .correction_gate_level = "CorrectionGateLevel",
        .loudness_logging = "LoudnessLogging",
        .peak_calculation = "PeakCalculation",
        .target_lkfs = "TargetLkfs",
        .true_peak_limiter_threshold = "TruePeakLimiterThreshold",
    };
};
