/// Provides details about the routes in the route table.
pub const RouteSetDetails = struct {
    /// The ID of the carrier gateway.
    carrier_gateway_id: ?[]const u8,

    /// The Amazon Resource Name (ARN) of the core network.
    core_network_arn: ?[]const u8,

    /// The IPv4 CIDR block used for the destination match.
    destination_cidr_block: ?[]const u8,

    /// The IPv6 CIDR block used for the destination match.
    destination_ipv_6_cidr_block: ?[]const u8,

    /// The prefix of the destination Amazon Web Services service.
    destination_prefix_list_id: ?[]const u8,

    /// The ID of the egress-only internet gateway.
    egress_only_internet_gateway_id: ?[]const u8,

    /// The ID of a gateway attached to your VPC.
    gateway_id: ?[]const u8,

    /// The ID of a NAT instance in your VPC.
    instance_id: ?[]const u8,

    /// The ID of the Amazon Web Services account that owns the instance.
    instance_owner_id: ?[]const u8,

    /// The ID of the local gateway.
    local_gateway_id: ?[]const u8,

    /// The ID of a NAT gateway.
    nat_gateway_id: ?[]const u8,

    /// The ID of the network interface.
    network_interface_id: ?[]const u8,

    /// Describes how the route was created.
    origin: ?[]const u8,

    /// The state of the route.
    state: ?[]const u8,

    /// The ID of a transit gateway.
    transit_gateway_id: ?[]const u8,

    /// The ID of a VPC peering connection.
    vpc_peering_connection_id: ?[]const u8,

    pub const json_field_names = .{
        .carrier_gateway_id = "CarrierGatewayId",
        .core_network_arn = "CoreNetworkArn",
        .destination_cidr_block = "DestinationCidrBlock",
        .destination_ipv_6_cidr_block = "DestinationIpv6CidrBlock",
        .destination_prefix_list_id = "DestinationPrefixListId",
        .egress_only_internet_gateway_id = "EgressOnlyInternetGatewayId",
        .gateway_id = "GatewayId",
        .instance_id = "InstanceId",
        .instance_owner_id = "InstanceOwnerId",
        .local_gateway_id = "LocalGatewayId",
        .nat_gateway_id = "NatGatewayId",
        .network_interface_id = "NetworkInterfaceId",
        .origin = "Origin",
        .state = "State",
        .transit_gateway_id = "TransitGatewayId",
        .vpc_peering_connection_id = "VpcPeeringConnectionId",
    };
};
