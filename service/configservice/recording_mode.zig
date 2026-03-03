const RecordingFrequency = @import("recording_frequency.zig").RecordingFrequency;
const RecordingModeOverride = @import("recording_mode_override.zig").RecordingModeOverride;

/// Specifies the default recording frequency that Config uses to record
/// configuration changes.
///
/// Config supports *Continuous recording* and *Daily recording*.
///
/// * Continuous recording allows you to record configuration changes
///   continuously whenever a change occurs.
///
/// * Daily recording allows you to receive a configuration item (CI)
///   representing the most recent state of your resources over the last 24-hour
///   period, only if it’s different from the previous CI recorded.
///
/// Firewall Manager depends on continuous recording to monitor your resources.
/// If you are using Firewall Manager,
/// it is recommended that you set the recording frequency to Continuous.
///
/// You can also override the recording frequency for specific resource types.
pub const RecordingMode = struct {
    /// The default recording frequency that Config uses to record configuration
    /// changes.
    ///
    /// Daily recording cannot be specified for the following resource types:
    ///
    /// * `AWS::Config::ResourceCompliance`
    ///
    /// * `AWS::Config::ConformancePackCompliance`
    ///
    /// * `AWS::Config::ConfigurationRecorder`
    ///
    /// For the **allSupported** (`ALL_SUPPORTED_RESOURCE_TYPES`) recording
    /// strategy, these resource types will be set to Continuous recording.
    recording_frequency: RecordingFrequency,

    /// An array of `recordingModeOverride` objects for you to specify your
    /// overrides for the recording mode.
    /// The `recordingModeOverride` object in the `recordingModeOverrides` array
    /// consists of three fields: a `description`, the new `recordingFrequency`, and
    /// an array of `resourceTypes` to override.
    recording_mode_overrides: ?[]const RecordingModeOverride = null,

    pub const json_field_names = .{
        .recording_frequency = "recordingFrequency",
        .recording_mode_overrides = "recordingModeOverrides",
    };
};
