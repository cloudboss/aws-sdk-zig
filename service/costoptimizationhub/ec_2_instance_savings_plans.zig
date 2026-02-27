const Ec2InstanceSavingsPlansConfiguration = @import("ec_2_instance_savings_plans_configuration.zig").Ec2InstanceSavingsPlansConfiguration;
const SavingsPlansCostCalculation = @import("savings_plans_cost_calculation.zig").SavingsPlansCostCalculation;

/// The EC2 instance Savings Plans recommendation details.
pub const Ec2InstanceSavingsPlans = struct {
    /// The EC2 instance Savings Plans configuration used for recommendations.
    configuration: ?Ec2InstanceSavingsPlansConfiguration,

    /// Cost impact of the Savings Plans purchase recommendation.
    cost_calculation: ?SavingsPlansCostCalculation,

    pub const json_field_names = .{
        .configuration = "configuration",
        .cost_calculation = "costCalculation",
    };
};
