const AudioNormalizationAlgorithm = @import("audio_normalization_algorithm.zig").AudioNormalizationAlgorithm;
const AudioNormalizationAlgorithmControl = @import("audio_normalization_algorithm_control.zig").AudioNormalizationAlgorithmControl;
const AudioNormalizationPeakCalculation = @import("audio_normalization_peak_calculation.zig").AudioNormalizationPeakCalculation;

/// Audio Normalization Settings
pub const AudioNormalizationSettings = struct {
    /// Choose one of the following audio normalization algorithms:
    ///
    /// ITU-R BS.1770-1: Ungated loudness. A measurement of ungated average loudness
    /// for an entire piece of content,
    /// suitable for measurement of short-form content under ATSC recommendation
    /// A/85. Supports up to 5.1 audio channels.
    ///
    /// ITU-R BS.1770-2: Gated loudness. A measurement of gated average loudness
    /// compliant with the requirements of
    /// EBU-R128. Supports up to 5.1 audio channels.
    ///
    /// ITU-R BS.1770-3: Modified peak. The same loudness measurement algorithm as
    /// 1770-2, with an updated true peak
    /// measurement.
    ///
    /// ITU-R BS.1770-4: Higher channel count. Allows for more audio channels than
    /// the other algorithms, including
    /// configurations such as 7.1.
    algorithm: ?AudioNormalizationAlgorithm = null,

    /// When set to correctAudio the output audio is corrected using the chosen
    /// algorithm. If set to measureOnly, the audio will be measured but not
    /// adjusted.
    algorithm_control: ?AudioNormalizationAlgorithmControl = null,

    /// If set to TRUE_PEAK, calculate the TruePeak for each output's audio track
    /// loudness.
    peak_calculation: ?AudioNormalizationPeakCalculation = null,

    /// Peak limiter threshold in decibels relative to true peak (dBTP) if TRUE_PEAK
    /// is enabled.
    /// If TRUE_PEAK is not enabled a full scale (dbFS) value is used.
    /// The peak inter-audio sample loudness in your output will be limited to the
    /// value that you specify,
    /// without affecting the overall target LKFS. Leave blank to use the default
    /// value 0.
    peak_limiter_threshold: ?f64 = null,

    /// Target LKFS(loudness) to adjust volume to. If no value is entered, a default
    /// value will be used according to the chosen algorithm. The CALM Act
    /// recommends a target of -24 LKFS. The EBU R-128 specification recommends a
    /// target of -23 LKFS.
    target_lkfs: ?f64 = null,

    pub const json_field_names = .{
        .algorithm = "Algorithm",
        .algorithm_control = "AlgorithmControl",
        .peak_calculation = "PeakCalculation",
        .peak_limiter_threshold = "PeakLimiterThreshold",
        .target_lkfs = "TargetLkfs",
    };
};
