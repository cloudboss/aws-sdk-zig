const AutoAcceptSharedAttachmentsValue = @import("auto_accept_shared_attachments_value.zig").AutoAcceptSharedAttachmentsValue;
const DefaultRouteTableAssociationValue = @import("default_route_table_association_value.zig").DefaultRouteTableAssociationValue;
const DefaultRouteTablePropagationValue = @import("default_route_table_propagation_value.zig").DefaultRouteTablePropagationValue;
const DnsSupportValue = @import("dns_support_value.zig").DnsSupportValue;
const EncryptionSupportOptionValue = @import("encryption_support_option_value.zig").EncryptionSupportOptionValue;
const SecurityGroupReferencingSupportValue = @import("security_group_referencing_support_value.zig").SecurityGroupReferencingSupportValue;
const VpnEcmpSupportValue = @import("vpn_ecmp_support_value.zig").VpnEcmpSupportValue;

/// The transit gateway options.
pub const ModifyTransitGatewayOptions = struct {
    /// Adds IPv4 or IPv6 CIDR blocks for the transit gateway. Must be a size /24
    /// CIDR block or larger for IPv4, or a size /64 CIDR block or larger for IPv6.
    add_transit_gateway_cidr_blocks: ?[]const []const u8,

    /// A private Autonomous System Number (ASN) for the Amazon side of a BGP
    /// session.
    /// The range is 64512 to 65534 for 16-bit ASNs and 4200000000 to 4294967294 for
    /// 32-bit ASNs.
    ///
    /// The modify ASN operation is not allowed on a transit gateway if it has the
    /// following attachments:
    ///
    /// * Dynamic VPN
    ///
    /// * Static VPN
    ///
    /// * Direct Connect Gateway
    ///
    /// * Connect
    ///
    /// You must first delete all transit gateway attachments configured prior to
    /// modifying the ASN on
    /// the transit gateway.
    amazon_side_asn: ?i64,

    /// The ID of the default association route table.
    association_default_route_table_id: ?[]const u8,

    /// Enable or disable automatic acceptance of attachment requests.
    auto_accept_shared_attachments: ?AutoAcceptSharedAttachmentsValue,

    /// Enable or disable automatic association with the default association route
    /// table.
    default_route_table_association: ?DefaultRouteTableAssociationValue,

    /// Indicates whether resource attachments automatically propagate routes to the
    /// default
    /// propagation route table. Enabled by default. If
    /// `defaultRouteTablePropagation`
    /// is set to `enable`,
    /// Amazon Web Services Transit Gateway will create the default transit gateway
    /// route
    /// table.
    default_route_table_propagation: ?DefaultRouteTablePropagationValue,

    /// Enable or disable DNS support.
    dns_support: ?DnsSupportValue,

    /// Enable or disable encryption support for VPC Encryption Control.
    encryption_support: ?EncryptionSupportOptionValue,

    /// The ID of the default propagation route table.
    propagation_default_route_table_id: ?[]const u8,

    /// Removes CIDR blocks for the transit gateway.
    remove_transit_gateway_cidr_blocks: ?[]const []const u8,

    /// Enables you to reference a security group across VPCs attached to a transit
    /// gateway to simplify security group management.
    ///
    /// This option is disabled by default.
    ///
    /// For more information about security group referencing, see [Security group
    /// referencing](https://docs.aws.amazon.com/vpc/latest/tgw/tgw-vpc-attachments.html#vpc-attachment-security) in the *Amazon Web Services Transit Gateways Guide*.
    security_group_referencing_support: ?SecurityGroupReferencingSupportValue,

    /// Enable or disable Equal Cost Multipath Protocol support.
    vpn_ecmp_support: ?VpnEcmpSupportValue,
};
