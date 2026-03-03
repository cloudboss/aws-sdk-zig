const OriginationRouteProtocol = @import("origination_route_protocol.zig").OriginationRouteProtocol;

/// Origination routes define call distribution properties for your SIP hosts to
/// receive inbound calls using an Amazon Chime SDK Voice Connector. Limit: Ten
/// origination
/// routes for each Voice Connector.
///
/// The parameters listed below are not required, but you must use at least one.
pub const OriginationRoute = struct {
    /// The FQDN or IP address to contact for origination traffic.
    host: ?[]const u8 = null,

    /// The designated origination route port. Defaults to 5060.
    port: ?i32 = null,

    /// The priority associated with the host, with 1 being the highest priority.
    /// Higher
    /// priority hosts are attempted first.
    priority: ?i32 = null,

    /// The protocol to use for the origination route. Encryption-enabled Amazon
    /// Chime SDK Voice Connectors use
    /// TCP protocol by default.
    protocol: ?OriginationRouteProtocol = null,

    /// The weight assigned to an origination route. When hosts have equal priority,
    /// calls are distributed between them based on their relative weights.
    weight: ?i32 = null,

    pub const json_field_names = .{
        .host = "Host",
        .port = "Port",
        .priority = "Priority",
        .protocol = "Protocol",
        .weight = "Weight",
    };
};
