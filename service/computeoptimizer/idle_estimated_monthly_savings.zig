const Currency = @import("currency.zig").Currency;

/// Describes the estimated monthly savings possible for idle resources by
/// adopting Compute Optimizer recommendations.
pub const IdleEstimatedMonthlySavings = struct {
    /// The currency of the estimated monthly savings.
    currency: ?Currency = null,

    /// The value of the estimated monthly savings for Idle resources.
    value: f64 = 0,

    pub const json_field_names = .{
        .currency = "currency",
        .value = "value",
    };
};
