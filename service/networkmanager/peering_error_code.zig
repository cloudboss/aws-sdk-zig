const std = @import("std");

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
        .missing_required_permissions = "MISSING_PERMISSIONS",
        .internal_error = "INTERNAL_ERROR",
        .edge_location_peer_duplicate = "EDGE_LOCATION_PEER_DUPLICATE",
        .invalid_transit_gateway_state = "INVALID_TRANSIT_GATEWAY_STATE",
    };

    pub fn wireName(self: @This()) []const u8 {
        return switch (self) {
            .transit_gateway_not_found => "TRANSIT_GATEWAY_NOT_FOUND",
            .transit_gateway_peers_limit_exceeded => "TRANSIT_GATEWAY_PEERS_LIMIT_EXCEEDED",
            .missing_required_permissions => "MISSING_PERMISSIONS",
            .internal_error => "INTERNAL_ERROR",
            .edge_location_peer_duplicate => "EDGE_LOCATION_PEER_DUPLICATE",
            .invalid_transit_gateway_state => "INVALID_TRANSIT_GATEWAY_STATE",
        };
    }

    pub fn fromWireName(str: []const u8) ?@This() {
        inline for (std.meta.fields(@TypeOf(json_field_names))) |field| {
            if (std.mem.eql(u8, str, @field(json_field_names, field.name))) {
                return @field(@This(), field.name);
            }
        }
        return std.meta.stringToEnum(@This(), str);
    }
};
