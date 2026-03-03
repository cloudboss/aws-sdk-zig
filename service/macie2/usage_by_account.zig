const Currency = @import("currency.zig").Currency;
const ServiceLimit = @import("service_limit.zig").ServiceLimit;
const UsageType = @import("usage_type.zig").UsageType;

/// Provides data for a specific usage metric and the corresponding quota for an
/// Amazon Macie account.
pub const UsageByAccount = struct {
    /// The type of currency that the value for the metric (estimatedCost) is
    /// reported in.
    currency: ?Currency = null,

    /// The estimated value for the metric.
    estimated_cost: ?[]const u8 = null,

    /// The current value for the quota that corresponds to the metric specified by
    /// the type field.
    service_limit: ?ServiceLimit = null,

    /// The name of the metric. Possible values are: AUTOMATED_OBJECT_MONITORING, to
    /// monitor S3 objects for automated sensitive data discovery;
    /// AUTOMATED_SENSITIVE_DATA_DISCOVERY, to analyze S3 objects for automated
    /// sensitive data discovery; DATA_INVENTORY_EVALUATION, to monitor S3 buckets;
    /// and, SENSITIVE_DATA_DISCOVERY, to run classification jobs.
    @"type": ?UsageType = null,

    pub const json_field_names = .{
        .currency = "currency",
        .estimated_cost = "estimatedCost",
        .service_limit = "serviceLimit",
        .@"type" = "type",
    };
};
