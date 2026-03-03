const Currency = @import("currency.zig").Currency;

/// An object that describes the estimated monthly savings possible by adopting
/// Compute Optimizer’s Amazon EC2 instance
/// recommendations. This is based on the Savings Plans and Reserved Instances
/// pricing discounts.
pub const InstanceEstimatedMonthlySavings = struct {
    /// The currency of the estimated monthly savings.
    currency: ?Currency = null,

    /// The value of the estimated monthly savings.
    value: f64 = 0,

    pub const json_field_names = .{
        .currency = "currency",
        .value = "value",
    };
};
