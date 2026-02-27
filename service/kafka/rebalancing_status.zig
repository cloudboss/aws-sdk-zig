/// Intelligent rebalancing status. The default intelligent rebalancing status
/// is ACTIVE for all new Express-based clusters.
pub const RebalancingStatus = enum {
    paused,
    active,

    pub const json_field_names = .{
        .paused = "PAUSED",
        .active = "ACTIVE",
    };
};
