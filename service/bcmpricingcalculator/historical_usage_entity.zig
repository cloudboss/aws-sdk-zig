const BillInterval = @import("bill_interval.zig").BillInterval;
const Expression = @import("expression.zig").Expression;

/// Represents historical usage data for a specific entity.
pub const HistoricalUsageEntity = struct {
    /// The time interval for the historical usage data.
    bill_interval: BillInterval,

    /// An optional filter expression to apply to the historical usage data.
    filter_expression: Expression,

    /// The location associated with the usage.
    location: ?[]const u8,

    /// The specific operation associated with the usage.
    operation: []const u8,

    /// The Amazon Web Services service code associated with the usage.
    service_code: []const u8,

    /// The Amazon Web Services account ID associated with the usage.
    usage_account_id: []const u8,

    /// The type of usage.
    usage_type: []const u8,

    pub const json_field_names = .{
        .bill_interval = "billInterval",
        .filter_expression = "filterExpression",
        .location = "location",
        .operation = "operation",
        .service_code = "serviceCode",
        .usage_account_id = "usageAccountId",
        .usage_type = "usageType",
    };
};
