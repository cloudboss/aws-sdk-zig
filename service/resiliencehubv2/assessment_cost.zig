const CostCurrency = @import("cost_currency.zig").CostCurrency;

/// Represents the cost of running a failure mode assessment.
pub const AssessmentCost = struct {
    /// The cost amount for the assessment.
    amount: ?f64 = null,

    /// The currency of the assessment cost.
    currency: ?CostCurrency = null,

    pub const json_field_names = .{
        .amount = "amount",
        .currency = "currency",
    };
};
