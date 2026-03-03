const BgpStatus = @import("bgp_status.zig").BgpStatus;

/// The BGP configuration information.
pub const TransitGatewayAttachmentBgpConfiguration = struct {
    /// The BGP status.
    bgp_status: ?BgpStatus = null,

    /// The interior BGP peer IP address for the appliance.
    peer_address: ?[]const u8 = null,

    /// The peer Autonomous System Number (ASN).
    peer_asn: ?i64 = null,

    /// The interior BGP peer IP address for the transit gateway.
    transit_gateway_address: ?[]const u8 = null,

    /// The transit gateway Autonomous System Number (ASN).
    transit_gateway_asn: ?i64 = null,
};
