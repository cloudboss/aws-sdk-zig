const AutoAcceptSharedAttachmentsValue = @import("auto_accept_shared_attachments_value.zig").AutoAcceptSharedAttachmentsValue;
const DefaultRouteTableAssociationValue = @import("default_route_table_association_value.zig").DefaultRouteTableAssociationValue;
const DefaultRouteTablePropagationValue = @import("default_route_table_propagation_value.zig").DefaultRouteTablePropagationValue;
const DnsSupportValue = @import("dns_support_value.zig").DnsSupportValue;
const EncryptionSupport = @import("encryption_support.zig").EncryptionSupport;
const MulticastSupportValue = @import("multicast_support_value.zig").MulticastSupportValue;
const SecurityGroupReferencingSupportValue = @import("security_group_referencing_support_value.zig").SecurityGroupReferencingSupportValue;
const VpnEcmpSupportValue = @import("vpn_ecmp_support_value.zig").VpnEcmpSupportValue;

/// Describes the options for a transit gateway.
pub const TransitGatewayOptions = struct {
    /// A private Autonomous System Number (ASN) for the Amazon side of a BGP
    /// session.
    /// The range is 64512 to 65534 for 16-bit ASNs and 4200000000 to 4294967294 for
    /// 32-bit ASNs.
    amazon_side_asn: ?i64,

    /// The ID of the default association route table.
    association_default_route_table_id: ?[]const u8,

    /// Indicates whether attachment requests are automatically accepted.
    auto_accept_shared_attachments: ?AutoAcceptSharedAttachmentsValue,

    /// Indicates whether resource attachments are automatically associated with the
    /// default
    /// association route table. Enabled by default. Either
    /// `defaultRouteTableAssociation` or `defaultRouteTablePropagation` must be set
    /// to `enable` for Amazon Web Services Transit Gateway to create the default
    /// transit gateway route table.
    default_route_table_association: ?DefaultRouteTableAssociationValue,

    /// Indicates whether resource attachments automatically propagate routes to the
    /// default
    /// propagation route table. Enabled by default. If
    /// `defaultRouteTablePropagation`
    /// is set to `enable`,
    /// Amazon Web Services Transit Gateway creates the default transit gateway
    /// route
    /// table.
    default_route_table_propagation: ?DefaultRouteTablePropagationValue,

    /// Indicates whether DNS support is enabled.
    dns_support: ?DnsSupportValue,

    /// Defines if the Transit Gateway supports VPC Encryption Control.
    encryption_support: ?EncryptionSupport,

    /// Indicates whether multicast is enabled on the transit gateway
    multicast_support: ?MulticastSupportValue,

    /// The ID of the default propagation route table.
    propagation_default_route_table_id: ?[]const u8,

    /// Enables you to reference a security group across VPCs attached to a transit
    /// gateway to simplify security group management.
    ///
    /// This option is disabled by default.
    security_group_referencing_support: ?SecurityGroupReferencingSupportValue,

    /// The transit gateway CIDR blocks.
    transit_gateway_cidr_blocks: ?[]const []const u8,

    /// Indicates whether Equal Cost Multipath Protocol support is enabled.
    vpn_ecmp_support: ?VpnEcmpSupportValue,
};
