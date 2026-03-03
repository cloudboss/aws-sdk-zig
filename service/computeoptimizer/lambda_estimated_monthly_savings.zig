const Currency = @import("currency.zig").Currency;

/// Describes the estimated monthly savings possible for Lambda functions by
/// adopting Compute Optimizer recommendations. This is based
/// on Lambda functions pricing after applying Savings Plans discounts.
pub const LambdaEstimatedMonthlySavings = struct {
    /// The currency of the estimated monthly savings.
    currency: ?Currency = null,

    /// The value of the estimated monthly savings.
    value: f64 = 0,

    pub const json_field_names = .{
        .currency = "currency",
        .value = "value",
    };
};
