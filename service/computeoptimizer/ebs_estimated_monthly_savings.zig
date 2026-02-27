const Currency = @import("currency.zig").Currency;

/// An object that describes the estimated monthly savings possible by adopting
/// Compute Optimizer’s Amazon EBS volume
/// recommendations. This includes any applicable discounts.
pub const EBSEstimatedMonthlySavings = struct {
    /// The currency of the estimated monthly savings.
    currency: ?Currency,

    /// The value of the estimated monthly savings.
    value: f64 = 0,

    pub const json_field_names = .{
        .currency = "currency",
        .value = "value",
    };
};
