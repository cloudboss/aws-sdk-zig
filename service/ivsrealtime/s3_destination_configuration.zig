const RecordingConfiguration = @import("recording_configuration.zig").RecordingConfiguration;
const CompositionThumbnailConfiguration = @import("composition_thumbnail_configuration.zig").CompositionThumbnailConfiguration;

/// A complex type that describes an S3 location where recorded videos will be
/// stored.
pub const S3DestinationConfiguration = struct {
    /// ARNs of the EncoderConfiguration resource. The encoder configuration
    /// and stage resources must be in the same AWS account and region.
    encoder_configuration_arns: []const []const u8,

    /// Array of maps, each of the form `string:string (key:value)`. This is an
    /// optional customer specification, currently used only to specify the
    /// recording format for
    /// storing a recording in Amazon S3.
    recording_configuration: ?RecordingConfiguration,

    /// ARN of the StorageConfiguration where recorded videos will be
    /// stored.
    storage_configuration_arn: []const u8,

    /// A complex type that allows you to enable/disable the recording of thumbnails
    /// for a Composition and modify the interval at which thumbnails are generated
    /// for
    /// the live session.
    thumbnail_configurations: ?[]const CompositionThumbnailConfiguration,

    pub const json_field_names = .{
        .encoder_configuration_arns = "encoderConfigurationArns",
        .recording_configuration = "recordingConfiguration",
        .storage_configuration_arn = "storageConfigurationArn",
        .thumbnail_configurations = "thumbnailConfigurations",
    };
};
