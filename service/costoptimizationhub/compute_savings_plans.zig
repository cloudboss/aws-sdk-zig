const ComputeSavingsPlansConfiguration = @import("compute_savings_plans_configuration.zig").ComputeSavingsPlansConfiguration;
const SavingsPlansCostCalculation = @import("savings_plans_cost_calculation.zig").SavingsPlansCostCalculation;

/// The Compute Savings Plans recommendation details.
pub const ComputeSavingsPlans = struct {
    /// Configuration details of the Compute Savings Plans to purchase.
    configuration: ?ComputeSavingsPlansConfiguration,

    /// Cost impact of the Savings Plans purchase recommendation.
    cost_calculation: ?SavingsPlansCostCalculation,

    pub const json_field_names = .{
        .configuration = "configuration",
        .cost_calculation = "costCalculation",
    };
};
