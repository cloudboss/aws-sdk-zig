const Network = @import("network.zig").Network;
const TriangulationEventType = @import("triangulation_event_type.zig").TriangulationEventType;

/// Information about the network impairment for a specific network measured by
/// Amazon CloudWatch Internet Monitor.
pub const NetworkImpairment = struct {
    /// The combination of the Autonomous System Number (ASN) of the network and the
    /// name of the network.
    as_path: []const Network,

    /// The type of network impairment.
    network_event_type: TriangulationEventType,

    /// The networks that could be impacted by a network impairment event.
    networks: []const Network,

    pub const json_field_names = .{
        .as_path = "AsPath",
        .network_event_type = "NetworkEventType",
        .networks = "Networks",
    };
};
