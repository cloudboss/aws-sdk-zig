/// Pricing information about a Savings Plans.
pub const SavingsPlansPricing = struct {
    /// Estimated monthly commitment for the Savings Plans.
    estimated_monthly_commitment: ?f64,

    /// Estimated On-Demand cost you will pay after buying the Savings Plans.
    estimated_on_demand_cost: ?f64,

    /// The cost of paying for the recommended Savings Plans monthly.
    monthly_savings_plans_eligible_cost: ?f64,

    /// Estimated savings as a percentage of your overall costs after buying the
    /// Savings Plans.
    savings_percentage: ?f64,

    pub const json_field_names = .{
        .estimated_monthly_commitment = "estimatedMonthlyCommitment",
        .estimated_on_demand_cost = "estimatedOnDemandCost",
        .monthly_savings_plans_eligible_cost = "monthlySavingsPlansEligibleCost",
        .savings_percentage = "savingsPercentage",
    };
};
