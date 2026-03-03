const AutoAcceptSharedAttachmentsValue = @import("auto_accept_shared_attachments_value.zig").AutoAcceptSharedAttachmentsValue;
const DefaultRouteTableAssociationValue = @import("default_route_table_association_value.zig").DefaultRouteTableAssociationValue;
const DefaultRouteTablePropagationValue = @import("default_route_table_propagation_value.zig").DefaultRouteTablePropagationValue;
const DnsSupportValue = @import("dns_support_value.zig").DnsSupportValue;
const MulticastSupportValue = @import("multicast_support_value.zig").MulticastSupportValue;
const SecurityGroupReferencingSupportValue = @import("security_group_referencing_support_value.zig").SecurityGroupReferencingSupportValue;
const VpnEcmpSupportValue = @import("vpn_ecmp_support_value.zig").VpnEcmpSupportValue;

/// Describes the options for a transit gateway.
pub const TransitGatewayRequestOptions = struct {
    /// A private Autonomous System Number (ASN) for the Amazon side of a BGP
    /// session.
    /// The range is 64512 to 65534 for 16-bit ASNs and 4200000000 to 4294967294 for
    /// 32-bit ASNs. The default is `64512`.
    amazon_side_asn: ?i64 = null,

    /// Enable or disable automatic acceptance of attachment requests. Disabled by
    /// default.
    auto_accept_shared_attachments: ?AutoAcceptSharedAttachmentsValue = null,

    /// Enable or disable automatic association with the default association route
    /// table. Enabled by default.
    default_route_table_association: ?DefaultRouteTableAssociationValue = null,

    /// Enable or disable automatic propagation of routes to the default propagation
    /// route table. Enabled by default.
    default_route_table_propagation: ?DefaultRouteTablePropagationValue = null,

    /// Enable or disable DNS support. Enabled by default.
    dns_support: ?DnsSupportValue = null,

    /// Indicates whether multicast is enabled on the transit gateway
    multicast_support: ?MulticastSupportValue = null,

    /// Enables you to reference a security group across VPCs attached to a transit
    /// gateway to simplify security group management.
    ///
    /// This option is disabled by default.
    ///
    /// For more information about security group referencing, see [Security group
    /// referencing](https://docs.aws.amazon.com/vpc/latest/tgw/tgw-vpc-attachments.html#vpc-attachment-security) in the *Amazon Web Services Transit Gateways Guide*.
    security_group_referencing_support: ?SecurityGroupReferencingSupportValue = null,

    /// One or more IPv4 or IPv6 CIDR blocks for the transit gateway. Must be a size
    /// /24 CIDR block or larger for IPv4, or a size /64 CIDR block or larger for
    /// IPv6.
    transit_gateway_cidr_blocks: ?[]const []const u8 = null,

    /// Enable or disable Equal Cost Multipath Protocol support. Enabled by default.
    vpn_ecmp_support: ?VpnEcmpSupportValue = null,
};
