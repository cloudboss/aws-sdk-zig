pub const TargetType = enum {
    gateway,
    carrier_gateway,
    instance,
    local_gateway,
    nat_gateway,
    network_interface,
    vpc_endpoint,
    vpc_peering_connection,
    egress_only_internet_gateway,
    transit_gateway,

    pub const json_field_names = .{
        .gateway = "Gateway",
        .carrier_gateway = "CarrierGateway",
        .instance = "Instance",
        .local_gateway = "LocalGateway",
        .nat_gateway = "NatGateway",
        .network_interface = "NetworkInterface",
        .vpc_endpoint = "VPCEndpoint",
        .vpc_peering_connection = "VPCPeeringConnection",
        .egress_only_internet_gateway = "EgressOnlyInternetGateway",
        .transit_gateway = "TransitGateway",
    };
};
