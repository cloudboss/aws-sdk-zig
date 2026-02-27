const BillingViewType = @import("billing_view_type.zig").BillingViewType;
const Expression = @import("expression.zig").Expression;
const BillingViewHealthStatus = @import("billing_view_health_status.zig").BillingViewHealthStatus;

/// The metadata associated to the billing view.
pub const BillingViewElement = struct {
    /// The Amazon Resource Name (ARN) that can be used to uniquely identify the
    /// billing view.
    arn: ?[]const u8,

    /// The type of billing group.
    billing_view_type: ?BillingViewType,

    /// The time when the billing view was created.
    created_at: ?i64,

    /// See
    /// [Expression](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_billing_Expression.html). Billing view only supports `LINKED_ACCOUNT`, `Tags`, and `CostCategories`.
    data_filter_expression: ?Expression,

    /// The number of billing views that use this billing view as a source.
    derived_view_count: ?i32,

    /// The description of the billing view.
    description: ?[]const u8,

    /// The current health status of the billing view.
    health_status: ?BillingViewHealthStatus,

    /// The account name of the billing view.
    name: ?[]const u8,

    /// The account owner of the billing view.
    owner_account_id: ?[]const u8,

    /// The Amazon Web Services account ID that owns the source billing view, if
    /// this is a derived billing view.
    source_account_id: ?[]const u8,

    /// The number of source views associated with this billing view.
    source_view_count: ?i32,

    /// The time when the billing view was last updated.
    updated_at: ?i64,

    /// The timestamp of when the billing view definition was last updated.
    view_definition_last_updated_at: ?i64,

    pub const json_field_names = .{
        .arn = "arn",
        .billing_view_type = "billingViewType",
        .created_at = "createdAt",
        .data_filter_expression = "dataFilterExpression",
        .derived_view_count = "derivedViewCount",
        .description = "description",
        .health_status = "healthStatus",
        .name = "name",
        .owner_account_id = "ownerAccountId",
        .source_account_id = "sourceAccountId",
        .source_view_count = "sourceViewCount",
        .updated_at = "updatedAt",
        .view_definition_last_updated_at = "viewDefinitionLastUpdatedAt",
    };
};
