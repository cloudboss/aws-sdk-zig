const VpnState = @import("vpn_state.zig").VpnState;
const Tag = @import("tag.zig").Tag;
const GatewayType = @import("gateway_type.zig").GatewayType;
const VpcAttachment = @import("vpc_attachment.zig").VpcAttachment;

/// Describes a virtual private gateway.
pub const VpnGateway = struct {
    /// The private Autonomous System Number (ASN) for the Amazon side of a BGP
    /// session.
    amazon_side_asn: ?i64 = null,

    /// The Availability Zone where the virtual private gateway was created, if
    /// applicable.
    /// This field may be empty or not returned.
    availability_zone: ?[]const u8 = null,

    /// The current state of the virtual private gateway.
    state: ?VpnState = null,

    /// Any tags assigned to the virtual private gateway.
    tags: ?[]const Tag = null,

    /// The type of VPN connection the virtual private gateway supports.
    @"type": ?GatewayType = null,

    /// Any VPCs attached to the virtual private gateway.
    vpc_attachments: ?[]const VpcAttachment = null,

    /// The ID of the virtual private gateway.
    vpn_gateway_id: ?[]const u8 = null,
};
