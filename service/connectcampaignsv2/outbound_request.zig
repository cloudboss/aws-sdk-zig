const ChannelSubtypeParameters = @import("channel_subtype_parameters.zig").ChannelSubtypeParameters;

/// An outbound request for a campaign.
pub const OutboundRequest = struct {
    channel_subtype_parameters: ChannelSubtypeParameters,

    client_token: []const u8,

    expiration_time: i64,

    pub const json_field_names = .{
        .channel_subtype_parameters = "channelSubtypeParameters",
        .client_token = "clientToken",
        .expiration_time = "expirationTime",
    };
};
