const Currency = @import("currency.zig").Currency;

/// Describes the estimated monthly savings possible for DB instances by
/// adopting
/// Compute Optimizer recommendations. This is based on DB instance pricing
/// after applying
/// Savings Plans discounts.
pub const RDSInstanceEstimatedMonthlySavings = struct {
    /// The currency of the estimated monthly savings.
    currency: ?Currency,

    /// The value of the estimated monthly savings for DB instances.
    value: f64 = 0,

    pub const json_field_names = .{
        .currency = "currency",
        .value = "value",
    };
};
