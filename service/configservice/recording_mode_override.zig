const RecordingFrequency = @import("recording_frequency.zig").RecordingFrequency;
const ResourceType = @import("resource_type.zig").ResourceType;

/// An object for you to specify your overrides for the recording mode.
pub const RecordingModeOverride = struct {
    /// A description that you provide for the override.
    description: ?[]const u8,

    /// The recording frequency that will be applied to all the resource types
    /// specified in the override.
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
    recording_frequency: RecordingFrequency,

    /// A comma-separated list that specifies which resource types Config
    /// includes in the override.
    ///
    /// Daily recording cannot be specified for the following resource types:
    ///
    /// * `AWS::Config::ResourceCompliance`
    ///
    /// * `AWS::Config::ConformancePackCompliance`
    ///
    /// * `AWS::Config::ConfigurationRecorder`
    resource_types: []const ResourceType,

    pub const json_field_names = .{
        .description = "description",
        .recording_frequency = "recordingFrequency",
        .resource_types = "resourceTypes",
    };
};
