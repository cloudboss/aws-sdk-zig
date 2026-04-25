const aws = @import("aws");

const MediaTailorPlaybackConfiguration = @import("media_tailor_playback_configuration.zig").MediaTailorPlaybackConfiguration;

/// Summary information about an ad configuration.
pub const AdConfigurationSummary = struct {
    /// Ad configuration ARN.
    arn: []const u8,

    /// List of integration configurations with media tailor resources.
    media_tailor_playback_configurations: []const MediaTailorPlaybackConfiguration,

    /// Ad configuration name. Defaults to “”.
    name: ?[]const u8 = null,

    /// Tags attached to the resource. Array of 1-50 maps, each of the form
    /// `string:string (key:value)`. See [Best practices and
    /// strategies](https://docs.aws.amazon.com/tag-editor/latest/userguide/best-practices-and-strats.html) in *Tagging Amazon Web Services Resources and Tag Editor* for details, including restrictions that apply to tags and "Tag naming limits and requirements"; Amazon IVS has no service-specific constraints beyond what is documented there.
    tags: ?[]const aws.map.StringMapEntry = null,

    pub const json_field_names = .{
        .arn = "arn",
        .media_tailor_playback_configurations = "mediaTailorPlaybackConfigurations",
        .name = "name",
        .tags = "tags",
    };
};
