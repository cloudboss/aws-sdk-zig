const Currency = @import("currency.zig").Currency;
const UsageType = @import("usage_type.zig").UsageType;

/// Provides aggregated data for an Amazon Macie usage metric. The value for the
/// metric reports estimated usage data for an account for the preceding 30 days
/// or the current calendar month to date, depending on the time period
/// (timeRange) specified in the request.
pub const UsageTotal = struct {
    /// The type of currency that the value for the metric (estimatedCost) is
    /// reported in.
    currency: ?Currency,

    /// The estimated value for the metric.
    estimated_cost: ?[]const u8,

    /// The name of the metric. Possible values are: AUTOMATED_OBJECT_MONITORING, to
    /// monitor S3 objects for automated sensitive data discovery;
    /// AUTOMATED_SENSITIVE_DATA_DISCOVERY, to analyze S3 objects for automated
    /// sensitive data discovery; DATA_INVENTORY_EVALUATION, to monitor S3 buckets;
    /// and, SENSITIVE_DATA_DISCOVERY, to run classification jobs.
    @"type": ?UsageType,

    pub const json_field_names = .{
        .currency = "currency",
        .estimated_cost = "estimatedCost",
        .@"type" = "type",
    };
};
