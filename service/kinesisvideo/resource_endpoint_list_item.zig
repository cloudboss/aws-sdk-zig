const ChannelProtocol = @import("channel_protocol.zig").ChannelProtocol;

/// An object that describes the endpoint of the signaling channel returned by
/// the
/// `GetSignalingChannelEndpoint` API.
///
/// The media server endpoint will correspond to the `WEBRTC` Protocol.
pub const ResourceEndpointListItem = struct {
    /// The protocol of the signaling channel returned by the
    /// `GetSignalingChannelEndpoint` API.
    protocol: ?ChannelProtocol = null,

    /// The endpoint of the signaling channel returned by the
    /// `GetSignalingChannelEndpoint` API.
    resource_endpoint: ?[]const u8 = null,

    pub const json_field_names = .{
        .protocol = "Protocol",
        .resource_endpoint = "ResourceEndpoint",
    };
};
