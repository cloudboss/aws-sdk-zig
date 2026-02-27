/// If set to TRUE_PEAK, calculate and log the TruePeak for each output's audio
/// track loudness.
pub const AudioNormalizationPeakCalculation = enum {
    true_peak,
    none,

    pub const json_field_names = .{
        .true_peak = "TRUE_PEAK",
        .none = "NONE",
    };
};
