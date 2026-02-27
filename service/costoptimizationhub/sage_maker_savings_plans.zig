const SageMakerSavingsPlansConfiguration = @import("sage_maker_savings_plans_configuration.zig").SageMakerSavingsPlansConfiguration;
const SavingsPlansCostCalculation = @import("savings_plans_cost_calculation.zig").SavingsPlansCostCalculation;

/// The SageMaker Savings Plans recommendation details.
pub const SageMakerSavingsPlans = struct {
    /// The SageMaker Savings Plans configuration used for recommendations.
    configuration: ?SageMakerSavingsPlansConfiguration,

    /// Cost impact of the Savings Plans purchase recommendation.
    cost_calculation: ?SavingsPlansCostCalculation,

    pub const json_field_names = .{
        .configuration = "configuration",
        .cost_calculation = "costCalculation",
    };
};
