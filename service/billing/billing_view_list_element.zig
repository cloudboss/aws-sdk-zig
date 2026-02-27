const BillingViewType = @import("billing_view_type.zig").BillingViewType;
const BillingViewHealthStatus = @import("billing_view_health_status.zig").BillingViewHealthStatus;

/// A representation of a billing view.
pub const BillingViewListElement = struct {
    /// The Amazon Resource Name (ARN) that can be used to uniquely identify the
    /// billing view.
    arn: ?[]const u8,

    /// The type of billing view.
    billing_view_type: ?BillingViewType,

    /// The description of the billing view.
    description: ?[]const u8,

    /// The current health status of the billing view.
    health_status: ?BillingViewHealthStatus,

    /// A list of names of the Billing view.
    name: ?[]const u8,

    /// The list of owners of the Billing view.
    owner_account_id: ?[]const u8,

    /// The Amazon Web Services account ID that owns the source billing view, if
    /// this is a derived billing view.
    source_account_id: ?[]const u8,

    pub const json_field_names = .{
        .arn = "arn",
        .billing_view_type = "billingViewType",
        .description = "description",
        .health_status = "healthStatus",
        .name = "name",
        .owner_account_id = "ownerAccountId",
        .source_account_id = "sourceAccountId",
    };
};
