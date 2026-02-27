const Currency = @import("currency.zig").Currency;
const UsageType = @import("usage_type.zig").UsageType;

/// Contains usage information about the cost of Amazon Inspector operation.
pub const Usage = struct {
    /// The currency type used when calculating usage data.
    currency: ?Currency,

    /// The estimated monthly cost of Amazon Inspector.
    estimated_monthly_cost: f64 = 0,

    /// The total of usage.
    total: f64 = 0,

    /// The type scan.
    type: ?UsageType,

    pub const json_field_names = .{
        .currency = "currency",
        .estimated_monthly_cost = "estimatedMonthlyCost",
        .total = "total",
        .type = "type",
    };
};
