const TargetNetworkTopology = @import("target_network_topology.zig").TargetNetworkTopology;

/// Updated configuration for the target network topology and addressing.
pub const TargetNetworkUpdate = struct {
    /// The updated CIDR block for inbound traffic.
    inbound_cidr: ?[]const u8 = null,

    /// The updated CIDR block for inspection traffic.
    inspection_cidr: ?[]const u8 = null,

    /// The updated CIDR block for outbound traffic.
    outbound_cidr: ?[]const u8 = null,

    /// The updated network topology type.
    topology: ?TargetNetworkTopology = null,

    pub const json_field_names = .{
        .inbound_cidr = "inboundCidr",
        .inspection_cidr = "inspectionCidr",
        .outbound_cidr = "outboundCidr",
        .topology = "topology",
    };
};
