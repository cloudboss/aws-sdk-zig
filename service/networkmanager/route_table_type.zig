pub const RouteTableType = enum {
    transit_gateway_route_table,
    core_network_segment,
    network_function_group,

    pub const json_field_names = .{
        .transit_gateway_route_table = "TRANSIT_GATEWAY_ROUTE_TABLE",
        .core_network_segment = "CORE_NETWORK_SEGMENT",
        .network_function_group = "NETWORK_FUNCTION_GROUP",
    };
};
