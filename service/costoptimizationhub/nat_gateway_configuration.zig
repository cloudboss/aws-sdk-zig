/// The NAT Gateway configuration used for recommendations.
pub const NatGatewayConfiguration = struct {
    /// The number of active connections through the NAT Gateway.
    active_connection_count: ?i64 = null,

    /// The number of packets received from the destination through the NAT Gateway.
    packets_in_from_destination: ?i64 = null,

    /// The number of packets received from the source through the NAT Gateway.
    packets_in_from_source: ?i64 = null,

    pub const json_field_names = .{
        .active_connection_count = "activeConnectionCount",
        .packets_in_from_destination = "packetsInFromDestination",
        .packets_in_from_source = "packetsInFromSource",
    };
};
