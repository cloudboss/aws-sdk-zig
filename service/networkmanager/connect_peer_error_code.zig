pub const ConnectPeerErrorCode = enum {
    edge_location_no_free_ips,
    edge_location_peer_duplicate,
    subnet_not_found,
    ip_outside_subnet_cidr_range,
    invalid_inside_cidr_block,
    no_associated_cidr_block,

    pub const json_field_names = .{
        .edge_location_no_free_ips = "EDGE_LOCATION_NO_FREE_IPS",
        .edge_location_peer_duplicate = "EDGE_LOCATION_PEER_DUPLICATE",
        .subnet_not_found = "SUBNET_NOT_FOUND",
        .ip_outside_subnet_cidr_range = "IP_OUTSIDE_SUBNET_CIDR_RANGE",
        .invalid_inside_cidr_block = "INVALID_INSIDE_CIDR_BLOCK",
        .no_associated_cidr_block = "NO_ASSOCIATED_CIDR_BLOCK",
    };
};
