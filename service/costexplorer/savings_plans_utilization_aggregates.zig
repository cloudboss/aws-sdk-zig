const SavingsPlansAmortizedCommitment = @import("savings_plans_amortized_commitment.zig").SavingsPlansAmortizedCommitment;
const SavingsPlansSavings = @import("savings_plans_savings.zig").SavingsPlansSavings;
const SavingsPlansUtilization = @import("savings_plans_utilization.zig").SavingsPlansUtilization;

/// The aggregated utilization metrics for your Savings Plans usage.
pub const SavingsPlansUtilizationAggregates = struct {
    /// The total amortized commitment for a Savings Plans. This includes the sum of
    /// the
    /// upfront and recurring Savings Plans fees.
    amortized_commitment: ?SavingsPlansAmortizedCommitment,

    /// The amount that's saved by using existing Savings Plans. Savings returns
    /// both net
    /// savings from Savings Plans and also the `onDemandCostEquivalent` of the
    /// Savings Plans when considering the utilization rate.
    savings: ?SavingsPlansSavings,

    /// A ratio of your effectiveness of using existing Savings Plans to apply to
    /// workloads
    /// that are Savings Plans eligible.
    utilization: SavingsPlansUtilization,

    pub const json_field_names = .{
        .amortized_commitment = "AmortizedCommitment",
        .savings = "Savings",
        .utilization = "Utilization",
    };
};
