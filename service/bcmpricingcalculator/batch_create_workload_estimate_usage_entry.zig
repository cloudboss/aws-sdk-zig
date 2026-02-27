const HistoricalUsageEntity = @import("historical_usage_entity.zig").HistoricalUsageEntity;

/// Represents an entry in a batch operation to create workload estimate usage.
pub const BatchCreateWorkloadEstimateUsageEntry = struct {
    /// The estimated usage amount.
    amount: f64,

    /// An optional group identifier for the usage estimate.
    group: ?[]const u8,

    /// Historical usage data associated with this estimate, if available.
    historical_usage: ?HistoricalUsageEntity,

    /// A unique identifier for this entry in the batch operation.
    key: []const u8,

    /// The specific operation associated with this usage estimate.
    operation: []const u8,

    /// The Amazon Web Services service code for this usage estimate.
    service_code: []const u8,

    /// The Amazon Web Services account ID associated with this usage estimate.
    usage_account_id: []const u8,

    /// The type of usage being estimated.
    usage_type: []const u8,

    pub const json_field_names = .{
        .amount = "amount",
        .group = "group",
        .historical_usage = "historicalUsage",
        .key = "key",
        .operation = "operation",
        .service_code = "serviceCode",
        .usage_account_id = "usageAccountId",
        .usage_type = "usageType",
    };
};
