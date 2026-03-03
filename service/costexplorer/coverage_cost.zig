/// How much it costs to run an instance.
pub const CoverageCost = struct {
    /// How much an On-Demand Instance costs.
    on_demand_cost: ?[]const u8 = null,

    pub const json_field_names = .{
        .on_demand_cost = "OnDemandCost",
    };
};
