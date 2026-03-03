const aws = @import("aws");

const DestinationConfiguration = @import("destination_configuration.zig").DestinationConfiguration;
const RenditionConfiguration = @import("rendition_configuration.zig").RenditionConfiguration;
const RecordingConfigurationState = @import("recording_configuration_state.zig").RecordingConfigurationState;
const ThumbnailConfiguration = @import("thumbnail_configuration.zig").ThumbnailConfiguration;

/// An object representing a configuration to record a channel stream.
pub const RecordingConfiguration = struct {
    /// Recording-configuration ARN.
    arn: []const u8,

    /// A complex type that contains information about where recorded video will be
    /// stored.
    destination_configuration: DestinationConfiguration,

    /// Recording-configuration name. The value does not need to be unique.
    name: ?[]const u8 = null,

    /// If a broadcast disconnects and then reconnects within the specified
    /// interval, the multiple
    /// streams will be considered a single broadcast and merged together. Default:
    /// 0.
    recording_reconnect_window_seconds: i32 = 0,

    /// Object that describes which renditions should be recorded for a stream.
    rendition_configuration: ?RenditionConfiguration = null,

    /// Indicates the current state of the recording configuration. When the state
    /// is
    /// `ACTIVE`, the configuration is ready for recording a channel stream.
    state: RecordingConfigurationState,

    /// Tags attached to the resource. Array of 1-50 maps, each of the form
    /// `string:string
    /// (key:value)`. See [Best practices and
    /// strategies](https://docs.aws.amazon.com/tag-editor/latest/userguide/best-practices-and-strats.html) in *Tagging Amazon Web Services Resources and Tag Editor* for details, including restrictions that apply to tags and "Tag naming limits and requirements"; Amazon IVS has no
    /// service-specific constraints beyond what is documented there.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// A complex type that allows you to enable/disable the recording of thumbnails
    /// for a live
    /// session and modify the interval at which thumbnails are generated for the
    /// live session.
    thumbnail_configuration: ?ThumbnailConfiguration = null,

    pub const json_field_names = .{
        .arn = "arn",
        .destination_configuration = "destinationConfiguration",
        .name = "name",
        .recording_reconnect_window_seconds = "recordingReconnectWindowSeconds",
        .rendition_configuration = "renditionConfiguration",
        .state = "state",
        .tags = "tags",
        .thumbnail_configuration = "thumbnailConfiguration",
    };
};
