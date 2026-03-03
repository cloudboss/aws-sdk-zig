const ChannelProtocol = @import("channel_protocol.zig").ChannelProtocol;
const ChannelRole = @import("channel_role.zig").ChannelRole;

/// An object that contains the endpoint configuration for the `SINGLE_MASTER`
/// channel type.
pub const SingleMasterChannelEndpointConfiguration = struct {
    /// This property is used to determine the nature of communication over this
    /// `SINGLE_MASTER` signaling channel. If `WSS` is specified, this
    /// API returns a websocket endpoint. If `HTTPS` is specified, this API returns
    /// an `HTTPS` endpoint.
    protocols: ?[]const ChannelProtocol = null,

    /// This property is used to determine messaging permissions in this
    /// `SINGLE_MASTER` signaling channel. If `MASTER` is specified,
    /// this API returns an endpoint that a client can use to receive offers from
    /// and send
    /// answers to any of the viewers on this signaling channel. If `VIEWER` is
    /// specified, this API returns an endpoint that a client can use only to send
    /// offers to
    /// another `MASTER` client on this signaling channel.
    role: ?ChannelRole = null,

    pub const json_field_names = .{
        .protocols = "Protocols",
        .role = "Role",
    };
};
