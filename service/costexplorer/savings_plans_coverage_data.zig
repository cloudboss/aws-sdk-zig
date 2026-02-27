/// Specific coverage percentage, On-Demand costs, and spend covered by Savings
/// Plans, and
/// total Savings Plans costs for an account.
pub const SavingsPlansCoverageData = struct {
    /// The percentage of your existing Savings Plans covered usage, divided by all
    /// of your
    /// eligible Savings Plans usage in an account (or set of accounts).
    coverage_percentage: ?[]const u8,

    /// The cost of your Amazon Web Services usage at the public On-Demand rate.
    on_demand_cost: ?[]const u8,

    /// The amount of your Amazon Web Services usage that's covered by a Savings
    /// Plans.
    spend_covered_by_savings_plans: ?[]const u8,

    /// The total cost of your Amazon Web Services usage, regardless of your
    /// purchase
    /// option.
    total_cost: ?[]const u8,

    pub const json_field_names = .{
        .coverage_percentage = "CoveragePercentage",
        .on_demand_cost = "OnDemandCost",
        .spend_covered_by_savings_plans = "SpendCoveredBySavingsPlans",
        .total_cost = "TotalCost",
    };
};
