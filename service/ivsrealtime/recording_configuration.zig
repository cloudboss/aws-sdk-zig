const RecordingConfigurationFormat = @import("recording_configuration_format.zig").RecordingConfigurationFormat;
const CompositionRecordingHlsConfiguration = @import("composition_recording_hls_configuration.zig").CompositionRecordingHlsConfiguration;

/// An object representing a configuration to record a stage stream.
pub const RecordingConfiguration = struct {
    /// The recording format for storing a recording in Amazon S3.
    format: ?RecordingConfigurationFormat,

    /// An HLS configuration object to return information about how the recording
    /// will be configured.
    hls_configuration: ?CompositionRecordingHlsConfiguration,

    pub const json_field_names = .{
        .format = "format",
        .hls_configuration = "hlsConfiguration",
    };
};
