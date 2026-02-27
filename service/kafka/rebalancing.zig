const RebalancingStatus = @import("rebalancing_status.zig").RebalancingStatus;

/// Specifies whether or not intelligent rebalancing is turned on for a newly
/// created MSK Provisioned cluster with Express brokers. Intelligent
/// rebalancing performs automatic partition balancing operations when you scale
/// your clusters up or down. By default, intelligent rebalancing is ACTIVE for
/// all new Express-based clusters.
pub const Rebalancing = struct {
    /// Intelligent rebalancing status. The default intelligent rebalancing status
    /// is ACTIVE for all new Express-based clusters.
    status: ?RebalancingStatus,

    pub const json_field_names = .{
        .status = "Status",
    };
};
