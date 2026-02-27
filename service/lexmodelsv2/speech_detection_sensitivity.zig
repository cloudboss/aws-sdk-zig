/// Determines the sensitivity level for voice activity detection (VAD) in noisy
/// environments. This setting helps optimize speech recognition accuracy by
/// adjusting how the system responds to background noise.
///
/// Valid values include:
///
/// * `Default` - Standard sensitivity level suitable for most environments
///
/// * `HighNoiseTolerance` - Increased tolerance for moderate background noise
///
/// * `MaximumNoiseTolerance` - Maximum tolerance for high levels of background
///   noise
pub const SpeechDetectionSensitivity = enum {
    default,
    high_noise_tolerance,
    maximum_noise_tolerance,

    pub const json_field_names = .{
        .default = "Default",
        .high_noise_tolerance = "HighNoiseTolerance",
        .maximum_noise_tolerance = "MaximumNoiseTolerance",
    };
};
