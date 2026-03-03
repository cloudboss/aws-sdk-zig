const CurrencyCode = @import("currency_code.zig").CurrencyCode;
const HistoricalUsageEntity = @import("historical_usage_entity.zig").HistoricalUsageEntity;
const WorkloadEstimateUsageQuantity = @import("workload_estimate_usage_quantity.zig").WorkloadEstimateUsageQuantity;
const WorkloadEstimateCostStatus = @import("workload_estimate_cost_status.zig").WorkloadEstimateCostStatus;

/// Represents a successfully created item in a batch operation for workload
/// estimate usage.
pub const BatchCreateWorkloadEstimateUsageItem = struct {
    /// The estimated cost associated with this usage.
    cost: ?f64 = null,

    /// The currency of the estimated cost.
    currency: ?CurrencyCode = null,

    /// The group identifier for the created usage estimate.
    group: ?[]const u8 = null,

    /// Historical usage data associated with this estimate, if available.
    historical_usage: ?HistoricalUsageEntity = null,

    /// The unique identifier assigned to the created usage estimate.
    id: ?[]const u8 = null,

    /// The key of the successfully created entry.
    key: ?[]const u8 = null,

    /// The location associated with this usage estimate.
    location: ?[]const u8 = null,

    /// The specific operation associated with this usage estimate.
    operation: []const u8,

    /// The estimated usage quantity.
    quantity: ?WorkloadEstimateUsageQuantity = null,

    /// The Amazon Web Services service code for this usage estimate.
    service_code: []const u8,

    /// The current status of the created usage estimate.
    status: ?WorkloadEstimateCostStatus = null,

    /// The Amazon Web Services account ID associated with the created usage
    /// estimate.
    usage_account_id: ?[]const u8 = null,

    /// The type of usage that was estimated.
    usage_type: []const u8,

    pub const json_field_names = .{
        .cost = "cost",
        .currency = "currency",
        .group = "group",
        .historical_usage = "historicalUsage",
        .id = "id",
        .key = "key",
        .location = "location",
        .operation = "operation",
        .quantity = "quantity",
        .service_code = "serviceCode",
        .status = "status",
        .usage_account_id = "usageAccountId",
        .usage_type = "usageType",
    };
};
