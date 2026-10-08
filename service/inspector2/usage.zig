const CloudProvider = @import("cloud_provider.zig").CloudProvider;
const Currency = @import("currency.zig").Currency;
const UsageType = @import("usage_type.zig").UsageType;

/// Contains usage information about the cost of Amazon Inspector operation.
pub const Usage = struct {
    /// The cloud provider associated with the usage information.
    cloud_provider: ?CloudProvider = null,

    /// The currency type used when calculating usage data.
    currency: ?Currency = null,

    /// The estimated monthly cost of Amazon Inspector.
    estimated_monthly_cost: f64 = 0,

    /// The total of usage.
    total: f64 = 0,

    /// The type scan.
    type: ?UsageType = null,

    pub const json_field_names = .{
        .cloud_provider = "cloudProvider",
        .currency = "currency",
        .estimated_monthly_cost = "estimatedMonthlyCost",
        .total = "total",
        .type = "type",
    };
};
