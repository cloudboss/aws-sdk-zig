const Currency = @import("currency.zig").Currency;

/// Describes the estimated monthly savings possible for DB instance storage by
/// adopting Compute Optimizer
/// recommendations. This is based on DB instance pricing after applying Savings
/// Plans discounts.
pub const RDSStorageEstimatedMonthlySavings = struct {
    /// The currency of the estimated monthly savings.
    currency: ?Currency,

    /// The value of the estimated monthly savings for DB instance storage.
    value: f64 = 0,

    pub const json_field_names = .{
        .currency = "currency",
        .value = "value",
    };
};
