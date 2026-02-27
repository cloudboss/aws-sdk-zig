/// Information about an Amazon Web Services Amazon EC2 Transit Gateway that
/// interconnects
/// virtual private clouds (VPCs) and on-premises networks.
pub const AwsEc2TransitGatewayDetails = struct {
    /// A private Autonomous System Number (ASN) for the Amazon side of a BGP
    /// session.
    amazon_side_asn: ?i32,

    /// The ID of the default association route table.
    association_default_route_table_id: ?[]const u8,

    /// Turn on or turn off automatic acceptance of attachment requests.
    auto_accept_shared_attachments: ?[]const u8,

    /// Turn on or turn off automatic association with the default association route
    /// table.
    default_route_table_association: ?[]const u8,

    /// Turn on or turn off automatic propagation of routes to the default
    /// propagation route table.
    default_route_table_propagation: ?[]const u8,

    /// The description of the transit gateway.
    description: ?[]const u8,

    /// Turn on or turn off DNS support.
    dns_support: ?[]const u8,

    /// The ID of the transit gateway.
    id: ?[]const u8,

    /// Indicates whether multicast is supported on the transit gateway.
    multicast_support: ?[]const u8,

    /// The ID of the default propagation route table.
    propagation_default_route_table_id: ?[]const u8,

    /// The transit gateway Classless Inter-Domain Routing (CIDR) blocks.
    transit_gateway_cidr_blocks: ?[]const []const u8,

    /// Turn on or turn off Equal Cost Multipath Protocol (ECMP) support.
    vpn_ecmp_support: ?[]const u8,

    pub const json_field_names = .{
        .amazon_side_asn = "AmazonSideAsn",
        .association_default_route_table_id = "AssociationDefaultRouteTableId",
        .auto_accept_shared_attachments = "AutoAcceptSharedAttachments",
        .default_route_table_association = "DefaultRouteTableAssociation",
        .default_route_table_propagation = "DefaultRouteTablePropagation",
        .description = "Description",
        .dns_support = "DnsSupport",
        .id = "Id",
        .multicast_support = "MulticastSupport",
        .propagation_default_route_table_id = "PropagationDefaultRouteTableId",
        .transit_gateway_cidr_blocks = "TransitGatewayCidrBlocks",
        .vpn_ecmp_support = "VpnEcmpSupport",
    };
};
