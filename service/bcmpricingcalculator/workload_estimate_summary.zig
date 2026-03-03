const CurrencyCode = @import("currency_code.zig").CurrencyCode;
const WorkloadEstimateRateType = @import("workload_estimate_rate_type.zig").WorkloadEstimateRateType;
const WorkloadEstimateStatus = @import("workload_estimate_status.zig").WorkloadEstimateStatus;

/// Provides a summary of a workload estimate.
pub const WorkloadEstimateSummary = struct {
    /// The currency of the estimated cost.
    cost_currency: ?CurrencyCode = null,

    /// The timestamp when the workload estimate was created.
    created_at: ?i64 = null,

    /// The timestamp when the workload estimate will expire.
    expires_at: ?i64 = null,

    /// An error message if the workload estimate creation or processing failed.
    failure_message: ?[]const u8 = null,

    /// The unique identifier of the workload estimate.
    id: []const u8,

    /// The name of the workload estimate.
    name: ?[]const u8 = null,

    /// The timestamp of the pricing rates used for the estimate.
    rate_timestamp: ?i64 = null,

    /// The type of pricing rates used for the estimate.
    rate_type: ?WorkloadEstimateRateType = null,

    /// The current status of the workload estimate.
    status: ?WorkloadEstimateStatus = null,

    /// The total estimated cost for the workload.
    total_cost: ?f64 = null,

    pub const json_field_names = .{
        .cost_currency = "costCurrency",
        .created_at = "createdAt",
        .expires_at = "expiresAt",
        .failure_message = "failureMessage",
        .id = "id",
        .name = "name",
        .rate_timestamp = "rateTimestamp",
        .rate_type = "rateType",
        .status = "status",
        .total_cost = "totalCost",
    };
};
