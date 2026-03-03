const CurrencyCode = @import("currency_code.zig").CurrencyCode;
const HistoricalUsageEntity = @import("historical_usage_entity.zig").HistoricalUsageEntity;
const WorkloadEstimateUsageQuantity = @import("workload_estimate_usage_quantity.zig").WorkloadEstimateUsageQuantity;
const WorkloadEstimateCostStatus = @import("workload_estimate_cost_status.zig").WorkloadEstimateCostStatus;

/// Represents a usage item in a workload estimate.
pub const WorkloadEstimateUsageItem = struct {
    /// The estimated cost for this usage item.
    cost: ?f64 = null,

    /// The currency of the estimated cost.
    currency: ?CurrencyCode = null,

    /// The group identifier for this usage item.
    group: ?[]const u8 = null,

    /// Historical usage data associated with this item, if available.
    historical_usage: ?HistoricalUsageEntity = null,

    /// The unique identifier of this usage item.
    id: ?[]const u8 = null,

    /// The location associated with this usage item.
    location: ?[]const u8 = null,

    /// The specific operation associated with this usage item.
    operation: []const u8,

    /// The estimated usage quantity for this item.
    quantity: ?WorkloadEstimateUsageQuantity = null,

    /// The Amazon Web Services service code associated with this usage item.
    service_code: []const u8,

    /// The current status of this usage item.
    status: ?WorkloadEstimateCostStatus = null,

    /// The Amazon Web Services account ID associated with this usage item.
    usage_account_id: ?[]const u8 = null,

    /// The type of usage for this item.
    usage_type: []const u8,

    pub const json_field_names = .{
        .cost = "cost",
        .currency = "currency",
        .group = "group",
        .historical_usage = "historicalUsage",
        .id = "id",
        .location = "location",
        .operation = "operation",
        .quantity = "quantity",
        .service_code = "serviceCode",
        .status = "status",
        .usage_account_id = "usageAccountId",
        .usage_type = "usageType",
    };
};
