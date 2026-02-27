const ChannelMode = @import("channel_mode.zig").ChannelMode;
const ChannelPrivacy = @import("channel_privacy.zig").ChannelPrivacy;

/// Summary of the details of a `Channel`.
pub const ChannelSummary = struct {
    /// The ARN of the channel.
    channel_arn: ?[]const u8,

    /// The time at which the last persistent message visible to the caller in a
    /// channel was sent.
    last_message_timestamp: ?i64,

    /// The metadata of the channel.
    metadata: ?[]const u8,

    /// The mode of the channel.
    mode: ?ChannelMode,

    /// The name of the channel.
    name: ?[]const u8,

    /// The privacy setting of the channel.
    privacy: ?ChannelPrivacy,

    pub const json_field_names = .{
        .channel_arn = "ChannelArn",
        .last_message_timestamp = "LastMessageTimestamp",
        .metadata = "Metadata",
        .mode = "Mode",
        .name = "Name",
        .privacy = "Privacy",
    };
};
