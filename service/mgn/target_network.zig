const TargetNetworkTopology = @import("target_network_topology.zig").TargetNetworkTopology;

/// Configuration for the target network topology and addressing.
pub const TargetNetwork = struct {
    /// The CIDR block for inbound traffic in the target network.
    inbound_cidr: ?[]const u8 = null,

    /// The CIDR block for inspection traffic in the target network.
    inspection_cidr: ?[]const u8 = null,

    /// The CIDR block for outbound traffic in the target network.
    outbound_cidr: ?[]const u8 = null,

    /// The network topology type for the target environment.
    topology: TargetNetworkTopology,

    pub const json_field_names = .{
        .inbound_cidr = "inboundCidr",
        .inspection_cidr = "inspectionCidr",
        .outbound_cidr = "outboundCidr",
        .topology = "topology",
    };
};
