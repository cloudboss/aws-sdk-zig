const LambdaFunctionConfiguration = @import("lambda_function_configuration.zig").LambdaFunctionConfiguration;
const ResourceCostCalculation = @import("resource_cost_calculation.zig").ResourceCostCalculation;

/// The Lambda function recommendation details.
pub const LambdaFunction = struct {
    /// The Lambda function configuration used for recommendations.
    configuration: ?LambdaFunctionConfiguration,

    /// Cost impact of the recommendation.
    cost_calculation: ?ResourceCostCalculation,

    pub const json_field_names = .{
        .configuration = "configuration",
        .cost_calculation = "costCalculation",
    };
};
