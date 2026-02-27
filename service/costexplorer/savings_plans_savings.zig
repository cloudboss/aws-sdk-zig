/// The amount of savings that you're accumulating, against the public On-Demand
/// rate of
/// the usage accrued in an account.
pub const SavingsPlansSavings = struct {
    /// The savings amount that you're accumulating for the usage that's covered by
    /// a Savings
    /// Plans, when compared to the On-Demand equivalent of the same usage.
    net_savings: ?[]const u8,

    /// How much the amount that the usage would have cost if it was accrued at the
    /// On-Demand
    /// rate.
    on_demand_cost_equivalent: ?[]const u8,

    pub const json_field_names = .{
        .net_savings = "NetSavings",
        .on_demand_cost_equivalent = "OnDemandCostEquivalent",
    };
};
