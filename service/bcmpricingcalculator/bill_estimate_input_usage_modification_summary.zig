const HistoricalUsageEntity = @import("historical_usage_entity.zig").HistoricalUsageEntity;
const UsageQuantity = @import("usage_quantity.zig").UsageQuantity;

/// Summarizes an input usage modification for a bill estimate.
pub const BillEstimateInputUsageModificationSummary = struct {
    /// The availability zone associated with this usage modification, if
    /// applicable.
    availability_zone: ?[]const u8 = null,

    /// The group identifier for the usage modification.
    group: ?[]const u8 = null,

    /// Historical usage data associated with this modification, if available.
    historical_usage: ?HistoricalUsageEntity = null,

    /// The unique identifier of the usage modification.
    id: ?[]const u8 = null,

    /// The location associated with this usage modification.
    location: ?[]const u8 = null,

    /// The specific operation associated with this usage modification.
    operation: []const u8,

    /// The modified usage quantities.
    quantities: ?[]const UsageQuantity = null,

    /// The Amazon Web Services service code for this usage modification.
    service_code: []const u8,

    /// The Amazon Web Services account ID associated with this usage modification.
    usage_account_id: ?[]const u8 = null,

    /// The type of usage being modified.
    usage_type: []const u8,

    pub const json_field_names = .{
        .availability_zone = "availabilityZone",
        .group = "group",
        .historical_usage = "historicalUsage",
        .id = "id",
        .location = "location",
        .operation = "operation",
        .quantities = "quantities",
        .service_code = "serviceCode",
        .usage_account_id = "usageAccountId",
        .usage_type = "usageType",
    };
};
