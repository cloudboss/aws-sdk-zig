pub const PeeringErrorCode = enum {
    transit_gateway_not_found,
    transit_gateway_peers_limit_exceeded,
    missing_required_permissions,
    internal_error,
    edge_location_peer_duplicate,
    invalid_transit_gateway_state,

    pub const json_field_names = .{
        .transit_gateway_not_found = "TRANSIT_GATEWAY_NOT_FOUND",
        .transit_gateway_peers_limit_exceeded = "TRANSIT_GATEWAY_PEERS_LIMIT_EXCEEDED",
        .missing_required_permissions = "MISSING_REQUIRED_PERMISSIONS",
        .internal_error = "INTERNAL_ERROR",
        .edge_location_peer_duplicate = "EDGE_LOCATION_PEER_DUPLICATE",
        .invalid_transit_gateway_state = "INVALID_TRANSIT_GATEWAY_STATE",
    };
};
