const aws = @import("aws");

const ChannelLatencyMode = @import("channel_latency_mode.zig").ChannelLatencyMode;
const TranscodePreset = @import("transcode_preset.zig").TranscodePreset;
const ChannelType = @import("channel_type.zig").ChannelType;

/// Summary information about a channel.
pub const ChannelSummary = struct {
    /// ARN of the ad configuration associated with the channel.
    ad_configuration_arn: ?[]const u8 = null,

    /// Channel ARN.
    arn: ?[]const u8 = null,

    /// Whether the channel is private (enabled for playback authorization).
    /// Default: `false`.
    authorized: bool = false,

    /// Whether the channel allows insecure RTMP ingest. Default: `false`.
    insecure_ingest: bool = false,

    /// Channel latency mode. Use `NORMAL` to broadcast and deliver live video up to
    /// Full HD. Use `LOW` for near-real-time interaction with viewers. Default:
    /// `LOW`.
    latency_mode: ?ChannelLatencyMode = null,

    /// Channel name.
    name: ?[]const u8 = null,

    /// Playback-restriction-policy ARN. A valid ARN value here both specifies the
    /// ARN and enables playback restriction. Default: "" (empty string, no playback
    /// restriction policy is applied).
    playback_restriction_policy_arn: ?[]const u8 = null,

    /// Optional transcode preset for the channel. This is selectable only for
    /// `ADVANCED_HD` and `ADVANCED_SD` channel types. For those channel types, the
    /// default `preset` is `HIGHER_BANDWIDTH_DELIVERY`. For other channel types
    /// (`BASIC` and `STANDARD`), `preset` is the empty string (`""`).
    preset: ?TranscodePreset = null,

    /// Recording-configuration ARN. A valid ARN value here both specifies the ARN
    /// and enables recording. Default: "" (empty string, recording is disabled).
    recording_configuration_arn: ?[]const u8 = null,

    /// Tags attached to the resource. Array of 1-50 maps, each of the form
    /// `string:string (key:value)`. See [Best practices and
    /// strategies](https://docs.aws.amazon.com/tag-editor/latest/userguide/best-practices-and-strats.html) in *Tagging Amazon Web Services Resources and Tag Editor* for details, including restrictions that apply to tags and "Tag naming limits and requirements"; Amazon IVS has no service-specific constraints beyond what is documented there.
    tags: ?[]const aws.map.StringMapEntry = null,

    /// Channel type, which determines the allowable resolution and bitrate. *If you
    /// exceed the allowable input resolution or bitrate, the stream probably will
    /// disconnect immediately.* Default: `STANDARD`. For details, see [Channel
    /// Types](https://docs.aws.amazon.com/ivs/latest/LowLatencyAPIReference/channel-types.html).
    @"type": ?ChannelType = null,

    pub const json_field_names = .{
        .ad_configuration_arn = "adConfigurationArn",
        .arn = "arn",
        .authorized = "authorized",
        .insecure_ingest = "insecureIngest",
        .latency_mode = "latencyMode",
        .name = "name",
        .playback_restriction_policy_arn = "playbackRestrictionPolicyArn",
        .preset = "preset",
        .recording_configuration_arn = "recordingConfigurationArn",
        .tags = "tags",
        .@"type" = "type",
    };
};
