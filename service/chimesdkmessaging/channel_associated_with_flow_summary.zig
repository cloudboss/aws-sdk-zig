const ChannelMode = @import("channel_mode.zig").ChannelMode;
const ChannelPrivacy = @import("channel_privacy.zig").ChannelPrivacy;

/// Summary of details of a channel associated with channel flow.
pub const ChannelAssociatedWithFlowSummary = struct {
    /// The ARN of the channel.
    channel_arn: ?[]const u8,

    /// The channel's metadata.
    metadata: ?[]const u8,

    /// The mode of the channel.
    mode: ?ChannelMode,

    /// The name of the channel flow.
    name: ?[]const u8,

    /// The channel's privacy setting.
    privacy: ?ChannelPrivacy,

    pub const json_field_names = .{
        .channel_arn = "ChannelArn",
        .metadata = "Metadata",
        .mode = "Mode",
        .name = "Name",
        .privacy = "Privacy",
    };
};
