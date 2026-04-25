const Currency = @import("currency.zig").Currency;

/// An object that describes the estimated monthly savings possible by adopting
/// Compute Optimizer’s Auto Scaling group recommendations. This is based on the
/// Savings Plans and Reserved Instances discounts.
pub const AutoScalingGroupEstimatedMonthlySavings = struct {
    /// The currency of the estimated monthly savings.
    currency: ?Currency = null,

    /// The value of the estimated monthly savings.
    value: f64 = 0,

    pub const json_field_names = .{
        .currency = "currency",
        .value = "value",
    };
};
