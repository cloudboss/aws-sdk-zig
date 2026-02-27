const aws = @import("aws");

const DestinationConfiguration = @import("destination_configuration.zig").DestinationConfiguration;
const RecordingConfigurationState = @import("recording_configuration_state.zig").RecordingConfigurationState;

/// Summary information about a RecordingConfiguration.
pub const RecordingConfigurationSummary = struct {
    /// Recording-configuration ARN.
    arn: []const u8,

    /// A complex type that contains information about where recorded video will be
    /// stored.
    destination_configuration: DestinationConfiguration,

    /// Recording-configuration name. The value does not need to be unique.
    name: ?[]const u8,

    /// Indicates the current state of the recording configuration. When the state
    /// is
    /// `ACTIVE`, the configuration is ready for recording a channel stream.
    state: RecordingConfigurationState,

    /// Tags attached to the resource. Array of 1-50 maps, each of the form
    /// `string:string
    /// (key:value)`. See [Best practices and
    /// strategies](https://docs.aws.amazon.com/tag-editor/latest/userguide/best-practices-and-strats.html) in *Tagging Amazon Web Services Resources and Tag Editor* for details, including restrictions that apply to tags and "Tag naming limits and requirements"; Amazon IVS has no
    /// service-specific constraints beyond what is documented there.
    tags: ?[]const aws.map.StringMapEntry,

    pub const json_field_names = .{
        .arn = "arn",
        .destination_configuration = "destinationConfiguration",
        .name = "name",
        .state = "state",
        .tags = "tags",
    };
};
