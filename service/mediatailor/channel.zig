const aws = @import("aws");

const SlateSource = @import("slate_source.zig").SlateSource;
const LogConfigurationForChannel = @import("log_configuration_for_channel.zig").LogConfigurationForChannel;
const ResponseOutputItem = @import("response_output_item.zig").ResponseOutputItem;

/// The configuration parameters for a channel. For information about
/// MediaTailor channels, see [Working with
/// channels](https://docs.aws.amazon.com/mediatailor/latest/ug/channel-assembly-channels.html) in the *MediaTailor User Guide*.
pub const Channel = struct {
    /// The ARN of the channel.
    arn: []const u8,

    /// The list of audiences defined in channel.
    audiences: ?[]const []const u8 = null,

    /// The name of the channel.
    channel_name: []const u8,

    /// Returns the state whether the channel is running or not.
    channel_state: []const u8,

    /// The timestamp of when the channel was created.
    creation_time: ?i64 = null,

    /// The slate used to fill gaps between programs in the schedule. You must
    /// configure filler slate if your channel uses the `LINEAR` `PlaybackMode`.
    /// MediaTailor doesn't support filler slate for channels using the `LOOP`
    /// `PlaybackMode`.
    filler_slate: ?SlateSource = null,

    /// The timestamp of when the channel was last modified.
    last_modified_time: ?i64 = null,

    /// The log configuration.
    log_configuration: LogConfigurationForChannel,

    /// The channel's output properties.
    outputs: []const ResponseOutputItem,

    /// The type of playback mode for this channel.
    ///
    /// `LINEAR` - Programs play back-to-back only once.
    ///
    /// `LOOP` - Programs play back-to-back in an endless loop. When the last
    /// program in the schedule plays, playback loops back to the first program in
    /// the schedule.
    playback_mode: []const u8,

    /// The tags to assign to the channel. Tags are key-value pairs that you can
    /// associate with Amazon resources to help with organization, access control,
    /// and cost tracking. For more information, see [Tagging AWS Elemental
    /// MediaTailor
    /// Resources](https://docs.aws.amazon.com/mediatailor/latest/ug/tagging.html).
    tags: ?[]const aws.map.StringMapEntry = null,

    /// The tier for this channel. STANDARD tier channels can contain live programs.
    tier: []const u8,

    pub const json_field_names = .{
        .arn = "Arn",
        .audiences = "Audiences",
        .channel_name = "ChannelName",
        .channel_state = "ChannelState",
        .creation_time = "CreationTime",
        .filler_slate = "FillerSlate",
        .last_modified_time = "LastModifiedTime",
        .log_configuration = "LogConfiguration",
        .outputs = "Outputs",
        .playback_mode = "PlaybackMode",
        .tags = "Tags",
        .tier = "Tier",
    };
};
