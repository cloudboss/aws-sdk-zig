const Identity = @import("identity.zig").Identity;
const ElasticChannelConfiguration = @import("elastic_channel_configuration.zig").ElasticChannelConfiguration;
const ExpirationSettings = @import("expiration_settings.zig").ExpirationSettings;
const ChannelMode = @import("channel_mode.zig").ChannelMode;
const ChannelPrivacy = @import("channel_privacy.zig").ChannelPrivacy;

/// The details of a channel.
pub const Channel = struct {
    /// The ARN of a channel.
    channel_arn: ?[]const u8,

    /// The ARN of the channel flow.
    channel_flow_arn: ?[]const u8,

    /// The `AppInstanceUser` who created the channel.
    created_by: ?Identity,

    /// The time at which the `AppInstanceUser` created the channel.
    created_timestamp: ?i64,

    /// The attributes required to configure and create an elastic channel. An
    /// elastic channel can support a maximum of 1-million members.
    elastic_channel_configuration: ?ElasticChannelConfiguration,

    /// Settings that control when a channel expires.
    expiration_settings: ?ExpirationSettings,

    /// The time at which a member sent the last message in the channel.
    last_message_timestamp: ?i64,

    /// The time at which a channel was last updated.
    last_updated_timestamp: ?i64,

    /// The channel's metadata.
    metadata: ?[]const u8,

    /// The mode of the channel.
    mode: ?ChannelMode,

    /// The name of a channel.
    name: ?[]const u8,

    /// The channel's privacy setting.
    privacy: ?ChannelPrivacy,

    pub const json_field_names = .{
        .channel_arn = "ChannelArn",
        .channel_flow_arn = "ChannelFlowArn",
        .created_by = "CreatedBy",
        .created_timestamp = "CreatedTimestamp",
        .elastic_channel_configuration = "ElasticChannelConfiguration",
        .expiration_settings = "ExpirationSettings",
        .last_message_timestamp = "LastMessageTimestamp",
        .last_updated_timestamp = "LastUpdatedTimestamp",
        .metadata = "Metadata",
        .mode = "Mode",
        .name = "Name",
        .privacy = "Privacy",
    };
};
