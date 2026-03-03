const Currency = @import("currency.zig").Currency;

/// Describes the estimated monthly savings possible for Amazon ECS services by
/// adopting Compute Optimizer recommendations.
/// This is based on Amazon ECS service pricing after applying Savings Plans
/// discounts.
pub const ECSEstimatedMonthlySavings = struct {
    /// The currency of the estimated monthly savings.
    currency: ?Currency = null,

    /// The value of the estimated monthly savings for Amazon ECS services.
    value: f64 = 0,

    pub const json_field_names = .{
        .currency = "currency",
        .value = "value",
    };
};
