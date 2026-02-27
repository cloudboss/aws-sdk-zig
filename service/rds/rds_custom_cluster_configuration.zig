const ReplicaMode = @import("replica_mode.zig").ReplicaMode;

/// Reserved for future use.
pub const RdsCustomClusterConfiguration = struct {
    /// Reserved for future use.
    interconnect_subnet_id: ?[]const u8,

    /// Reserved for future use.
    replica_mode: ?ReplicaMode,

    /// Reserved for future use.
    transit_gateway_multicast_domain_id: ?[]const u8,
};
