const CostAmount = @import("cost_amount.zig").CostAmount;
const UsageQuantityResult = @import("usage_quantity_result.zig").UsageQuantityResult;

/// Provides a summary of a line item in a bill estimate.
pub const BillEstimateLineItemSummary = struct {
    /// The availability zone associated with this line item, if applicable.
    availability_zone: ?[]const u8 = null,

    /// The estimated cost for this line item.
    estimated_cost: ?CostAmount = null,

    /// The estimated usage quantity for this line item.
    estimated_usage_quantity: ?UsageQuantityResult = null,

    /// The historical cost for this line item.
    historical_cost: ?CostAmount = null,

    /// The historical usage quantity for this line item.
    historical_usage_quantity: ?UsageQuantityResult = null,

    /// The unique identifier of this line item.
    id: ?[]const u8 = null,

    /// The line item identifier from the original bill.
    line_item_id: ?[]const u8 = null,

    /// The type of this line item (e.g., Usage, Tax, Credit).
    line_item_type: ?[]const u8 = null,

    /// The location associated with this line item.
    location: ?[]const u8 = null,

    /// The specific operation associated with this line item.
    operation: []const u8,

    /// The Amazon Web Services account ID of the payer for this line item.
    payer_account_id: ?[]const u8 = null,

    /// The Amazon Resource Names (ARNs) of any Savings Plans applied to this line
    /// item.
    savings_plan_arns: ?[]const []const u8 = null,

    /// The Amazon Web Services service code associated with this line item.
    service_code: []const u8,

    /// The Amazon Web Services account ID associated with the usage for this line
    /// item.
    usage_account_id: ?[]const u8 = null,

    /// The type of usage for this line item.
    usage_type: []const u8,

    pub const json_field_names = .{
        .availability_zone = "availabilityZone",
        .estimated_cost = "estimatedCost",
        .estimated_usage_quantity = "estimatedUsageQuantity",
        .historical_cost = "historicalCost",
        .historical_usage_quantity = "historicalUsageQuantity",
        .id = "id",
        .line_item_id = "lineItemId",
        .line_item_type = "lineItemType",
        .location = "location",
        .operation = "operation",
        .payer_account_id = "payerAccountId",
        .savings_plan_arns = "savingsPlanArns",
        .service_code = "serviceCode",
        .usage_account_id = "usageAccountId",
        .usage_type = "usageType",
    };
};
