const SavingsEstimationMode = @import("savings_estimation_mode.zig").SavingsEstimationMode;

/// Contains information about estimated monthly cost savings.
pub const EstimatedMonthlySavings = struct {
    /// The estimated monthly savings after applying any discounts.
    after_discount_savings: f64,

    /// The estimated monthly savings before applying any discounts.
    before_discount_savings: f64,

    /// The currency of the estimated savings.
    currency: []const u8,

    /// The mode used to calculate savings, either BeforeDiscount or AfterDiscount.
    savings_estimation_mode: SavingsEstimationMode,

    pub const json_field_names = .{
        .after_discount_savings = "afterDiscountSavings",
        .before_discount_savings = "beforeDiscountSavings",
        .currency = "currency",
        .savings_estimation_mode = "savingsEstimationMode",
    };
};
