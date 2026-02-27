const BudgetStatus = @import("budget_status.zig").BudgetStatus;
const ConsumedUsages = @import("consumed_usages.zig").ConsumedUsages;
const UsageTrackingResource = @import("usage_tracking_resource.zig").UsageTrackingResource;

/// The budget summary.
pub const BudgetSummary = struct {
    /// The approximate dollar limit of the budget.
    approximate_dollar_limit: f32,

    /// The budget ID.
    budget_id: []const u8,

    /// The date and time the resource was created.
    created_at: i64,

    /// The user or system that created this resource.
    created_by: []const u8,

    /// The description of the budget summary.
    ///
    /// This field can store any content. Escape or encode this content before
    /// displaying it on a webpage or any other system that might interpret the
    /// content of this field.
    description: ?[]const u8,

    /// The display name of the budget summary to update.
    ///
    /// This field can store any content. Escape or encode this content before
    /// displaying it on a webpage or any other system that might interpret the
    /// content of this field.
    display_name: []const u8,

    /// The status of the budget.
    ///
    /// * `ACTIVE`–The budget is being evaluated.
    /// * `INACTIVE`–The budget is inactive. This can include Expired, Canceled, or
    ///   deleted Deleted statuses.
    status: BudgetStatus,

    /// The date and time the resource was updated.
    updated_at: ?i64,

    /// The user or system that updated this resource.
    updated_by: ?[]const u8,

    /// The consumed usage for the budget.
    usages: ConsumedUsages,

    /// The resource used to track expenditure in the budget.
    usage_tracking_resource: UsageTrackingResource,

    pub const json_field_names = .{
        .approximate_dollar_limit = "approximateDollarLimit",
        .budget_id = "budgetId",
        .created_at = "createdAt",
        .created_by = "createdBy",
        .description = "description",
        .display_name = "displayName",
        .status = "status",
        .updated_at = "updatedAt",
        .updated_by = "updatedBy",
        .usages = "usages",
        .usage_tracking_resource = "usageTrackingResource",
    };
};
