const TransitGatewayAttachmentBgpConfiguration = @import("transit_gateway_attachment_bgp_configuration.zig").TransitGatewayAttachmentBgpConfiguration;
const ProtocolValue = @import("protocol_value.zig").ProtocolValue;

/// Describes the Connect peer details.
pub const TransitGatewayConnectPeerConfiguration = struct {
    /// The BGP configuration details.
    bgp_configurations: ?[]const TransitGatewayAttachmentBgpConfiguration = null,

    /// The range of interior BGP peer IP addresses.
    inside_cidr_blocks: ?[]const []const u8 = null,

    /// The Connect peer IP address on the appliance side of the tunnel.
    peer_address: ?[]const u8 = null,

    /// The tunnel protocol.
    protocol: ?ProtocolValue = null,

    /// The Connect peer IP address on the transit gateway side of the tunnel.
    transit_gateway_address: ?[]const u8 = null,
};
