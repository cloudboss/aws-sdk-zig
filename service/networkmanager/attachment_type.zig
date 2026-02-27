pub const AttachmentType = enum {
    connect,
    site_to_site_vpn,
    vpc,
    direct_connect_gateway,
    transit_gateway_route_table,

    pub const json_field_names = .{
        .connect = "CONNECT",
        .site_to_site_vpn = "SITE_TO_SITE_VPN",
        .vpc = "VPC",
        .direct_connect_gateway = "DIRECT_CONNECT_GATEWAY",
        .transit_gateway_route_table = "TRANSIT_GATEWAY_ROUTE_TABLE",
    };
};
